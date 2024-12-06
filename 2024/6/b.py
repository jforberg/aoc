#!/usr/bin/python3

from collections import defaultdict as ddict
import sys
import re
import itertools
import copy

orig_passable = ddict(lambda: True)
orig_pos = None
grid = set()

for i, l in enumerate(open('input.txt')):
    l = l.strip()

    for j, c in enumerate(l):
        if c == '^':
            orig_pos = (i, j)
        orig_passable[(i, j)] = c != '#'
        grid.add((i, j))

def loops(p):
    d = (-1, 0)
    been_dir = set()
    pos = orig_pos

    def rot(r):
        if r == (-1, 0):
            return (0, 1)
        elif r == (0, 1):
            return (1, 0)
        elif r == (1, 0):
            return (0, -1)
        elif r == (0, -1):
            return (-1, 0)
        else:
            assert False

    while True:
        if pos not in grid:
            return False

        if (pos, d) in been_dir:
            return True

        been_dir.add((pos, d))
        i, j = pos

        i2 = i + d[0]
        j2 = j + d[1]

        if pos == p or not orig_passable[(i2, j2)]:
            d = rot(d)
            continue

        pos = (i2, j2)

s = 0
for p in grid:
    if not orig_passable[p]:
        continue

    if loops(p):
        s += 1

print(s)
