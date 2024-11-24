#!/usr/bin/python3

l = 35651584

init = '01000100010010111'

d = init
while len(d) < l:
    b = d[::-1]
    b = b.replace('0', 'a').replace('1', '0').replace('a', '1')
    d = d + '0' + b

d = d[:l]

cs = d
while True:
    s0 = cs[::2]
    s1 = cs[1::2]
    cs = ''.join([ '1' if a == b else '0' for a, b in zip(s0, s1) ])

    if len(cs) % 2:
        break

print(cs)
