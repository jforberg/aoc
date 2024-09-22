#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    xs = re.split(r'[\[\]]', l)

    abba = False
    bad = False
    for i, x in enumerate(xs):
        for j in range(len(x)):
            if j < 3:
                continue

            if x[j] == x[j-1] or x[j] != x[j-3] or x[j - 1] != x[j - 2]:
                continue

            abba = True
            if i % 2 == 1:
                bad = True

    if abba and not bad:
        s += 1

print(s)
