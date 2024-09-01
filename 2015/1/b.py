#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys

s = 0
i = 1

for l in open('input.txt'):
    for c in l:
        if c == '(':
            s += 1
        elif c == ')':
            s -= 1

        if s < 0:
            print(i)
            sys.exit(0)
        i += 1

print(s)
