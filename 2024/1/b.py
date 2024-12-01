#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

a = np.loadtxt('input.txt', dtype=int)

d = ddict(int)

for x in a[:, 1]:
    d[x] += 1

s = 0
for x in a[:, 0]:
    s += x * d[x]

print(s)
