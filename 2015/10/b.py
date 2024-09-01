#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re
import itertools

x = [[3, 1], [1, 2], [3, 2], [2, 2], [1, 2], [3, 1]]
#x = [[1, 1]]

for _ in range(50):
    m = []
    for c, l in x:
        if m and m[-1][0] == c:
            m[-1][1] += l
        else:
            m.append([c, l])

    o = []
    for c, l in m:
        s = str(l)
        last = ''
        acc = 0
        for p in s:
            if p == last:
                acc += 1
            else:
                if acc:
                    o.append([int(last), acc])

                acc = 1

            last = p

        o.append([int(last), acc])
        o.append([c, 1])

    x = o

print(sum([p[1] for p in x]))
