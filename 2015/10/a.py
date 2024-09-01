#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re
import itertools

x = '3113322113'

for _ in range(40):
    xx = ''
    last = ''
    acc = 0
    for c in str(x):
        if c == last:
            acc += 1
        else:
            if acc:
                xx += str(acc) + str(last)

            acc = 1

        last = c

    xx += str(acc) + str(last)
    x = xx

print(len(str(x)))
