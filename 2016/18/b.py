#!/usr/bin/python3

from collections import defaultdict as ddict

inp = '.^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^.......^..^^...^.^.^^..^^^^^...^.'

cols = len(inp)
rows = 400000

m = ddict(lambda: False)

for j in range(cols):
    if inp[j] == '^':
        m[(0, j)] = True

for i in range(1, rows):
    for j in range(cols):
        x = (m[(i - 1, j - 1)], m[(i - 1, j)], m[(i - 1, j + 1)])
        if x in [(True, True, False), (False, True, True), (True, False, False),
                (False, False, True)]:
            m[(i, j)] = True

s = 0
for i in range(0, rows):
    for j in range(cols):
        if not m[(i, j)]:
            s += 1

print(s)
