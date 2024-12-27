import Control.Monad
import Data.Foldable
import Data.List.Extra
import Data.Set (Set)
import Data.Set qualified as Set
import Debug.Trace
import System.IO.Unsafe
import Data.Vector qualified as Vec
import Numeric.Search.Range

import Bfs

input = lines $ unsafePerformIO $ readFile "input.txt"

n = length input

w = 71
h = 71

falls = fmap read . split (==',') <$> input :: [[Int]]

corrupt = Vec.fromListN (n + 1) $ do
    (i, f) <- zip [0..n] ([] : falls)
    if i == 0 then pure Set.empty else do
        let [x, y] = f
        pure $ (x, y) `Set.insert` (corrupt Vec.! (i - 1))

newtype N = N (Int, (Int, Int))
    deriving (Show, Eq, Ord)

instance Node N where
    isGoal (N (_, idx)) = idx == (w - 1, h - 1)

    adjacent (N (i, (x, y))) = do
        dx <- [-1, 0, 1]
        dy <- if dx == 0 then [-1, 1] else [0]
        let idx'@(x', y') = (x + dx, y + dy)
        guard $ x' >= 0 && x' < w
        guard $ y' >= 0 && y' < h
        guard $ not $ idx' `Set.member` (corrupt Vec.! i)
        pure $ N (i, (x', y'))

Just idx = searchFromTo (\i -> null (bfs $ N (i, (0, 0)))) 0 n

sol = falls !! (idx - 1)

main = print sol
