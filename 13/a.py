#!/usr/bin/python3

import sys

data = []

data.append([])

for line in sys.stdin:
    line = line.strip()

    if line == '':
        data.append([])
        continue

    data[-1].append(eval(line))

s = 0

def comp(a, b):
    a_int = isinstance(a, int)
    b_int = isinstance(b, int)

    if a_int and b_int:
        return a - b

    if not a_int and not b_int:
        for i in range(max(len(a), len(b))):
            if i >= len(a):
                return -1
            if i >= len(b):
                return 1
            r = comp(a[i], b[i])
            if r != 0:
                return r
        return 0

    if a_int:
        a = [a]
    else:
        b = [b]
    return comp(a, b)

for i, p in enumerate(data):
    r = comp(p[0], p[1])
    if r < 0:
        s += i + 1

print(s)


