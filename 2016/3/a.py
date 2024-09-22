#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

tri = np.loadtxt('input.txt', dtype=int)

t = ((tri[:, 0] + tri[:, 1] > tri[:, 2]) &
    (tri[:, 0] + tri[:, 2] > tri[:, 1]) &
    (tri[:, 1] + tri[:, 2] > tri[:, 0]))

print(np.count_nonzero(t))
