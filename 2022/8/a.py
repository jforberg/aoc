#!/usr/bin/python3

import sys
import numpy as np

#f = open('8/small.txt')
f = sys.stdin

a = np.array([list(map(int, list(x))) for x in f.read().strip().split('\n')])

count = 0

for i in range(a.shape[0]):
    for j in range(a.shape[0]):
        x = a[i, j]
        if np.all(a[i, :j] < x) or np.all(a[i, j+1:] < x) or np.all(a[:i, j] < x) or np.all(a[i+1:, j] < x):
            count +=1

print(count)
