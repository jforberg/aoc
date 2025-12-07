import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Array.Unboxed qualified as Arr
import Control.Monad
import Data.Set qualified as Set
import Data.Foldable

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

(h, w) = (length inp, length $ inp !! 0)

grid :: Arr.UArray (Int, Int) Char
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) $ mconcat inp

startIdx = go $ Arr.assocs grid
  where
    go ((i, 'S'):_) = i
    go ((_, _):rest) = go rest

beam = go $ Set.singleton startIdx
  where
    go s
      | Set.null s = 0
      | otherwise = let (c, s') = foldr move (0, Set.empty) (toList s) in c + go s'

    move (y, x) acc@(c, s) = case grid Arr.!? (y + 1, x) of
        Nothing -> acc
        Just '^' -> (c + 1, (y + 1, x + 1) `Set.insert` ((y + 1, x - 1) `Set.insert` s))
        Just '.' -> (c, (y + 1, x) `Set.insert` s)

main = print beam
