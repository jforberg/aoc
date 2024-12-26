#!/usr/bin/python3

import re
import numpy as np

inp = open('input.txt').read()
res = re.findall(r'p=([-\d]+),([-\d]+) v=([-\d]+),([-\d]+)', inp)

d = np.array(res).astype(int)

w, h = (101, 103)
n = 100

pos0 = d[..., 0:2]
vel = d[..., 2:4]

posn = (pos0 + n * vel) % (w, h)

count = np.zeros((w, h), dtype=int)
for idx in posn:
    count[*idx] += 1

q0 = count[:w//2, :h//2]
q1 = count[(w + 1)//2:, :h//2]
q2 = count[:w//2, (h//2 + 1):]
q3 = count[(w//2 + 1):, (h//2 + 1):]

sf = np.sum(q0) * np.sum(q1) * np.sum(q2) * np.sum(q3)
print(sf)
