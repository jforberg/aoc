#!/usr/bin/python3

import sys
import re
from collections import defaultdict

s = 0

tab = []

acc = []
first = True
for l in open('input.txt'):
    l = l.strip()

    if first:
        a, b = l.split(': ')
        inseeds = list(map(int, b.split()))

        seeds = []
        for i in range(len(inseeds) // 2):
            seeds.append(inseeds[2 * i : 2 * i + 2])

        first = False
        continue

    if not l:
        if acc:
            tab.append(list(sorted(acc)))
            acc = []
        continue

    if not l[0].isdigit():
        continue

    a, b, c = l.split()
    acc.append((int(a), int(b), int(c)))

if acc:
    tab.append(list(sorted(acc)))
    acc = []

def transform(z, rs):
    rs_out = []

    for t, f, l in tab[z]:
        rs2 = []

        for r0, rl in rs:
            # part before f
            l1 = min(f - r0, rl)
            if l1 > 0:
                rs2.append((r0, l1))

            # part after f + l
            l3 = min(rl, (r0 + rl) - (f + l))
            if l3 > 0:
                rs2.append((max(r0, f + l), l3))

            # part transformed
            l2 = rl - max(l1, 0) - max(l3, 0)
            if l2 > 0:
                rs_out.append((t + max(0, r0 - f), l2))

        rs = rs2

    rs_out.extend(rs)
    rs_out = list(sorted(rs_out))

    if z >= len(tab) - 1:
        return rs_out
    else:
        return transform(z + 1, rs_out)

best = 2**32

rs = transform(0, seeds)
rs = list(sorted(rs))
best = rs[0][0]

print(best)
