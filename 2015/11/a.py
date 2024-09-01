#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re
import itertools

s = 'hxbxwxba'

def incr(x):
    c = 1

    n = 8 * ['']

    for i in range(len(n) - 1, -1, -1):
        v = ord(x[i]) + c
        c = 0

        if v > ord('z'):
            v = ord('a')
            c = 1

        n[i] = chr(v)

    return ''.join(n)

while True:
    s = incr(s)

    if 'i' in s or 'o' in s or 'l' in s:
        continue

    l = np.diff(list(map(ord, s)))
    ok = False
    for a, b in zip(l, l[1:]):
        ok = ok or (a == 1 and b == 1)

    if not ok:
        continue

    pair = defaultdict(list)
    last = ''
    for i, c in enumerate(s):
        if c == last:
            pair[last + c].append(i)
        last = c

    if len(pair.keys()) < 2:
        continue

    break

print(s)
