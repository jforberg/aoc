import System.IO.Unsafe

input = unsafePerformIO $ readFile "input.txt"

initState = fmap read . words $ lines input !! 0 :: [Int]

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

pass :: [Int] -> [Int]
pass = foldr f []
  where
    f 0 acc = 1 : acc
    f x acc = let ds = digits x; (ld, rd) = halves ds in
        if length ds `rem` 2 == 0 then
            undigits ld : undigits rd : acc else
            2024 * x : acc

finalState = iterate pass initState !! 25

sol = length finalState

main = print sol
