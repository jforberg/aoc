#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

grid = ddict(int)

n = 100

for i, l in enumerate(open('input.txt')):
    l = l.strip()
    assert l
    for j, c in enumerate(l):
        if c == '#':
            grid[(i, j)] = 1

for _ in range(100):
    ngrid = ddict(int)

    for i, j in np.ndindex((n, n)):
        neigh = 0
        for di, dj in [(1, 1), (1, 0), (1, -1), (0, 1), (0, -1), (-1, 1), (-1, 0), (-1, -1)]:
            neigh += grid[(i + di, j + dj)]

        if grid[(i, j)]:
            ngrid[(i, j)] = int(neigh == 2 or neigh == 3)
        else:
            ngrid[(i, j)] = int(neigh == 3)

    grid = ngrid

print(np.sum(list(grid.values())))
