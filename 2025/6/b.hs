import System.IO.Unsafe
import Data.List.Extra
import Data.Maybe
import Data.Function
import Data.Functor
import Data.Ix
import Data.Set qualified as Set

inp = fromJust . stripSuffix "\n" $ unsafePerformIO $ readFile "input.txt"

opLine = last $ lines inp

ops = words opLine

breakIxs = zip [0..length opLine - 1] opLine & mapMaybe f & Set.fromList
  where
    f (_, ' ') = Nothing
    f (i, _) = Just $ i - 1

numLines = pad <$> init (lines inp)

pad = zipWith f [0..]
  where
    f i ' ' = if Set.member i breakIxs then ' ' else '0'
    f _ c = c

nums :: [[Int]] = fmap read <$> words <$> numLines

(w, h) = (length ops, length (nums !! 0))

numCols = flip fmap [0..h - 1] $ (\i -> fmap (!! i) nums)

numFromDigits = sum . zipWith (*) tens . reverse

tens :: [Int] = (10^) <$> [0..]

bonkCol ds
  | n == 0 = []
  | otherwise = n : bonkCol ds'
  where
    ds' = flip div 10 <$> ds
    n = numFromDigits $ filter (/= 0) $ flip mod 10 <$> ds

bonkCols = bonkCol <$> numCols

solution = sum [foldl1 (op o) c | (o, c) <- zip ops bonkCols]

op "+" = (+)
op "*" = (*)

main = print solution
