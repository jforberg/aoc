import System.IO.Unsafe
import Data.List.Split
import Control.Monad

input = unsafePerformIO $ readFile "input.txt"

eqs = do
    x <- lines input
    let [a, b] = splitOn ": " x
    pure (read a, read <$> splitOn " " b)

poss [x] = [x]
poss (a:b:cs) = do
    op <- [(+), (*), (|||)]
    v <- poss (b:cs)
    pure $ v `op` a

a ||| b = read $ show a <> show b

revPoss ns = poss $ reverse ns

valid a bs = any (== a) $ revPoss bs

sol = sum $ do
    (a, bs) <- eqs
    guard $ valid a bs
    pure a

main = print sol
