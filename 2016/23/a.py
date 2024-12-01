#!/usr/bin/python3

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

regs['a'] = 7

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
        case ['tgl', x]:
            addr = pc + val(x)
            if addr < len(imem):
                ptr = imem[pc + val(x)]
                old = ptr[:]
                match ptr:
                    case ['inc', y]:
                        ptr[:] = ['dec', y]
                    case [_, y]:
                        ptr[:] = ['inc', y]
                    case ['jnz', y, z]:
                        ptr[:] = ['cpy', y, z]
                    case [_, y, z]:
                        ptr[:] = ['jnz', y, z]
        case _:
            assert False

    pc += 1

print(val('a'))
