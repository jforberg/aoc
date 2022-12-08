#!/usr/bin/python3

import sys
import numpy as np

#f = open('8/small.txt')
f = sys.stdin

a = np.array([list(map(int, list(x))) for x in f.read().strip().split('\n')])

count = 0

def dist(x):
    for i in range(len(x)):
        if x[i] <= 0:
            return i + 1

    return len(x)

best = 0
for i in range(a.shape[0]):
    for j in range(a.shape[1]):
        x = a[i, j]
        up = x - a[:i, j][::-1]
        down = x - a[i+1:, j]
        left = x - a[i, :j][::-1]
        right = x - a[i, j+1:]

        score = dist(up) * dist(down) * dist(left) * dist(right)
        best = max(score, best)

print(best)
