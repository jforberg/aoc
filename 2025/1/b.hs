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
    go p [] = []
    go p ((_, 0):rest) =  go p rest
    go p (('R', n):rest) = p : go ((p + 1) `mod` 100) (('R', n - 1):rest)
    go p (('L', n):rest) = p : go ((p - 1 + 100) `mod` 100) (('L', n - 1):rest)

pass = length . filter (== 0) . interp

main = print $ pass rots
