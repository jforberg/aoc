#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re
import itertools

s = 999999999

edges = {}
nodes = set()

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    f, t, d = re.split(r' to | = ', l)
    d = int(d)

    nodes.add(f)
    nodes.add(t)

    edges[(min(f, t), max(f, t))] = d

for o in itertools.permutations(nodes):
    c = 0
    for i in range(len(o) - 1):
        f = o[i]
        t = o[i + 1]
        c += edges[(min(f, t), max(f, t))]

    s = min(s, c)

print(s)

