#!/usr/bin/python3

import sys

s = 0
g = set()

def prio(x):
    if ord(x) >= ord('a') and ord(x) <= ord('z'):
        return ord(x) - ord('a') + 1
    else:
        return ord(x) - ord('A') + 27

for i, line in enumerate(sys.stdin):
    line = line.strip()

    if i % 3 == 0:
        if g:
            s += prio(list(g)[0])

        g = set(list(line))
    else:
        g = g.intersection(set(list(line)))

if g:
    s += prio(list(g)[0])

print(s)
