#!/usr/bin/python3

import sys
import re
from collections import defaultdict

s = 0

tab = []

acc = []
first = True
for l in open('input.txt'):
    l = l.strip()

    if first:
        a, b = l.split(': ')
        seeds = list(sorted(map(int, b.split())))
        first = False
        continue

    if not l:
        if acc:
            tab.append(list(sorted(acc)))
            acc = []
        continue

    if not l[0].isdigit():
        continue

    a, b, c = l.split()
    acc.append((int(a), int(b), int(c)))

if acc:
    tab.append(list(sorted(acc)))
    acc = []

def forward(x):
    for z in range(len(tab)):
        for t, f, l in tab[z]:
            if x >= f and x < f + l:
                dx = t - f
                x += dx
                break

    return x

best = 2**32

for s in seeds:
    best = min(best, forward(s))

print(best)
