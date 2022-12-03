#!/usr/bin/python3

import sys

s = 0

def prio(x):
    if ord(x) >= ord('a') and ord(x) <= ord('z'):
        return ord(x) - ord('a') + 1
    else:
        return ord(x) - ord('A') + 27

for line in sys.stdin:
    line = line.strip()

    is1 = line[:len(line) // 2]
    is2 = line[len(line) // 2:]

    ss1 = set(list(is1))
    ss2 = set(list(is2))

    isect = ss1.intersection(ss2)

    com = list(isect)[0]

    s += prio(com)

print(s)
