#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

def decompr(l):
    s = 0
    while l:
        if l[0] != '(':
            l = l[1:]
            s += 1
            continue

        w = l[1:l.find(')')]
        d, r = w.split('x')
        d = int(d)
        r = int(r)
        l = l[2 + len(w):]

        s += r * decompr(l[:d])
        l = l[d:]

    return s


for l in open('input.txt'):
    l = l.strip()

    print(decompr(l))
