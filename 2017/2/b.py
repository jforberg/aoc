#!/usr/bin/python
import numpy as np

d = np.loadtxt('input.txt', dtype=int)

s = 0
for i in range(d.shape[0]):
    for j in range(d.shape[1]):
        for k in range(d.shape[1]):
            if j == k:
                continue

            if d[i, j] % d[i, k] != 0:
                continue

            s += d[i, j] // d[i, k]
            break

print(s)
