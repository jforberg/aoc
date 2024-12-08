#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

grid = set()
ant = ddict(lambda: set())
freq = set()
node = set()

for i, l in enumerate(open('input.txt')):
    l = l.strip()

    for j, c in enumerate(l):
        grid.add((j, i))
        if c != '.':
            ant[c].add((j, i))
            freq.add(c)

for p in grid:
    for f in freq:
        for a1, a2 in itertools.combinations(ant[f], 2):
            d1 = a1[0] - p[0], a1[1] - p[1]
            d2 = a2[0] - p[0], a2[1] - p[1]
            if d1[0] * d2[1] != d2[0] * d1[1]:
                continue

            node.add(p)

print(len(node))
