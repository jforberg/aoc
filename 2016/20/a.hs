{-# LANGUAGE MultiWayIf #-}
import System.IO
import Data.List.Split

readInput = readFile "input.txt"

parse = fmap (\[a, b] -> (read a :: Int, read b :: Int)) . fmap (splitOn "-") . endBy "\n"

delimit ranges [] = ranges
delimit ranges ((f0, f1):fs) = do
    (r0, r1) <- delimit ranges fs
    if
      | f0 <= r0 && f1 >= r1 -> []
      | f0 <= r0 && f1 >= r0 && f1 < r1-> [(f1 + 1, r1)]
      | f0 > r0 && f0 <= r1 && f1 >= r1 -> [(r0, f0 - 1)]
      | f0 > r0 && f1 < r1 -> [(r0, f0 - 1), (f1 + 1, r1)]
      | otherwise -> [(r0, r1)]

main = do
    fs <- parse <$> readInput
    let (r0, r1):_ = delimit [(0, 4294967295)] fs
    print r0
