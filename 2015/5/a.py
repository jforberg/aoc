#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys

s = 0

for l in open('input.txt'):
    if 'ab' in l or 'cd' in l or 'pq' in l or 'xy' in l:
        continue

    vowels = 0
    twice = 0
    last = '\0'

    for c in l:
        if c in 'aeiou':
            vowels += 1

        if last == c:
            twice = 1

        last = c

    if twice and vowels >= 3:
        s += 1

print(s)
