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
        if t[(i, j)] != 'A':
            continue

        c = 0

        tl = t[(i - 1, j - 1)] + t[(i + 1, j + 1)]
        if tl == 'MS':
            c += 1

        bl = t[(i + 1, j - 1)] + t[(i - 1, j + 1)]
        if bl == 'MS':
            c += 1

        tr = t[(i - 1, j + 1)] + t[(i + 1, j - 1)]
        if tr == 'MS':
            c += 1

        br = t[(i + 1, j + 1)] + t[(i - 1, j - 1)]
        if br == 'MS':
            c += 1

        if c > 1:
            s += 1

print(s)
