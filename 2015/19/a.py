#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

rules = ddict(list)
arm = False

for l in open('input.txt'):
    l = l.strip()

    if not l:
        arm = True
        continue

    if arm:
        start = l
    else:
        a, b = l.split(' => ')
        rules[a].append(b)

result = set()
for f, t in rules.items():
    s = 0
    while (i := start.find(f, s)) >= 0:
        for t0 in t:
            result.add(
                start[:i] + t0 + start[i + len(f):])
        s = i + 1

print(len(result))
