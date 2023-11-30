#!/usr/bin/python3

import sys
import numpy as np
import re

s = set()

#target_y = 10
target_y = 2000000

for line in sys.stdin:
    l = line.strip()
    m = re.search(r'Sensor at x=([0-9-]*), y=([0-9-]*): closest beacon is at x=([0-9-]*), y=([0-9-]*)', l)
    sx, sy, bx, by = (int(m.group(1)), int(m.group(2)), int(m.group(3)), int(m.group(4)))

    d = abs(sx - bx) + abs(sy - by)

    r = max(0, d - abs(sy - target_y))

    for i in range(sx - r, sx + r):
        s.add(i)

print(len(s))

