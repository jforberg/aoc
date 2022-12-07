#!/usr/bin/python3

import sys

sizes = {}
counts = {}

path = ['']
seen_files = set()

for line in sys.stdin:
    line = line.strip()

    if line[:4] == '$ cd':
        t = line[5:]
        if t == '/':
            path = ['']
        elif t == '..':
            path.pop()
        else:
            path.append(t)
    elif line[:4] == '$ ls':
        continue
    else:
        stat, name = line.split()
        if stat == 'dir':
            pass
        else:
            fp = '/'.join(path + [name])
            if fp in seen_files:
                pass

            seen_files.add(fp)

            for i in range(len(path)):
                p = '/'.join(path[:i + 1])
                if not p in sizes:
                    sizes[p] = 0
                    counts[p] = 0

                sizes[p] += int(stat)
                counts[p] += 1

tot = 0
for p in sizes:
    s = sizes[p]

    if s <= 100000:
        tot += s

print(tot)
