#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

d = ddict(lambda: None)

for l in open('input.txt'):
    m = re.match(r'/dev/grid/node-x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T.*', l)
    if not m:
        continue

    x, y, s, u = m.groups()

    d[(int(x), int(y))] = (int(s), int(u))

s = 0

for k1 in d:
    for k2 in d:
        if k1 == k2:
            continue

        if d[k1][1] == 0:
            continue

        if d[k1][1] > d[k2][0] - d[k2][1]:
            continue

        s += 1

print(s)
