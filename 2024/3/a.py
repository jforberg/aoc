#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    for m in re.findall(r'mul\((\d+),(\d+)\)', l):
        s += int(m[0]) * int(m[1])

print(s)
