#!/usr/bin/python3

import sys
import re
from collections import defaultdict

s = 0

time = []
dist = []
i = 0
for l in open('input.txt'):
    l = l.strip()
    a, b = l.split(':')
    b = b.strip()

    ds = list(map(int, b.split()))

    if i == 0:
        time = ds
    else:
        dist = ds

    i += 1

prod = 1
for i in range(len(time)):
    ways = 0
    for t in range(time[i] + 1):
        left = time[i] - t
        if left * t > dist[i]:
            ways += 1

    prod *= ways

print(prod)
