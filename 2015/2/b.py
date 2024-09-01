#!/usr/bin/python3

import numpy as np
from collections import defaultdict

s = 0

for l in open('input.txt'):
    l, w, h = map(int, l.split('x'))
    s += min(2 * l + 2 * w,
        2 * w + 2 * h,
        2 * h + 2 * l) + w * h * l

print(s)
