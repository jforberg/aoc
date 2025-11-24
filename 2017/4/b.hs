import System.IO.Unsafe
import Data.List.Extra
import Data.MultiSet qualified as MS

inp = unsafePerformIO $ readFile "input.txt"

phrases = splitOn " " <$> lines inp

anagrams = fmap MS.fromList <$> phrases

solution = length $ filter (\p -> nubOrd p == p) anagrams

main = print solution
