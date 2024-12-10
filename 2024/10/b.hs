import Control.Monad
import Data.Foldable
import Data.List.Extra
import Data.List.Split
import Data.Map.Strict (Map)
import Data.Map.Strict qualified as Map
import Data.Set (Set)
import Data.Set qualified as Set
import Data.Array.IArray qualified as Arr
import Data.Array.IArray (Array)
import Debug.Trace
import System.IO.Unsafe

input = lines <$> unsafePerformIO $ readFile "input.txt"

h = length input
w = length $ input !! 0

grid :: Array (Int, Int) Int
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) $ do
    l <- input
    c <- l
    pure $ read [c]

zeroIxs = do
    (ix, v) <- Arr.assocs grid
    guard $ v == 0
    pure ix

search startIdx = go startIdx 0
  where
    go idx@(i, j) n
      | grid Arr.!? idx /= Just n = 0
      | n == 9 = 1
      | otherwise =
            go (i + 1, j) (n + 1) +
            go (i - 1, j) (n + 1) +
            go (i, j + 1) (n + 1) +
            go (i, j - 1) (n + 1)

trailheads = sum $ search <$> Arr.indices grid

main = print trailheads
