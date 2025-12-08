-- | Breadth-first graph search
module Bfs
( Result(..)
, bfs
)
where

import Data.Map qualified as Map
import Data.Sequence qualified as Seq

data Result n = Goal | Adj [n]
    deriving (Show, Eq)

-- | Find the shortest path from 'start' to the goal. The path is returned in reverse order.
{-# INLINE bfs #-}
bfs :: Ord n => (n -> Result n) -> n -> [n]
bfs rule start = search (Map.singleton start start) (Seq.singleton start)
  where
    search parents Seq.Empty = []
    search parents (v Seq.:<| queue) = case rule v of
        Goal -> reconstruct parents v
        Adj as -> populate parents queue v as

    populate parents queue v [] = search parents queue
    populate parents queue v (w:ws)
      | w `Map.member` parents = populate parents queue v ws
      | otherwise = populate (Map.insert w v parents) (queue Seq.:|> w) v ws

    reconstruct parents last
      | last == start = [start]
      | otherwise = let p = parents Map.! last in last : reconstruct parents p
