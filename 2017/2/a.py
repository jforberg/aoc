#!/usr/bin/python
import numpy as np

d = np.loadtxt('input.txt', dtype=int)

print(np.sum(np.max(d, axis=1) - np.min(d, axis=1)))
