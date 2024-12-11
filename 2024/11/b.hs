import System.IO.Unsafe
import Data.MultiSet (MultiSet)
import Data.MultiSet qualified as MS

input = unsafePerformIO $ readFile "input.txt"

initState = MS.fromList $ fmap read . words $ lines input !! 0

digits 0 = [1]
digits x = reverse $ go x
  where
    go 0 = []
    go x = x `rem` 10 : go (x `div` 10)

undigits = go 1 . reverse
  where
    go _ [] = 0
    go b (x:xs) = b * x + go (10 * b) xs

halves ds = let h = length ds `div` 2 in (take h ds, drop h ds)

pass :: MultiSet Integer -> MultiSet Integer
pass xs = MS.foldOccur f MS.empty xs
  where
    f 0 c acc = MS.insertMany 1 c acc
    f x c acc = let ds = digits x; (ld, rd) = halves ds in
        if length ds `rem` 2 == 0 then
            MS.insertMany (undigits ld) c $
                MS.insertMany (undigits rd) c acc else
            MS.insertMany (2024 * x) c acc

finalState = iterate pass initState !! 75

sol = MS.size finalState

main = print sol
