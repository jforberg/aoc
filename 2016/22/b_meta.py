#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

d = ddict(lambda: None)

mx = 0
my = 0

for l in open('input.txt'):
    m = re.match(r'/dev/grid/node-x(\d+)-y(\d+)\s*(\d+)T\s*(\d+)T.*', l)
    if not m:
        continue

    x, y, s, u = m.groups()

    x = int(x)
    y = int(y)
    s = int(s)
    u = int(u)

    d[(x, y)] = (s, u)

    mx = max(mx, x)
    my = max(my, y)

wall = []

def p():
    for i in range(my + 1):
        for j in range(mx + 1):
            s, u = d[(j, i)]

            if (j, i) == (mx, 0):
                print('G', end='')
            elif u == 0:
                print('_', end='')
                global hole
                hole = (j, i)
            elif u < 100:
                print('.', end='')
            else:
                print('#', end='')
                wall.append((j, i))

        print()

p()

print(f'{(mx, my)=}')
print(f'{wall=}')
print(f'{hole=}')
