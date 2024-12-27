{-# LANGUAGE MultiWayIf #-}

-- | Dijkstra's algorithm
module Dijkstra2
( Node(..)
, dijkstra
)
where

import Data.List
import Data.List.Extra
import Data.Foldable
import Data.Map.Strict qualified as Map
import Data.PQueue.Min qualified as PQ
import Data.Set qualified as Set

class Ord a => Node a where
    adjacent :: a -> [(Int, a)]
    isGoal :: a -> Bool

dijkstra :: Node a => a -> [a]
dijkstra start = expand prev0 dist0 goals0 queue0
  where
    prev0 = Map.empty
    dist0 = Map.singleton start 0
    goals0 = Set.empty
    queue0 = PQ.singleton (0, start)

    expand prev dist goals PQ.Empty = reconstruct prev dist goals
    expand prev dist goals ((_, n) PQ.:< queue) = expand prev' dist' goals' queue'
      where
        (prev', dist', queue') = foldr process (prev, dist, queue) neighbours
        neighbours = adjacent n
        distN = dist Map.! n
        goals' = if isGoal n then n `Set.insert` goals else goals

        process (c, v) (prev, dist, queue) = let
            prevDist = Map.findWithDefault maxBound v dist
            thisDist = distN + c
            dist' = if thisDist < prevDist then Map.insert v thisDist dist else dist
            prev' = if
              | thisDist < prevDist -> Map.insert v (Set.singleton n) prev
              | thisDist == prevDist -> Map.adjust (Set.insert n) v prev
              | otherwise -> prev
            queue' = if thisDist < prevDist then PQ.insert (thisDist, v) queue else queue
                in (prev', dist', queue')

    reconstruct prev dist goals = nubOrd $ concat $ backtrack <$> toList goals
      where
        backtrack n
          | n == start = [n]
          | otherwise = do
                p <- toList $ prev Map.! n
                n : backtrack p
