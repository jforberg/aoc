#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

vel = {}
time = {}
rest = {}
fly_left = ddict(int)
rest_left = ddict(int)
pos = ddict(int)
points = ddict(int)

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    m = re.search(r'(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds', l)
    n, v, t, r = m.groups()
    v = int(v)
    t = int(t)
    r = int(r)

    vel[n] = v
    time[n] = t
    rest[n] = r
    fly_left[n] = t

for i in range(2503):
    for n in vel.keys():
        if fly_left[n]:
            pos[n] += vel[n]
            fly_left[n] -= 1

            if not fly_left[n]:
                rest_left[n] = rest[n]
        else:
            rest_left[n] -= 1
            if not rest_left[n]:
                fly_left[n] = time[n]

    m = max(pos.values())
    for n in vel.keys():
        if pos[n] == m:
            points[n] += 1

print(max(points.values()))
