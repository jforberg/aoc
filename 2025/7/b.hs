import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Array.Unboxed qualified as Arr
import Control.Monad
import Data.Set qualified as Set
import Data.Foldable
import Debug.Trace
import Data.MultiSet qualified as MS

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

(h, w) = (length inp, length $ inp !! 0)

grid :: Arr.UArray (Int, Int) Char
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) $ mconcat inp

startIdx = go $ Arr.assocs grid
  where
    go ((i, 'S'):_) = i
    go ((_, _):rest) = go rest

beam = go $ MS.singleton startIdx
  where
    go s = let s' = foldr move MS.empty (MS.toOccurList s) in if s' == s then s else go s'

    move ((y, x), c) s = case grid Arr.!? (y + 1, x) of
        Nothing -> MS.insertMany (y, x) c s
        Just '^' -> MS.insertMany (y + 1, x + 1) c $ MS.insertMany (y + 1, x - 1) c $ s
        Just '.' -> MS.insertMany (y + 1, x) c s

main = print $ length beam
