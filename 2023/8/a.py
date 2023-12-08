#!/usr/bin/python3

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

i = 0
p = 'AAA'
while p != 'ZZZ':
    if rules[i % len(rules)] == 'L':
        p = tab[p][0]
    else:
        p = tab[p][1]

    i += 1

print(i)
