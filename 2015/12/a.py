#!/usr/bin/python3

import numpy as np
from collections import defaultdict
import sys
import re
import itertools
import json

s = 0

j = json.load(open('input.txt'))

def f(x):
    global s

    if isinstance(x, int):
        s += x

    if isinstance(x, list):
        for e in x:
            f(e)

    if isinstance(x, dict):
        for e in x.values():
            f(e)

f(j)

print(s)
