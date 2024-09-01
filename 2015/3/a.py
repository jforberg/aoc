#!/usr/bin/python3

import numpy as np
from collections import defaultdict

s = 0

g = defaultdict(int)
x = 0
y = 0

for l in open('input.txt'):
    for c in l:
        if c == '^':
            y -= 1
        elif c == 'v':
            y += 1
        elif c == '<':
            x -= 1
        elif c == '>':
            x += 1

        g[(x, y)] += 1

print(len(g))
