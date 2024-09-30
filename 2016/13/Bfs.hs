-- | Breadth-first graph search
module Bfs
( Node(..)
, bfs
)
where

import Data.Map qualified as Map
import Data.Sequence qualified as Seq

-- | Generic representation of a node in the graph
class Ord a => Node a where
    -- | True if this node represents the goal which terminates the search
    isGoal :: a -> Bool

    -- | A list of nodes adjacent to this node
    adjacent :: a -> [a]

-- | Find the shortest path from 'start' to the goal. The path is returned in reverse order.
bfs :: Node a => a -> [a]
bfs start = search (Map.singleton start start) (Seq.singleton start)
  where
    search parents Seq.Empty = []
    search parents (v Seq.:<| queue)
       | isGoal v = reconstruct parents v
       | otherwise = populate parents queue v (adjacent v)

    populate parents queue v [] = search parents queue
    populate parents queue v (w:ws)
       | w `Map.member` parents = populate parents queue v ws
       | otherwise = populate (Map.insert w v parents) (queue Seq.:|> w) v ws

    reconstruct parents last
       | last == start = [start]
       | otherwise = let p = parents Map.! last in last : reconstruct parents p
