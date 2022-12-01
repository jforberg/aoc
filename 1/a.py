#!/usr/bin/python3

import numpy as np
import sys

e = [0]

for l in sys.stdin:
    l = l.strip()

    if l:
        e[-1] += int(l)
    else:
        e.append(0)

print(max(e))
