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

    xs = re.split(r'[\[\]]', l)

    abas = set()
    wanted_abas = set()
    ssl = True
    for i, x in enumerate(xs):
        for j in range(len(x)):
            if j < 2:
                continue

            if i % 2 == 0:
                if x[j] == x[j-1] or x[j] != x[j-2]:
                    continue
                abas.add(x[j-2:j+1])
            else:
                if x[j] == x[j-1] or x[j] != x[j-2]:
                    continue
                bab = x[j-2:j+1]

                cand_aba = bab[1] + bab[0] + bab[1]
                wanted_abas.add(cand_aba)

    if abas.intersection(wanted_abas):
        s += 1

print(s)
