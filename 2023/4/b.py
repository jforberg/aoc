#!/usr/bin/python3

import numpy as np
import sys
import re
from collections import defaultdict

s = 0

tab = {}
score = {}
hand = defaultdict(int)

for l in open('input.txt'):
    l = l.strip()

    a, b = l.split(': ')
    b = b.strip()
    _, n = a.split()
    n = int(n)
    a, b = b.split(' | ')

    w = [int(aa) for aa in a.split()]
    h = [int(bb) for bb in b.split()]

    tab[n] = (w, h)
    hand[n] += 1

    t = 0
    for wx in w:
        if not wx in h:
            continue

        t += 1

    score[n] = t

while hand:
    ks = hand.keys()
    n = list(ks)[0]
    c = hand.pop(n)
    s += c

    for i in range(score[n]):
        hand[n + i + 1] += c

print(s)

