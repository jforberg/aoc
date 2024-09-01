#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re
import itertools

s = 0

table = defaultdict(dict)

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    m = re.search('([A-Z])[^0-9]*([0-9]+)[^A-Z]*([A-Z])', l)
    d, v, n = m.groups()
    v = int(v)
    if ' lose ' in l:
        v = -v

    table[d][n] = v

def mod(x):
    return (x + len(table.keys())) % len(table.keys())

for a in itertools.permutations(table.keys()):
    v = 0
    for i, p in enumerate(a):
        v += table[p][a[mod(i - 1)]]
        v += table[p][a[mod(i + 1)]]

    s = max(s, v)

print(s)
