executables :=

# Day 1 - Python
executables += 1/a.py 1/b.py

# Day 2 - Haskell
executables += 2/a 2/b

# Day 3 - Python
executables += 3/a.py 3/b.py

# Day 4 - Python
executables += 4/a.py 4/b.py

# Day 5 - Python
executables += 5/a.py 5/b.py

# Day 6 - Python
executables += 6/a.py 6/b.py

# Day 7 - Python
executables += 7/a.py 7/b.py

# Day 8 - Python
executables += 8/a.py 8/b.py

# Day 9 - Python
executables += 9/a.py 9/b.py

# Day 10 - Python
executables += 10/a.py 10/b.py

# Day 11 - Python
executables += 11/a.py 11/b.py

# Day 12 - Python
executables += 12/a.py 12/b.py

# Day 13 - Python
executables += 13/a.py 13/b.py

# Day 14 - Python
executables += 14/a.py 14/b.py

# Day 15 - Python
executables += 15/a.py 15/b.py

results := $(addprefix .results/, $(executables))

# Main rules
.PHONY: run
run: $(results)

.PHONY: runall
runall: $(executables)
	echo; \
	echo --------------------; \
	echo; \
	for e in $(executables); do \
		number="$$(dirname $$e)"; \
		name="$${e%%.*}"; \
		printf "$$name\t"; \
		"./$$e" <"$$number"/input.txt; \
	done; \
	echo


.PHONY: clean
clean:
	git clean -fdX

# Running solutions to get a result
.results/%: %
	@mkdir -p $(dir $@)
	$< >$@ <$(dir $<)/input.txt
	@cat $@

# Build rules for C code
CFLAGS := $(shell pkg-config --cflags glib-2.0) -O2 -Wall -Wno-unused-function -ggdb
LDLIBS := $(shell pkg-config --libs glib-2.0)

# Build rules for Haskell codes
HSFLAGS := -O2

%: %.hs
	stack ghc -- $(HSFLAGS) -o $@ $<
