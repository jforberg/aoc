#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools
from collections import deque

def adjacent_states(n):
    s = np.array(n, dtype=int)
    cur_floor = s[-1]
    for next_floor in [cur_floor - 1, cur_floor + 1]:
        if next_floor < 0 or next_floor > 3:
            continue

        items_on_floor = np.argwhere(s[:-1] == cur_floor).ravel()
        combs = (list(itertools.combinations(items_on_floor, 2)) +
            list(items_on_floor))

        for c in combs:
            c = np.array(c)
            new = s.copy()
            new[c] = next_floor
            new[-1] = next_floor
            if valid_state(new):
                yield tuple(map(int, new))

def valid_state(s):
    x = s[:-1].reshape((-1, 2))

    for i in range(x.shape[0]):
        if x[i, 1] == x[i, 0]:
            continue

        for j in range(x.shape[0]):
            if j == i:
                continue

            if x[j, 0] == x[i, 1]:
                return False

    return True

#            pog poc tg tc prg prc rg rc cg cc me
start_node = (0, 1,  0, 0, 0,  1,  0, 0, 0, 0, 0)
#start_node = (1, 0, 2, 0, 0)

final_node = tuple(11 * [3])
#final_node = tuple(5 * [3])

explored = set([start_node])
queue = deque([start_node, None])

level = 0
while queue:
    v = queue.popleft()

    if v is None:
        level += 1
        queue.append(None)
        continue

    if v == final_node:
        print(level)
        sys.exit()

    for w in adjacent_states(v):
        if w in explored:
            continue

        explored.add(w)
        queue.append(w)

print('nooo')
