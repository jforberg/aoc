#!/usr/bin/python3

import sys
import re
from collections import defaultdict
import functools

s = 0

card_rank = 'J23456789TJQKA'

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
    jokers = h.count('J')

    d = defaultdict(int)
    for c in h:
        if c != 'J':
            d[c] += 1

    m = max(d.values(), default=0)
    if m == 5 or m + jokers >= 5:
        return 7

    if m == 4 or m + jokers >= 4:
        return 6

    sc = list(sorted(d.values()))
    fh_left = 3 - sc[-1] + 2 - sc[-2]
    if 3 in d.values() and 2 in d.values() or jokers and fh_left <= jokers:
        return 5

    if m == 3 or m + jokers >= 3:
        return 4

    tp_left = 2 - sc[-1] + 2 - sc[-2]
    if list(d.values()).count(2) == 2 or jokers and tp_left <= jokers:
        return 3

    if list(d.values()).count(2) == 1 or jokers:
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
