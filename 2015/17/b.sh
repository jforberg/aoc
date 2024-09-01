#!/bin/bash

minizinc -a b.mzn | grep -- ------ | wc -l
