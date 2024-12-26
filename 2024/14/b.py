#!/usr/bin/python3

import re
import numpy as np
import time

inp = open('input.txt').read()
res = re.findall(r'p=([-\d]+),([-\d]+) v=([-\d]+),([-\d]+)', inp)

d = np.array(res).astype(int)

w, h = (101, 103)

pos0 = d[..., 0:2]
vel = d[..., 2:4]

posn = pos0.copy()

k = 0
for n in range(1, 10000):
    posn = (posn + vel) % [w, h]

    count = np.zeros((w, h), dtype=int)
    for idx in posn:
        count[*idx] += 1

    maxcol = np.max(np.sum(count, axis=0))
    maxrow = np.max(np.sum(count, axis=1))
    if maxcol < 18 and maxrow < 18:
        continue

    print(f'{n=}')
    for j in range(h):
        for i in range(w):
            print(2 * ('%d' % count[i, j]) if count[i, j] else '  ', end='')

        print()

    time.sleep(0.2)
