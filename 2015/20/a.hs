import Sieve

limit = 1_000_000

s = mkSieve limit

sigma n = product [ (p^(k + 1) - 1) `div` (p - 1) | (p, k) <- primeFactorMults s n]

sq = [(i, 10 * sigma i) | i <- [1..]]

main = print . fst . head . dropWhile ((< 33100000) . snd) $ sq
