#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

after = ddict(lambda: set())
pages = []

step = 0

for i, l in enumerate(open('input.txt')):
    l = l.strip()

    if not l:
        step = 1
        continue

    if step == 0:
        a, b = tuple(map(int, l.split('|')))
        after[a].add(b)
        continue

    if step == 1:
        pages.append(list(map(int, l.split(','))))
        continue

for ps in pages:
    seen = set()
    valid = True
    for p in ps:
        if seen & after[p]:
            valid = False
            break

        seen.add(p)

    if valid:
        m = ps[len(ps) // 2]
        s += m

print(s)
