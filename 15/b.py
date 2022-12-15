#!/usr/bin/python3

import sys
import numpy as np
import re

#dim = 20 + 1
dim = 4000000 + 1

# { y : [inclusive intervals of x coordinates still left on line y] }
left = {}
for y in range(dim):
    left[y] = [(0, dim)]

s = []

for line in sys.stdin:
    line = line.strip()
    m = re.search(r'Sensor at x=([0-9-]*), y=([0-9-]*): closest beacon is at x=([0-9-]*), y=([0-9-]*)', line)
    sx, sy, bx, by = (int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4)))

    # L1 range of the sensor
    d = abs(sx - bx) + abs(sy - by)
    s.append((sx, sy, d))

# Sensors sorted by decreasing size, maybe makes things go faster
s = np.array(s)
s = s[s[:, 2].argsort()][::-1, :]

# Cut away x0..x1 inclusive from all intervals in l
def cut(l, x0, x1):
    new_l = []
    for l0, l1 in l:
        if l0 < x0:
            new_l.append((l0, min(l1, x0 - 1)))
        if l1 > x1:
            new_l.append((max(l0, x1 + 1), l1))
    return new_l

# For each sensor, remove those coordinates
for sx, sy, d in s:
    ys = list(left.keys())
    for y in ys:
        # Range of the sensor, projected onto this line
        r = d - abs(sy - y)
        if r < 0:
            continue

        # Compute new intervals of coordinates that are left
        new_ls = cut(left[y], sx - r, sx + r)

        if new_ls:
            left[y] = new_ls
        else:
            # Throw away empty lines completely as a small optimisation
            left.pop(y, None)

ty = list(left.keys())[0]
tx = left[ty][0][0]
print(tx * 4000000 + ty)
