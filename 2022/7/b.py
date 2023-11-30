#!/usr/bin/python3

import sys

sizes = {}
counts = {}

path = ['']
seen_files = set()

tot = 0

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
                continue

            seen_files.add(fp)

            for i in range(len(path)):
                p = '/'.join(path[:i + 1])
                if not p in sizes:
                    sizes[p] = 0
                    counts[p] = 0

                sizes[p] += int(stat)
                counts[p] += 1

            tot += int(stat)

have = 70000000 - tot
need = 30000000 - have
sel = min([s for s in sizes.values() if s >= need])

print(sel)
