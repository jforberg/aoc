#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

chips = ddict(list)
comp = ddict(set)
rules = dict()
out = dict()

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    if m := re.search(r'value (\d+) goes to bot (\d+)', l):
        v, b = m.groups()
        chips[int(b)].append(int(v))
    elif m := re.search(r'bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)', l):
        b, lt, lv, ht, hv = m.groups()
        rules[int(b)] = (
            lt, int(lv), ht, int(hv)
        )
    else:
        assert False

def hastwo():
    for k, v in chips.items():
        assert len(v) <= 2

        if len(v) == 2:
            return k

    return -1

while (b := hastwo()) >= 0:
    l, h = sorted(chips[b])
    comp[(l, h)].add(b)
    chips[b] = []
    lt, lv, ht, hv = rules[b]

    if lt == 'bot':
        chips[lv].append(l)

    if ht == 'bot':
        chips[hv].append(h)

    if lt == 'output':
        out[lv] = l

    if ht == 'output':
        out[hv] = h

print(out[0] * out[1] * out[2])
