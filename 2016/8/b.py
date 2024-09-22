#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

grid = np.zeros((6, 50), dtype=bool)

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    if m := re.search(r'rect (\d+)x(\d+)', l):
        w, h = m.groups()

        grid[:int(h), :int(w)] = 1
    elif m := re.search(r'rotate row y=(\d+) by (\d+)', l):
        y = int(m.group(1))
        d = int(m.group(2))

        grid[y] = np.roll(grid[y], d)
    elif m := re.search(r'rotate column x=(\d+) by (\d+)', l):
        x = int(m.group(1))
        d = int(m.group(2))

        grid[:, x] = np.roll(grid[:, x], d)
    else:
        print(l)
        assert False

for i in range(6):
    for j in range(50):
        if grid[i, j]:
            print('X', end='')
        else:
            print(' ', end='')

    print()
