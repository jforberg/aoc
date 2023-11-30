#!/usr/bin/python3

import sys

for line in sys.stdin:
    line = line.strip()

    for i in range(len(line)):
        win = line[i:i+14]
        s = set(list(win))
        if len(s) == 14:
            print(i + 14)
            sys.exit()
