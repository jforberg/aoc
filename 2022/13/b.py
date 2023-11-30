#!/usr/bin/python3

import sys
import functools

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


allps = []
for p in data:
    allps.append(p[0])
    allps.append(p[1])

allps.append([[2]])
allps.append([[6]])

allps = list(sorted(allps, key=functools.cmp_to_key(comp)))

s = 1
for i, v in enumerate(allps):
    if v == [[2]]:
        s *= i + 1
    if v == [[6]]:
        s *= i + 1

print(s)
