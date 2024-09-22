#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

nums = np.array([
    0, 0, 1, 0, 0,
    0, 2, 3, 4, 0,
    5, 6, 7, 8, 9,
    0, 10, 11, 12, 0,
    0, 0, 13, 0, 0,
    ]).reshape((5,5))

out = []

pos = np.array([2, 0])

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    for x in l:
        if x == 'U':
            npos = pos + [-1, 0]
        if x == 'L':
            npos = pos + [0, -1]
        if x == 'D':
            npos = pos + [1, 0]
        if x == 'R':
            npos = pos + [0, 1]

        npos[0] = np.clip(npos[0], 0, 4)
        npos[1] = np.clip(npos[1], 0, 4)
        if nums[npos[0], npos[1]] == 0:
            continue

        pos = npos

    out.append(nums[pos[0], pos[1]])

print(''.join(['%x' % d for d in out]))
