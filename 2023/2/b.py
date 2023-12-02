#!/usr/bin/python3

import numpy as np
import sys
import re

su = 0

for l in open('input.txt'):
    l = l.strip()

    a, b = l.split(': ')

    i = re.search(r'Game (\d+)', a).group(1)
    i = int(i)

    rs = b.split('; ')

    mr = mg = mb = 0

    for r in rs:
        ss = r.split(', ')

        for s in ss:
            c, t = s.split(' ')
            c = int(c)

            if t == 'red':
                mr = max(mr, c)
            elif t == 'green':
                mg = max(mg, c)
            elif t == 'blue':
                mb = max(mb, c)

    p = mr * mg * mb

    su += p

print(su)

