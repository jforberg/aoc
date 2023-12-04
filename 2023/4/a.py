#!/usr/bin/python3

import numpy as np
import sys
import re
from collections import defaultdict

s = 0

for l in open('input.txt'):
    l = l.strip()

    a, b = l.split(': ')
    b = b.strip()
    a, b = b.split(' | ')

    w = [int(aa) for aa in a.split()]
    h = [int(bb) for bb in b.split()]

    t = 0
    for wx in w:
        if not wx in h:
            continue

        t = 1 if t == 0 else t * 2

    s += t

print(s)

