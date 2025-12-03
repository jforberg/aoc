import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Set qualified as Set
import Data.Array.Unboxed qualified as Arr
import Control.Monad

inp = lines . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

nums = concatMap (fmap $ \c -> read [c] :: Int) inp

(h, w) = (length inp, length $ inp !! 0)

grid :: Arr.UArray (Int, Int) Int
grid = Arr.listArray ((0, 0), (h - 1, w - 1)) nums

bankBest i = maximum $ do
    j1 <- [0..w - 1]
    let v1 = grid Arr.! (i, j1)
    j2 <- [j1 + 1..w - 1]
    let v2 = grid Arr.! (i, j2)
    pure $ v1 * 10 + v2

solution = sum $ bankBest <$> [0..h - 1]

main = print solution
