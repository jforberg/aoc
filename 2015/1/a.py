#!/usr/bin/python3

import numpy as np
from collections import defaultdict

s = 0

for l in open('input.txt'):
    for c in l:
        if c == '(':
            s += 1
        elif c == ')':
            s -= 1

print(s)
