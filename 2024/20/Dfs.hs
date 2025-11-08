module Dfs
( Result(..)
, dfsAll
)
where

import Data.Set qualified as S

data Result n = Goal | Adj [n]

dfsAll :: Ord c => (Int -> n -> Result n) -> (n -> c) -> n -> [(Int, n)]
dfsAll rule desc start = go [(0, S.empty, start)]
  where
    go [] = []
    go ((!l, s, n):rest)
      | desc n `S.member` s = go rest
      | otherwise = case rule l n of
            Goal -> (l, n) : go rest
            Adj as -> go (((l + 1, desc n `S.insert` s,) <$> as) <> rest)
