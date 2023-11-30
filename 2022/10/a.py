#!/usr/bin/python3

import sys
import numpy as np

x = 1
c = 0
s = 0

def acc_ss():
    global ss, s

    if c == 20 or (c - 20) % 40 == 0:
        s += c * x

for line in sys.stdin:
    line = line.strip()

    if line == 'noop':
        c += 1
        acc_ss()

    else:
        c += 1
        acc_ss()

        c += 1
        acc_ss()

        op, val = line.split()
        val = int(val)
        x += val

acc_ss()
print(s)
