#!/usr/bin/python3

import numpy as np
from collections import defaultdict as ddict
import sys
import re
import itertools

rules = ddict(list)
arm = False

a = [0]
b = [0]
pc = 0
mem = []

for l in open('input.txt'):
    l = l.strip()
    vs = re.split(r'[, ]+', l)
    mem.append(vs)

while pc >= 0 and pc < len(mem):
    instr, *ops = mem[pc]

    def operand(x):
        if x == 'a':
            return a
        elif x == 'b':
            return b
        else:
            return [int(x)]

    if instr == 'hlf':
        operand(ops[0])[0] //= 2
    elif instr == 'tpl':
        operand(ops[0])[0] *= 3
    elif instr == 'inc':
        operand(ops[0])[0] += 1
    elif instr == 'jmp':
        pc += operand(ops[0])[0]
        continue
    elif instr == 'jie':
        if operand(ops[0])[0] % 2 == 0:
            pc += operand(ops[1])[0]
            continue
    elif instr == 'jio':
        if operand(ops[0])[0] == 1:
            pc += operand(ops[1])[0]
            continue
    else:
        assert False

    pc += 1

print(b[0])
