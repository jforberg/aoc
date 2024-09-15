import Control.Monad

default (Int)

divs n = sum $ do
    k <- [max 1 (n `div` 50) .. n]
    guard $ n `rem` k == 0
    pure $ k * 11

mk n = (n, divs n)

sq = [(i, divs i) | i <- [780_000..]]

main = print . head . dropWhile ((< 33100000) . snd) $ sq
