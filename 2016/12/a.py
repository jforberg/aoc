#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

s = 0

regs = ddict(int)

def val(x):
    try:
        return int(x)
    except ValueError:
        return regs[x]

imem = []
pc = 0

for l in open('input.txt'):
    l = l.strip()
    if not l:
        continue


    imem.append(l.split())

while pc < len(imem):
    instr = imem[pc]

    match instr:
        case ['cpy', x, y]:
            regs[y] = val(x)
        case ['inc', x]:
            regs[x] += 1
        case ['dec', x]:
            regs[x] -= 1
        case ['jnz', x, y]:
            if val(x):
                pc += val(y)
                continue
        case _:
            assert False

    pc += 1

print(val('a'))
