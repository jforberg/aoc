#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

a = np.loadtxt('input.txt', dtype=int)
b = np.sort(a, axis=0)
c = np.sum(np.abs(np.diff(b, axis=1)))
print(c)
