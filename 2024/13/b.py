#!/usr/bin/python3

import re
import numpy as np

r = r'''Button A: X\+(\d+), Y\+(\d+)
Button B: X\+(\d+), Y\+(\d+)
Prize: X=(\d+), Y=(\d+)'''

inp = open('input.txt').read()
res = re.findall(r, inp)

d = np.array(res, dtype=int)

a = d[..., 0:4].reshape((-1, 2, 2))
a = np.moveaxis(a, -1, -2)
y = d[..., 4:6].reshape((-1, 2, 1))
y += 10000000000000
x = np.linalg.solve(a, y)

def isint(m):
    return np.abs(m - np.round(m)) < 1e-3

sol = isint(x) & (x >= 0)
sol = sol[..., 0, 0] & sol[..., 1, 0]

cost = np.moveaxis(x, -1, -2) @ [3, 1]
cost = (sol * cost[:, 0])

print(np.sum(cost).astype(int))
