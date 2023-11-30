#!/usr/bin/python3

import sys
import numpy as np

visited = set()

h_x = 0
h_y = 0
t_x = 0
t_y = 0

for line in sys.stdin:
    line = line.strip()
    d, l = line.split()
    l = int(l)

    for i in range(l):
        visited.add((t_x, t_y))

        if d == 'U':
            h_y += 1
        elif d == 'R':
            h_x += 1
        elif d == 'D':
            h_y -= 1
        elif d == 'L':
            h_x -= 1

        if abs(t_x - h_x) < 2 and abs(t_y - h_y) < 2:
            continue

        if t_y == h_y:
            t_x += np.sign(h_x - t_x)
        elif t_x == h_x:
            t_y += np.sign(h_y - t_y)
        else:
            t_x += np.sign(h_x - t_x)
            t_y += np.sign(h_y - t_y)

visited.add((t_x, t_y))

print(len(visited))
