#!/bin/bash

minizinc -a a.mzn | grep -- ------ | wc -l
