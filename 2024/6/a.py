#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

t = ddict(lambda: True)
pos = None
grid = set()
been = set()

for i, l in enumerate(open('input.txt')):
    l = l.strip()

    for j, c in enumerate(l):
        if c == '^':
            pos = (i, j)
        t[(i, j)] = c != '#'
        grid.add((i, j))

d = (-1, 0)

def rot(r):
    if r == (-1, 0):
        return (0, 1)
    elif r == (0, 1):
        return (1, 0)
    elif r == (1, 0):
        return (0, -1)
    elif r == (0, -1):
        return (-1, 0)
    else:
        assert False

while True:
    if pos not in grid:
        break

    been.add(pos)
    i, j = pos

    i2 = i + d[0]
    j2 = j + d[1]

    if not t[(i2, j2)]:
        d = rot(d)
        continue

    pos = (i2, j2)

print(len(been))
