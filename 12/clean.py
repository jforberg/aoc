#!/usr/bin/python3

import numpy as np
from heapq import *
import sys

data = sys.stdin.read().strip()
data = list(map(list, data.split('\n')))

start = ()
end = ()

elev = np.zeros((len(data), len(data[0])), dtype=int)
for idx, _ in np.ndenumerate(elev):
    y, x = idx
    c = data[y][x]

    if c == 'S':
        elev[idx] = 0
        start = idx
    elif c == 'E':
        elev[idx] = ord('z') - ord('a')
        end = idx
    else:
        elev[idx] = ord(data[y][x]) - ord('a')

queue = []
dist = np.ones_like(elev) * 99999
dist[start] = 0

heappush(queue, (0, start))

while queue:
    _, ui = heappop(queue)

    for di in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
        vi = tuple(np.array(ui) + np.array(di))

        if vi[0] not in range(elev.shape[0]) or vi[1] not in range(elev.shape[1]):
            continue

        if elev[vi] > elev[ui] + 1:
            continue

        alt = dist[ui] + 1
        if alt < dist[vi]:
            dist[vi] = alt

            if not any([x[1] == vi for x in queue]):
                heappush(queue, (alt, vi))

print(dist[end])
