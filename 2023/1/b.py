#!/usr/bin/python3

import numpy as np
import sys

s = 0

for l in open('input.txt'):
    v = ''
    for i in range(len(l)):
        p = l[i:]
        if p[0] in "0123456789":
            v += p[0]
        elif p.startswith('one'):
            v += '1'
        elif p.startswith('two'):
            v += '2'
        elif p.startswith('three'):
            v += '3'
        elif p.startswith('four'):
            v += '4'
        elif p.startswith('five'):
            v += '5'
        elif p.startswith('six'):
            v += '6'
        elif p.startswith('seven'):
            v += '7'
        elif p.startswith('eight'):
            v += '8'
        elif p.startswith('nine'):
            v += '9'

    x = int(v[0] + v[-1])
    s += x

print(s)

