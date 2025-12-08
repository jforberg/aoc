-- | Dijkstra's algorithm
module Dijkstra
( Result(..)
, dijkstra
)
where

import Data.List
import Data.List.Extra
import Data.Foldable
import Data.Map.Strict qualified as Map
import Data.PQueue.Min qualified as PQ
import Data.Set qualified as Set

data Result a = Goal | Adj [(a, Double)]
    deriving (Show, Eq)

{-# INLINE dijkstra #-}
dijkstra :: Ord a => (a -> Result a) -> a -> ([a], Double)
dijkstra rule start = expand prev0 dist0 goals0 queue0
  where
    prev0 = Map.singleton start start
    dist0 = Map.singleton start 0
    goals0 = Set.empty
    queue0 = PQ.singleton (start, 0)

    expand prev dist goals PQ.Empty = reconstruct prev dist goals
    expand prev dist goals ((n, _) PQ.:< queue) = expand prev' dist' goals' queue'
      where
        (prev', dist', queue') = foldr process (prev, dist, queue) neighbours

        (neighbours, goals') = case rule n of
            Goal -> ([], n `Set.insert` goals)
            Adj ns -> (ns, goals)

        distN = dist Map.! n

        process (v, c) (prev, dist, queue) = let
            prevDist = Map.findWithDefault infinity v dist
            thisDist = distN + c
            dist' = Map.insert v thisDist dist
            prev' = Map.insert v n prev
            queue' = PQ.insert (v, thisDist) queue
                in if thisDist < prevDist then (prev', dist', queue') else (prev, dist, queue)

    reconstruct prev dist goals = (path, cost)
      where
        path = reverse $ backtrack goal

        backtrack n
          | n == start = [n]
          | otherwise = let p = prev Map.! n in n : backtrack p

        (cost, goal) = minimumOn fst [ (dist Map.! v, v) | v <- toList goals ]

    infinity = 1 / 0
