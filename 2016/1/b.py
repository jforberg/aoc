#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

pos = (0, 0)
dir = 0 # N, E, S, W
visited = set()

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    xs = l.split(', ')
    for x in xs:

        d = x[0]
        l = int(x[1:])

        if d == 'R':
            dir += 1
            dir %= 4
        elif d == 'L':
            dir -= 1
            dir += 4
            dir %= 4
        else:
            assert False

        dir_table = [(0, -1), (1, 0), (0, 1), (-1, 0)]

        dx, dy = dir_table[dir]

        do_break = False

        for i in range(l):
            px, py = pos
            pos = (px + dx, py + dy)
            if pos in visited:
                do_break = True
                break

            visited.add(pos)

        if do_break:
            break

print(abs(pos[0]) + abs(pos[1]))
