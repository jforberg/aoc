#!/usr/bin/python3

import numpy as np
import sys

s = 0

for l in open('input.txt'):
    v = ''
    for c in l:
        if c in "0123456789":
            v += c

    x = int(v[0] + v[-1])
    s += x

print(s)

