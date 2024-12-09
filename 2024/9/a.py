#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

i = 0

disk = []
gaps = 0

for l in open('input.txt'):
    l = l.strip()

    it = iter(l)

    try:
        while it:
            a = int(next(it))
            b = int(next(it))
            if b:
                gaps += 1
            disk.append([i, a, b])
            i += 1
    except StopIteration:
        disk.append([i, a, 0])
        pass

while gaps:
    ok = False
    a_id, a_sz, _ = disk[-1]

    for i in range(len(disk) - 1):
        b_id, b_sz, b_fr = disk[i]

        if not b_fr:
            continue

        if b_fr >= a_sz:
            disk[i][2] = 0
            if b_fr == a_sz:
                gaps -= 1

            disk.insert(i + 1, [a_id, a_sz, b_fr - a_sz])

            disk = disk[:-1]

            if disk[-1][2]:
                gaps -= 1

            disk[-1][2] = 0
        else:
            disk[-1][1] -= b_fr
            disk[i][2] = 0
            gaps -= 1

            disk.insert(i + 1, [a_id, b_fr, 0])

        ok = True
        break

    assert ok

s = 0
i = 0

for b in disk:
    if b[2]:
        assert False

    for j in range(b[1]):
        s += i * b[0]
        i += 1

print(s)
