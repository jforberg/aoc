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

    v = eval(l)
    s += len(l) - len(v)

print(s)
