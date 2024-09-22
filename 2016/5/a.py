#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools
import hashlib

s = 0

did = 'ffykfhsq'

pw = ''

for i in range(0, 99999999999999):
    s = did + str(i)
    h = hashlib.md5(s.encode()).hexdigest()
    if not h.startswith('00000'):
        continue

    pw += h[5]

    if len(pw) == 8:
        break

print(pw)
