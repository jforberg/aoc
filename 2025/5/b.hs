import System.IO.Unsafe
import Data.List.Extra hiding (merge)
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Ix

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

[inp1, _] = lines inp & splitOn [""]

ranges = do
    i <- inp1
    let [a, b] = splitOn "-" i
    pure (read a :: Int, read b :: Int)

finalRanges = foldr merge [] ranges

-- Sorted by starting index
merge r [] = [r]
merge r@(r0, r1) (e@(e0, e1):es)
  -- eeee rrrr
  | e1 < r0 = e : merge r es
  -- rrrr eeee
  | r1 < e0 = r : e : es
  -- rrrreeee / eeeerrrr
  | otherwise = let r' = (min e0 r0, max e1 r1) in merge r' es

solution = sum $ rangeSize <$> finalRanges

main = print solution
