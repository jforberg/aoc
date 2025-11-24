import System.IO.Unsafe
import Data.List.Extra
import Debug.Trace
import Data.Sequence qualified as Seq
import Data.Foldable
import Data.Set qualified as Set
import Data.Maybe

n = 16

inp = unsafePerformIO $ readFile "input.txt"

banks = Seq.fromList $ (read :: String -> Int) <$> words inp

iteration = go Set.empty
  where
    go seen bs
      | Set.member bs seen = 0
      | otherwise = let
            i = maximumIdx bs
            bs' = redist bs i
            seen' = Set.insert bs seen in
                1 + go seen' bs'

redist bs i0 = foldr f bs' $ take r $ concat $ repeat ([i0 + 1..n - 1] <> [0..i0])
  where
    f i acc = Seq.adjust' (+1) i acc
    bs' = Seq.update i0 0 bs
    r = fromJust $ bs Seq.!? i0

maximumIdx xs = fst $ foldl' f (-1, -1) $ zip [0..] $ toList xs
  where
    f (mi, mx) (i, x)
      | x > mx = (i, x)
      | otherwise = (mi, mx)

solution = iteration $ Seq.fromList [1,0,14,14,12,12,10,10,8,8,6,6,4,3,2,1]

main = print solution
