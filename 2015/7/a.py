#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re

rules = {}
cache = {}

def lookup(k):
    if k in cache:
        return cache[k]

    if k[0].isdigit():
        v = int(k)
    else:
        v = rules[k]()

    cache[k] = v
    return v

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    a, out = l.split(' -> ')

    xs = a.split()
    if len(xs) == 1:
        rules[out] = lambda xs=xs: lookup(xs[0])
    elif len(xs) == 2:
        assert xs[0] == 'NOT'
        rules[out] = lambda xs=xs: ~lookup(xs[1]) & 0xffff
    elif len(xs) == 3:
        if xs[1] == 'AND':
            rules[out] = lambda xs=xs: lookup(xs[0]) & lookup(xs[2])
        elif xs[1] == 'OR':
            rules[out] = lambda xs=xs: lookup(xs[0]) | lookup(xs[2])
        elif xs[1] == 'LSHIFT':
            rules[out] = lambda xs=xs: (lookup(xs[0]) << lookup(xs[2])) & 0xffff
        elif xs[1] == 'RSHIFT':
            rules[out] = lambda xs=xs: lookup(xs[0]) >> lookup(xs[2])

print(lookup('a'))
