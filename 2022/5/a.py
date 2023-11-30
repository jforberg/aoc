#!/usr/bin/python3

import sys
import re

stacks = [
    list('BVWTQNHD'),
    list('BWD'),
    list('CJWQST'),
    list('PTZNRJF'),
    list('TSMJVPG'),
    list('NTFWB'),
    list('NVHFQDLB'),
    list('RFPH'),
    list('HPNLBMSZ'),
]

for i in range(len(stacks)):
    stacks[i] = list(reversed(stacks[i]))

seen_blank=False
for line in sys.stdin:
    line = line.strip()
    if not line:
        seen_blank = True
        continue

    if not seen_blank:
        continue

    m = re.search(r'move ([0-9]+) from ([0-9]+) to ([0-9]+)', line)
    c, f, t = (int(m.group(1)), int(m.group(2)) - 1, int(m.group(3)) - 1)

    for i in range(c):
        x = stacks[f].pop()
        stacks[t].append(x)

for s in stacks:
    print(s[-1], end='')


print()


