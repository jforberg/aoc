#!/usr/bin/python3

import subprocess

def fmt(a):
    return '[|' + '\n|'.join([ ','.join(map(str, x)) for x in a ]) + '|]'

s = 0

for l in open('input.txt'):
    ws = l.strip().split()
    buttons = []
    for b in ws[1:-1]:
        buttons.append(list(map(int, b[1:-1].split(','))))
    target = list(map(int, ws[-1][1:-1].split(',')))
    n = len(target)

    buttons_onehot = []
    for b in buttons:
        buttons_onehot.append([0] * n)
        for x in b:
            buttons_onehot[-1][x] = 1

    k = len(buttons_onehot)

    dzn = open('gen.dzn', 'w')
    print(f'''
n = {n};
k = {k};
target = {target};
button = {fmt(buttons_onehot)};
    ''', file=dzn, flush=True)

    o = subprocess.check_output(['minizinc', '--solver', 'mip', 'b.mzn', '-d', 'gen.dzn'])
    s += int(o.split()[0])

print(s)
