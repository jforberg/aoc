#!/usr/bin/python3

import numpy as np
import sys
import re
from collections import defaultdict

s = 0

sym = defaultdict(bool)
mat = []

y = 0

def isnum(c):
    return c in '0123456789'

for l in open('input.txt'):
    l = l.strip()

    mat.append(l)

    for x in range(len(l)):
        c = l[x]
        if c not in '.0123456789':
            sym[(y, x)] = True

    y += 1

for y in range(len(mat)):
    acc = ''
    valid = False

    for x in range(len(mat[0])):
        c = mat[y][x]

        if isnum(c):
            acc += c
            if (sym[(y, x - 1)] or sym[(y, x + 1)] or sym[(y - 1, x)] or
                  sym[(y + 1, x)] or sym[(y - 1, x - 1)] or sym[(y + 1, x + 1)] or
                  sym[(y + 1, x - 1)] or sym[(y - 1, x + 1)]):
                valid = True
        else:
            if acc and valid:
                s += int(acc)

            acc = ''
            valid = False

    if acc and valid:
        s += int(acc)

print(s)

