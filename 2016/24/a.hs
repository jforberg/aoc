import System.IO.Unsafe
import Data.Array.IArray
import Control.Monad
import Bfs
import Data.Map qualified as Map
import Data.List

r = unsafePerformIO $ lines <$> readFile "input.txt"

h = length r
w = length $ head r

maze :: Array (Int, Int) Char
maze = listArray ((0, 0), (h - 1, w - 1)) $ concat r

newtype N = N ((Int, Int), (Int, Int))
    deriving (Show, Eq, Ord)

instance Node N where
    isGoal (N (g, p)) = g == p

    adjacent (N (g, (py, px))) = do
        dy <- [-1, 0, 1]
        dx <- if dy == 0 then [-1, 1] else [0]
        let (py', px') = (py + dy, px + dx)
        guard $ maze ! (py', px') /= '#'
        pure $ N (g, (py', px'))

findDigit d = let Just m = find (\i -> maze ! i == d) $ indices maze in m

zeroTwo = bfs $ N (findDigit '2', findDigit '0')

distances = Map.fromList $ do
    d0 <- [0..7]
    d1 <- [0..d0]
    let p0 = findDigit $ head $ show d0
    let p1 = findDigit $ head $ show d1
    let l = length (bfs $ N (p1, p0)) - 1
    pure ((d0, d1), l)

pathLength ds = sum $ fmap getDist $ zip ds (tail ds)
  where
    getDist (p0, p1) = distances Map.! (max p0 p1, min p0 p1)

allPathLengths = [pathLength (0 : ps) | ps <- permutations [1..7]]

sol = minimum allPathLengths

main = print sol
