#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re

g = np.zeros((1000, 1000), dtype=int)
s = 0

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    m = re.search(r'([^0-9]+) (\d+),(\d+) through (\d+),(\d+)', l)
    op, j0, i0, j1, i1 = m.groups()
    j0 = int(j0)
    j1 = int(j1)
    i0 = int(i0)
    i1 = int(i1)

    if op == 'turn on':
        g[i0:i1 + 1, j0:j1 + 1] += 1
    elif op == 'toggle':
        g[i0:i1 + 1, j0:j1 + 1] += 2
    elif op == 'turn off':
        g[i0:i1 + 1, j0:j1 + 1] -= 1
        g[g < 0] = 0
    else:
        assert False

print(np.sum(g))
