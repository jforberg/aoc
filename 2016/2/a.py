#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

nums = np.array([
    1 ,2, 3,
    4, 5, 6,
    7 ,8 , 9]).reshape((3,3)).T

out = []

pos = np.array([1, 1])

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    for x in l:
        if x == 'U':
            pos += [0, -1]
        if x == 'L':
            pos += [-1, 0]
        if x == 'D':
            pos += [0, 1]
        if x == 'R':
            pos += [1, 0]

        pos[0] = np.clip(pos[0], 0, 2)
        pos[1] = np.clip(pos[1], 0, 2)

    out.append(nums[pos[0], pos[1]])

print(''.join([str(x) for x in out]))
