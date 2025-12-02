import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Set qualified as Set

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

ranges = splitOn "," inp <&> splitOn "-" <&> \[a, b] -> (read a :: Int, read b :: Int)

isDuplicate x = let
    s = show x
    (a, b) = splitAt (length s `div` 2) s
    in a == b

fullRanges = concatMap (uncurry enumFromTo) ranges

solution = sum $ filter isDuplicate fullRanges

main = print solution
