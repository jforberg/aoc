#!/usr/bin/python3

import numpy as np
from collections import defaultdict

s = 0

for l in open('input.txt'):
    l, w, h = map(int, l.split('x'))
    s += 2 * l * w + 2 * w * h + 2 * h * l + \
        min(l * w, w * h, h * l)

print(s)
