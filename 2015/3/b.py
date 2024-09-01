#!/usr/bin/python3

import numpy as np
from collections import defaultdict

s = 0

g = defaultdict(int)

pos = [(0, 0), (0, 0)]
i = 0

for l in open('input.txt'):
    for c in l:
        if i % 2:
            x, y = pos[0]
        else:
            x, y = pos[1]

        if c == '^':
            y -= 1
        elif c == 'v':
            y += 1
        elif c == '<':
            x -= 1
        elif c == '>':
            x += 1

        g[(x, y)] += 1

        if i % 2:
            pos[0] = (x, y)
        else:
            pos[1] = (x, y)

        i += 1

print(len(g))
