#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

rs = []

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    rs.append(list(map(int, l.split())))

print(rs)

for r in rs:
    for i in range(-1, len(r) + 1):
        if i == -1:
            d = np.array(r, dtype=int)
        else:
            d = np.array(r[:i] + r[i + 1:], dtype=int)

        dd = np.diff(d)

        if (np.all(dd > 0) or np.all(dd < 0)) and (np.all((np.abs(dd) >= 1) & (np.abs(dd) <= 3))):
            s += 1
            break

print(s)
