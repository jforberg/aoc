#!/usr/bin/python3

import sys
import numpy as np
import re

items = []
op = []
divisible = []
if_true = []
if_false = []
n = 0

for line in sys.stdin:
    line = line.strip()

    m = re.search(r'Starting items: (.*)', line)
    if m:
        items.append(list([int(x) for x in m.group(1).split(',')]))
        n += 1

    m = re.search(r'Operation: new = old (.) (.*)', line)
    if m:
        if m.group(1) == '*':
            if m.group(2) == 'old':
                op.append(lambda x: x * x)
            else:
                v = int(m.group(2))
                op.append(lambda x: x * v)
        elif m.group(1) == '+':
            if m.group(2) == 'old':
                op.append(lambda x: x + x)
            else:
                v = int(m.group(2))
                op.append(lambda x: x + v)
        else:
            assert False

    m = re.search(r'Test: divisible by (.*)', line)
    if m:
        divisible.append(int(m.group(1)))

    m = re.search(r'If true: throw to monkey (.*)', line)
    if m:
        if_true.append(int(m.group(1)))

    m = re.search(r'If false: throw to monkey (.*)', line)
    if m:
        if_false.append(int(m.group(1)))

op = [
        lambda x: x * 11,
        lambda x: x * x,
        lambda x: x + 1,
        lambda x: x + 2,
        lambda x: x * 13,
        lambda x: x + 5,
        lambda x: x + 6,
        lambda x: x + 7,
]

#op = [
#        lambda x: x * 19,
#        lambda x: x + 6,
#        lambda x: x * x,
#        lambda x: x + 3,
#]

count = [0] * n

modulo = np.product(divisible)

for t in range(10000):
    for i in range(n):
        for j, it in enumerate(items[i]):
            count[i] += 1
            wl = op[i](it) % modulo

            if wl % divisible[i] == 0:
                items[if_true[i]].append(wl)
            else:
                items[if_false[i]].append(wl)

        items[i] = []

ms = list(sorted(count))
print(ms[-1] * ms[-2])
