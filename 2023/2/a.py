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

    valid = True

    for r in rs:
        ss = r.split(', ')

        for s in ss:
            c, t = s.split(' ')
            c = int(c)

            if t == 'red' and c > 12:
                valid = False
                break
            elif t == 'green' and c  > 13:
                valid = False
                break
            elif t == 'blue' and c > 14:
                valid = False
                break

        if not valid:
            break

    if valid:
        su += i

print(su)

