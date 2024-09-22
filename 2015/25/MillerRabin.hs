module MillerRabin
( millerRabin
, modExp
)
where

type Z = Int

rounds = 40

millerRabin :: Z -> Bool
millerRabin n
  | n < 2 = False
  | any (\p -> n /= p && n `rem` p == 0) smallPrimes = False
  | otherwise = go 2
  where
    (s, d) = extractTwoPowers (n - 1)
    go a
      | a >= min rounds (n - 1) = True
      | modExp a d n == 1 = go (a + 1)
      | any (\r -> modExp a (2^r * d) n == n - 1) [0..s - 1] = go (a + 1)
      | otherwise = False

smallPrimes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]

extractTwoPowers :: Z -> (Z, Z)
extractTwoPowers d = go 0 d
  where
    go !s d' = if d' `rem` 2 /= 0 then (s, d') else go (s + 1) (d' `div` 2)

modExp :: Z -> Z -> Z -> Z
modExp _ _ 1 = 0
modExp b e m = go (b `rem` m) e 1
  where
    go _ 0 r = r
    go !b !e !r = let
        b' = b^2 `rem` m
        e' = e `div` 2
        r' = if e `rem` 2 == 1 then r * b `rem` m else r
        in go b' e' r'
