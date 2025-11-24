import System.IO.Unsafe
import Data.List.Extra

inp = unsafePerformIO $ readFile "input.txt"

phrases = splitOn " " <$> lines inp

solution = length $ filter (\p -> nubOrd p == p) phrases

main = print solution
