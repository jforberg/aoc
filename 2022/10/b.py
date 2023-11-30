#!/usr/bin/python3

import sys
import numpy as np

x = 1
c = 0

def acc_ss():
    global ss, s

    xc = c % 40
    print('#' if abs(xc - x) <= 1 else '.', end='')
    if (c + 1) % 40 == 0:
        print()

for line in sys.stdin:
    line = line.strip()

    if line == 'noop':
        acc_ss()
        c += 1

    else:
        acc_ss()
        c += 1

        acc_ss()
        c += 1

        op, val = line.split()
        val = int(val)
        x += val

acc_ss()
