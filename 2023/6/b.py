#!/usr/bin/python3

import sys
import re
from collections import defaultdict

s = 0

time = []
dist = []
i = 0
for l in open('input.txt'):
    l = l.strip()
    a, b = l.split(':')
    b = b.strip()

    ds = int(''.join(b.split()))

    if i == 0:
        time = ds
    else:
        dist = ds

    i += 1

ways = 0
for t in range(time + 1):
    left = time - t
    if left * t > dist:
        ways += 1

print(ways)
