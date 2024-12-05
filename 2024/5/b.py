#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

after = ddict(lambda: set())
keys = set()
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
        keys.add(a)
        keys.add(b)
        continue

    if step == 1:
        pages.append(list(map(int, l.split(','))))
        continue

def scope_to(ks):
    new_after = ddict(lambda: set())

    for k in ks:
        new_after[k] = after[k] & ks

    return new_after

def reorder(ps):
    ks = set(ps)
    na = scope_to(ks)
    out = []

    while ks:
        init, = [k for k in ks if not na[k]]
        out.append(init)
        ks.remove(init)
        for i in ks:
            na[i].remove(init)

    return out[::-1]

def check(ps):
    seen = set()
    valid = True
    for p in ps:
        if seen & after[p]:
            return False

        seen.add(p)

    return True

for ps in pages:
    if check(ps):
        continue

    r = reorder(ps)
    s += r[len(r) // 2]

print(s)
