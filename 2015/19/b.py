#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

rules = []
arm = False

for l in open('input.txt'):
    l = l.strip()

    if not l:
        arm = True
        continue

    if arm:
        target = l
    else:
        have, get = l.split(' => ')
        rules.append((have, get))

current = target
steps = 0

while current != 'e':
    best_l = 0
    best_i = -1
    best_h = None
    for have, get in rules:
        i = current.find(get)
        if i < 0:
            continue

        if len(get) > best_l:
            best_l = len(get)
            best_i = i
            best_h = have

    assert best_i >= 0

    current = current[:best_i] + best_h + current[best_i + best_l:]
    steps += 1

print(steps)
