#!/usr/bin/python3

import sys

def torange(x):
    a, b = x.split('-')
    return int(a), int(b)

s = 0

for line in sys.stdin:
    line = line.strip()
    a, b = line.split(',')
    x0, x1 = torange(a)
    y0, y1 = torange(b)

    l0 = min(x0, y0)
    l1 = max(x0, y0)
    h0 = min(x1, y1)
    h1 = max(x1, y1)

    if h0 >= l1:
        s += 1

print(s)
