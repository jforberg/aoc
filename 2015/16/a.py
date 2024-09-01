#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

table = ddict(lambda: ddict(lambda: -1))

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue
    n = l.split(': ')[0]
    xs = l[len(n) + 2:].split(', ')
    for x in xs:
        p, c = x.split(': ')
        table[n][p] = int(c)

wanted = {
    'children': 3,
    'cats': 7,
    'samoyeds': 2,
    'pomeranians': 3,
    'akitas': 0,
    'vizslas': 0,
    'goldfish': 5,
    'trees': 3,
    'cars': 2,
    'perfumes': 1,
}

for n, x in table.items():
    c = 0
    for p, v in wanted.items():
        if v == x[p]:
            c += 1

    if c == 3:
        print(n.split(' ')[1])
        sys.exit()
