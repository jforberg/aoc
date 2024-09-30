-- | Breadth-first graph search
module Bfs2
( Node(..)
, bfs
)
where

import Data.Map qualified as Map
import Data.Sequence qualified as Seq

-- | Generic representation of a node in the graph
class Ord a => Node a where
    -- | A list of nodes adjacent to this node
    adjacent :: a -> [a]

bfs start = search (Map.singleton start start) (Seq.singleton (start, 0))
  where
    search parents Seq.Empty = Map.keys parents
    search parents ((v, d) Seq.:<| queue) = populate parents queue v d (adjacent v)

    populate parents queue v _ [] = search parents queue
    populate parents queue v d (w:ws)
       | d >= 50 || w `Map.member` parents = populate parents queue v d ws
       | otherwise = populate (Map.insert w v parents) (queue Seq.:|> (w, d + 1)) v d ws
