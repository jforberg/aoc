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

    i = 0
    while i < len(l):
        if l[i] != '(':
            i += 1
            s += 1
            continue

        w = l[i + 1: i + 1 + l[i + 1:].find(')')]
        d, r = w.split('x')
        d = int(d)
        r = int(r)

        i += 2 + len(w) + d
        s += r * d

print(s)
