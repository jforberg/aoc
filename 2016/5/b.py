#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools
import hashlib

s = 0

did = 'ffykfhsq'

pw = 8 * ['\0']

for i in range(0, 99999999999999):
    s = did + str(i)
    h = hashlib.md5(s.encode()).hexdigest()
    if not h.startswith('00000'):
        continue

    p = int(h[5], base=16)
    if p >= len(pw):
        continue

    if pw[p] != '\0':
        continue

    pw[p] = h[6]

    if '\0' not in pw:
        break

print(''.join(pw))
