#!/usr/bin/python3

import itertools
import math

l = [ 1 , 2 , 3 , 5 , 7 , 13 , 17 , 19 , 23 , 29 , 31 , 37 , 41 , 43 , 53 , 59 , 61 , 67 , 71 ,
    73 , 79 , 83 , 89 , 97 , 101 , 103 , 107 , 109 , 113 ]

l_set = set(l)

m = 99999999999999999

for hs in itertools.combinations(l[-7:], 3):
    left = 384 - sum(hs)
    if not left in l_set:
        continue

    m = min(m, math.prod(hs) * left)

print(m)
