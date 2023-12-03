#!/usr/bin/python3

import numpy as np
import sys
import re
from collections import defaultdict

s = 0

mat = []

y = 0

def isnum(c):
    return c in '0123456789'

for l in open('input.txt'):
    l = l.strip()
    mat.append(l)

part = {}
touch = defaultdict(int)
id = 1
for y in range(len(mat)):
    acc = ''
    valid = False

    for x in range(len(mat[0])):
        c = mat[y][x]

        if isnum(c):
            acc += c
            touch[(y, x)] = id
        else:
            if acc:
                part[id] = int(acc)
                id += 1
                acc = ''

    if acc:
        part[id] = int(acc)
        id += 1

for y in range(len(mat)):
    for x in range(len(mat[0])):
        if mat[y][x] != '*':
            continue

        ids = set()
        ids.add(touch[(y - 1, x - 1)])
        ids.add(touch[(y - 1, x)])
        ids.add(touch[(y - 1, x + 1)])
        ids.add(touch[(y, x + 1)])
        ids.add(touch[(y + 1, x + 1)])
        ids.add(touch[(y + 1, x)])
        ids.add(touch[(y + 1, x - 1)])
        ids.add(touch[(y, x - 1)])
        ids.remove(0)

        if len(ids) != 2:
            continue

        v = 1
        for i in ids:
            v *= part[i]

        s += v

print(s)
