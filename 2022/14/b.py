#!/usr/bin/python3

import sys
import numpy as np

m = np.zeros((1000, 1000), dtype=int)

path = []

max_y = 0

for line in sys.stdin:
    l = line.strip().split(' -> ')
    path.append([])

    for c in l:
        x, y = c.split(',')
        p = (int(y), int(x))
        max_y = max(max_y, p[0])
        path[-1].append(p)

for cs in path:
    for i in range(len(cs) - 1):
        y0, x0 = cs[i]
        y1, x1 = cs[i + 1]

        if x0 == x1:
            m[min(y0, y1) : max(y0, y1) + 1, x0] = -1
        elif y0 == y1:
            m[y0, min(x0, x1) : max(x0, x1) + 1] = -1
        else:
            assert False

floor_y = max_y + 2
m[floor_y, :] = -1

sand = 0
while True:
    pos = (0, 500)

    while True:
        if m[pos[0] + 1, pos[1]] == 0:
            pos = (pos[0] + 1, pos[1])
        elif m[pos[0] + 1, pos[1] - 1] == 0:
            pos = (pos[0] + 1, pos[1] - 1)
        elif m[pos[0] + 1, pos[1] + 1] == 0:
            pos = (pos[0] + 1, pos[1] + 1)
        elif pos == (0, 500):
            sand += 1
            print(sand)
            sys.exit()
        else:
            m[pos] = 1
            sand += 1
            break
