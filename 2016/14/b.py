#!/usr/bin/python3

from hashlib import md5
from collections import defaultdict as ddict
from bisect import *

three = ddict(lambda: [])
five = ddict(lambda: [])

#salt = 'abc'
salt = 'zpqevtbw'

def gen():
    i = 0
    while True:
        h = md5((salt + str(i)).encode()).hexdigest()
        for j in range(2016):
            h = md5(h.encode()).hexdigest()
        yield (i, h)
        i += 1

for i, h in gen():
    have_trip = False

    for j in range(len(h)):
        if j >= 2 and not have_trip and h[j - 2] == h[j - 1] == h[j]:
            three[h[j]].append(i)
            have_trip = True

        if j >= 4 and h[j - 4] == h[j - 3] == h[j - 2] == h[j - 1] == h[j]:
            five[h[j]].append(i)

    if i > 30000:
        break

keys = set()

for c, ixs in five.items():
    tc = three[c]
    for idx in ixs:
        l = bisect_left(tc, idx - 1000)
        r = bisect_right(tc, idx - 1)
        keys.update(tc[l:r])

keys = list(sorted(keys))
print(keys[63])
