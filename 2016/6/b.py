#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

tab = []
for i in range(8):
    tab.append(ddict(int))

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    for i, c in enumerate(l):
        tab[i][c] += 1

msg = ''
for i in range(8):
    msg += list(sorted(tab[i].items(), key=lambda x: x[1]))[0][0]

print(msg)
