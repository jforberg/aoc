#!/usr/bin/python3

import re

s = 'abcdefgh'
#s = 'abcde'

for l in open('input.txt'):
    l = l.strip()

    if m := re.search(r'rotate (\w+) (\d+) steps?', l):
        d = m.group(1)
        x = int(m.group(2))
        if d == 'right':
            s = s[-x:] + s[:-x]
        elif d == 'left':
            s = s[x:] + s[:x]
        else:
            assert False
    elif m := re.search(r'rotate based on position of letter (\w)', l):
        c = m.group(1)
        i = s.find(c)
        x = 1 + i + (1 if i >= 4 else 0)
        x = x % len(s)
        s = s[-x:] + s[:-x]
    elif m := re.search(r'swap letter (\w) with letter (\w)', l):
        a, b = m.groups()
        s = s.replace(a, 'X').replace(b, a).replace('X', b)
    elif m := re.search(r'move position (\d+) to position (\d+)', l):
        f = int(m.group(1))
        t = int(m.group(2))
        c = s[f]
        s = s[:f] + s[f + 1:]
        s = s[:t] + c + s[t:]
    elif m := re.search(r'swap position (\d+) with position (\d+)', l):
        a = int(m.group(1))
        b = int(m.group(2))
        ss = list(s)
        ss[a] = s[b]
        ss[b] = s[a]
        s = ''.join(ss)
    elif m := re.search(r'reverse positions (\d+) through (\d+)', l):
        ff = int(m.group(1))
        tt = int(m.group(2))
        f = min([ff, tt])
        t = max([ff, tt])
        ss = s[f:t + 1]
        s = s[:f] + ss[::-1] + s[t + 1:]
    else:
        raise RuntimeError(l)

print(s)
