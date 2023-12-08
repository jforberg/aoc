#!/usr/bin/python3

# 1176535205

import sys
import re
from collections import defaultdict

s = 0

tab = {}
rules = ''

for l in open('input.txt'):
    l = l.strip()

    if not rules:
        rules = l
        continue

    if not l:
        continue

    a, b = l.split(' = ')
    m = re.search(r'\((\w+), (\w+)\)', b)
    b1, b2 = (m.group(1), m.group(2))
    tab[a] = (b1, b2)

print('%d x %d' % (len(rules), len(tab.keys())))

path = {}

for n0 in tab.keys():
    for ri0 in range(len(rules)):
        n = n0
        di = 0
        while True:
            if tab[n][0] == n and tab[n][1] == n:
                path[(n0, ri0)] = (n, di)
                break

            ri = (ri0 + di) % len(rules)
            r = rules[ri]
            n = tab[n][0 if r == 'L' else 1]

            di += 1

            if n.endswith('Z'):
                path[(n0, ri0)] = (n, di)
                break

            if (n, ri) in path:
                n2, di2 = path[(n, ri)]
                path[(n0, ri0)] = (n2, di + di2)
                break
    print(n0)

#print(path)

for (n0, ri0), (n2, di) in path.items():
    if n0.endswith('Z'):
        print(n0, ri0, n2, di)

#sys.exit()

pos = set()
for n in tab.keys():
    if n.endswith('A'):
        pos.add((0, n))

print(pos)

first = True
while True:
    #print(pos)

    if not first and min(pos)[0] == max(pos)[0]:
        break

    i0, n0 = min(pos)
    pos.remove((i0, n0))

    ri0 = i0 % len(rules)
    n1, di = path[(n0, ri0)]
    i1 = i0 + di

    #print((n0, di))

    pos.add((i1, n1))

    first = False

print(pos)
