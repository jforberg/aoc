#!/usr/bin/python3

import sys
import numpy as np

visited = set()

pos = np.zeros((10, 2))

for line in sys.stdin:
    line = line.strip()
    d, l = line.split()
    l = int(l)

    for i in range(l):
        visited.add((pos[-1, 0], pos[-1, 1]))

        if d == 'U':
            pos[0, 1] += 1
        elif d == 'R':
            pos[0, 0] += 1
        elif d == 'D':
            pos[0, 1] -= 1
        elif d == 'L':
            pos[0, 0] -= 1

        for j in range(1, pos.shape[0]):
            if abs(pos[j, 0] - pos[j - 1, 0]) < 2 and abs(pos[j, 1] - pos[j - 1, 1]) < 2:
                continue

            if pos[j, 1] == pos[j - 1, 1]:
                pos[j, 0] += np.sign(pos[j - 1, 0] - pos[j, 0])
            elif pos[j, 0] == pos[j - 1, 0]:
                pos[j, 1] += np.sign(pos[j - 1, 1] - pos[j, 1])
            else:
                pos[j, 0] += np.sign(pos[j - 1, 0] - pos[j, 0])
                pos[j, 1] += np.sign(pos[j - 1, 1] - pos[j, 1])

visited.add((pos[-1, 0], pos[-1, 1]))

print(len(visited))
