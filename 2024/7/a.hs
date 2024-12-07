import System.IO.Unsafe
import Data.List.Split
import Control.Monad

input = unsafePerformIO $ readFile "input.txt"

eqs :: [(Int, [Int])]
eqs = do
    x <- lines input
    let [a, b] = splitOn ": " x
    pure (read a, read <$> splitOn " " b)

poss :: [Int] -> [Int]
poss [x] = [x]
poss (a:b:cs) = do
    op <- [(+), (*), (|||)]
    v <- poss (b:cs)
    pure $ a `op` v

a ||| b = read $ show a <> show b

revPoss ns = poss $ reverse ns

valid :: Int -> [Int] -> Bool
valid a bs = any (== a) $ revPoss bs

sol = sum $ do
    (a, bs) <- eqs
    guard $ valid a bs
    pure a
