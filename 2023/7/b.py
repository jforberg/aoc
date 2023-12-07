#!/usr/bin/python3

import sys
import re
from collections import defaultdict
import functools

s = 0

card_rank = '23456789TJQKA'

hands = []
bids = []
hands_bids = {}

for l in open('input.txt'):
    l = l.strip()

    a, b = l.split()
    hands.append(a)
    bids.append(int(b))
    hands_bids[a] = int(b)

def hand_type(h):
    d = defaultdict(int)
    for c in h:
        d[c] += 1

    m = max(d.values())
    if m == 5:
        return 7

    if m == 4:
        return 6

    if 3 in d.values() and 2 in d.values():
        return 5

    if m == 3:
        return 4

    if list(d.values()).count(2) == 2:
        return 3

    if list(d.values()).count(2) == 1:
        return 2

    return 1

def comp(a, b):
    at = hand_type(a)
    bt = hand_type(b)

    if at - bt != 0:
        return at - bt

    for i in range(len(a)):
        ac = card_rank.index(a[i])
        bc = card_rank.index(b[i])
        if ac - bc != 0:
            return ac - bc

ranked = list(sorted(hands, key=functools.cmp_to_key(comp)))

for i, h in enumerate(ranked):
    s += (i + 1) * hands_bids[h]

print(s)
