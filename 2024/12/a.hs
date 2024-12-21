import Control.Monad
import Data.Foldable
import Data.Set (Set)
import Data.Set qualified as Set
import System.IO.Unsafe
import Data.Array.IArray
import Data.Array.IArray qualified as Arr

input = lines $ unsafePerformIO $ readFile "input.txt"

w = length $ input !! 0
h = length input

grid :: Array (Int, Int) Char
grid = listArray ((0, 0), (h - 1, w - 1)) $ concat input

search ix0 seen = go [ix0] seen Set.empty
  where
    go [] seen s = s
    go (ix@(i, j):ixs) seen s
      | ix `Set.member` seen = go ixs seen s
      | grid Arr.!? ix == Nothing = go ixs seen s
      | grid Arr.!? ix /= Just c = go ixs (Set.insert ix seen) s
      | otherwise = go (adjacent ix <> ixs) (Set.insert ix seen) (Set.insert ix s)

    c = grid Arr.! ix0

regions = go Set.empty $ Arr.indices grid
  where
    go _ [] = []
    go seen (ix:ixs)
      | ix `Set.member` seen = go seen ixs
      | otherwise = let s = search ix seen in s : go (Set.union seen s) ixs

area = Set.size

perimeter s = sum $ do
    ix <- toList s
    adj <- adjacent ix
    guard $ not $ adj `Set.member` s
    pure $ 1

adjacent (i, j) = [(i + 1, j), (i - 1, j), (i, j + 1), (i, j - 1)]

cost s = area s * perimeter s

sol = sum $ cost <$> regions

main = print sol
