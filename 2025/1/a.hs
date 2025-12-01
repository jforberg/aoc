import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe

inp = words . fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

rots = do
    d:n <- inp
    pure (d, read n :: Int)

interp :: [(Char, Int)] -> [Int]
interp = go 50
  where
    go p [] = [p]
    go p (('R', n):rest) = p : go ((p + n) `mod` 100) rest
    go p (('L', n):rest) = p : go ((p - n + 100) `mod` 100) rest

pass = length . filter (==0) . interp

main = print $ pass rots
