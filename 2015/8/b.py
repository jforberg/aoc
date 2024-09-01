#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re

s = 0

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    x = 2
    for c in l:
        if c == '"':
            x += 2
        elif c == '\\':
            x += 2
        else:
            x += 1

    s += x - len(l)

print(s)
