import MillerRabin

b = 252533
m = 33554393
x0 = 20151125

seqx k = x0 * (modExp b (k - 1) m) `rem` m

pos i j = (r - 1) * (2 + (r - 2)) `div` 2 + j
  where
    r = i + j - 1

main = print $ seqx (pos 2978 3083)


