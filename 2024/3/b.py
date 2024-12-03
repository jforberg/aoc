#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

do = True

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue

    for m in re.findall(r"(mul|do|don't)\(((\d+),(\d+))?\)", l):
        if m[0] == 'mul':
            if do:
                s += int(m[2]) * int(m[3])
        elif m[0] == 'do':
            do = True
        elif m[0] == "don't":
            do = False
        else:
            assert False

print(s)
