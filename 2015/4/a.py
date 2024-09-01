#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import hashlib
import sys

base_k = 'ckczppom'

for i in range(999999999999):
    k = base_k + str(i)
    h = hashlib.md5(k.encode('ascii')).hexdigest()

    if h.startswith('00000'):
        print(i)
        sys.exit()

