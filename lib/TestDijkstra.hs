import Control.Monad

import Dijkstra

s = 1000

data N = N !Int !Int
    deriving (Show, Eq, Ord)

test = dijkstra rule (N 0 0)
  where
    rule :: N -> Result N
    rule (N x0 y0)
      | x0 == s && y0 == s = Goal
      | otherwise = Adj $ do
          dx <- [-1, 0, 1]
          dy <- [-1, 0, 1]
          guard $ dx /= 0 || dy /= 0
          let (x, y) = (x0 + dx, y0 + dy)
          guard $ x >= 0 && x <= s && y >= 0 && y <= s
          let d = if y < 15 && x > 2 then 4 else 1 -- Encourage L-shaped path
          pure (N x y, d)

main = print $ snd test
