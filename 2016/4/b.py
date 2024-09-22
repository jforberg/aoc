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

    xs = re.split(r'[-\[\]]', l)[:-1]
    cs = xs[-1]
    sid = int(xs[-2])
    ns = xs[:-2]
    ls = ddict(int)
    for c in ''.join(ns):
        ls[c] += 1

    comm = list(reversed(sorted(ls.items(), key=lambda x: (x[1], -ord(x[0])))))[:5]
    real_cs = ''.join([c[0] for c in comm])
    if cs != real_cs:
        continue

    def decode(c, d):
        return chr((ord(c) - ord('a') + d) % 26 + ord('a'))

    dec = ''.join([decode(c, sid) for c in ''.join(ns)])
    if 'north' in dec:
        print(sid)

    s += sid
