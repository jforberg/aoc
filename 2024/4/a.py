#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

t = ddict(lambda: ':')

h = 0

for i, l in enumerate(open('input.txt')):
    l = l.strip()
    if not l:
        continue

    w = len(l)
    h += 1

    for j, c in enumerate(l):
        t[(i, j)] = c

for i in range(h):
    for j in range(w):
        if t[(i, j)] != 'X':
            continue

        forw = t[(i, j + 1)] + t[(i, j + 2)] + t[(i, j + 3)]
        if forw == 'MAS':
            s += 1

        back = t[(i, j - 1)] + t[(i, j - 2)] + t[(i, j - 3)]
        if back == 'MAS':
            s += 1

        up = t[(i - 1, j)] + t[(i - 2, j)] + t[(i - 3, j)]
        if up == 'MAS':
            s += 1

        down = t[(i + 1, j)] + t[(i + 2, j)] + t[(i + 3, j)]
        if down == 'MAS':
            s += 1

        tl = t[(i - 1, j - 1)] + t[(i - 2, j - 2)] + t[(i - 3, j - 3)]
        if tl == 'MAS':
            s += 1

        tr = t[(i - 1, j + 1)] + t[(i - 2, j + 2)] + t[(i - 3, j + 3)]
        if tr == 'MAS':
            s += 1

        br = t[(i + 1, j + 1)] + t[(i + 2, j + 2)] + t[(i + 3, j + 3)]
        if br == 'MAS':
            s += 1

        bl = t[(i + 1, j - 1)] + t[(i + 2, j - 2)] + t[(i + 3, j - 3)]
        if bl == 'MAS':
            s += 1

print(s)
