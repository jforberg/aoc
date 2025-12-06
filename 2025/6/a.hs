import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Ix

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

table = lines inp <&> words

(nums :: [[Int]], ops) = (fmap read <$> init table, last table)

(w, h) = (length ops, length (nums !! 0))

numCols = flip fmap [0..h - 1] $ (\i -> fmap (!! i) nums)

solution = sum [foldl1 (op $ ops !! i) (numCols !! i) | i <- [0..w - 1]]

op "+" = (+)
op "*" = (*)

main = print solution
