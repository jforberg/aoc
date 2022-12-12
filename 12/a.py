#!/usr/bin/python3

import sys
import numpy as np
import re
from queue import Queue

elev = []
start = (0,0)
target = (0, 0)

x = 0
y = 0

for line in sys.stdin:
    line = line.strip()

    es = list(line)

    elev.append([])

    for e in es:
        if e == 'S':
            start = (x, y)
            e = 'a'
        elif e == 'E':
            target = (x, y)
            e = 'z'

        h = ord(e) - ord('a')
        elev[-1].append(h)

        x += 1

    y += 1
    x = 0


elev = np.array(elev)

queue = set()
dist = np.zeros_like(elev)
prev = np.zeros(elev.shape + (2,), dtype=int)
for y in range(elev.shape[0]):
    for x in range(elev.shape[1]):
        if (x, y) != start:
            dist[y, x] = 999999
            prev[y, x] = -1
        else:
            dist[y, x] = 0
        queue.add((x, y))

while queue:
    xu, yu = (-1, -1)
    best_dist = 9999999
    for y in range(elev.shape[0]):
        for x in range(elev.shape[1]):
            #print('x=%d y=%d in=%d dist=%d' % (x, y, (x, y) in queue, dist[y, x]))
            if (x, y) in queue and dist[y, x] < best_dist:
                xu, yu = (x, y)
                best_dist = dist[yu, xu]

    queue.remove((xu, yu))

    for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
        if xu + dx < 0 or xu + dx >= elev.shape[1] or yu + dy < 0 or yu + dy >= elev.shape[0]:
            continue

        xv = xu + dx
        yv = yu + dy

        if elev[yv, xv] > elev[yu, xu] + 1:
            continue

        if not (xv, yv) in queue:
            continue

        alt = dist[yu, xu] + 1
        if alt < dist[yv, xv]:
            dist[yv, xv] = alt
            prev[yv, xv, :] = (xu, yu)

print(dist[target[1], target[0]])
