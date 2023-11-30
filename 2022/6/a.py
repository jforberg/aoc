#!/usr/bin/python3

import sys

for line in sys.stdin:
    line = line.strip()

    for i in range(len(line)):
        win = line[i:i+4]
        s = set(list(win))
        if len(s) == 4:
            print(i + 4)
            sys.exit()
