import Data.Map.Strict qualified as M
import Control.Monad
import Debug.Trace

inp = 361527

spiral = go (M.singleton (0, 0) 1) indices
  where
    go :: M.Map (Int, Int) Int -> [(Int, Int)] -> Int
    go m (c:cs) = let v = localSum m c in if v > inp then v else go (M.insert c v m) cs

indices = go (0, 0) $ path 1
  where
    go (!x, !y) ((dx, dy):rest) = let c = (x + dx, y + dy) in c : go c rest

path l = right : replicate l up <> replicate (l + 1) left <> replicate (l + 1) down <>
    replicate (l + 1) right <> path (l + 2)
  where
    right = (1, 0)
    left = (-1, 0)
    up = (0, -1)
    down = (0, 1)

localSum m (x, y) = sum $ do
    dx <- [-1, 0, 1]
    dy <- [-1, 0, 1]
    guard $ dx /= 0 || dy /= 0
    let (x', y') = (x + dx, y + dy)
    pure $ M.findWithDefault 0 (x', y') m

main = print spiral
