-- | Dijkstra's algorithm
module Dijkstra
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

dijkstra :: Node a => a -> ([a], Int)
dijkstra start = expand prev0 dist0 goals0 queue0
  where
    prev0 = Map.singleton start start
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
            dist' = Map.insert v thisDist dist
            prev' = Map.insert v n prev
            queue' = PQ.insert (thisDist, v) queue
                in if thisDist < prevDist then (prev', dist', queue') else (prev, dist, queue)

    reconstruct prev dist goals = (path, cost)
      where
        path = reverse $ backtrack goal

        backtrack n
          | n == start = [n]
          | otherwise = let p = prev Map.! n in n : backtrack p

        (cost, goal) = minimumOn fst [ (dist Map.! v, v) | v <- toList goals ]
