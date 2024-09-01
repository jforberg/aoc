#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys

s = 0

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    twice_idx = defaultdict(list)
    last = '\0'
    llast = '\0'
    repeat = 0

    for i, c in enumerate(l):
        if i >= 1:
            twice_idx[last + c].append(i)

        if i >= 2 and llast == c:
            repeat = 1

        llast = last
        last = c

    if not repeat:
        continue

    for k in twice_idx.keys():
        idx = twice_idx[k]

        if max(idx) - min(idx) >= 2:
            s += 1
            break

print(s)
