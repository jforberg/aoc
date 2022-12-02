executables :=

# Day 1 - Python
executables += 1/a.py 1/b.py

# Day 2 - Haskell
executables += 2/a 2/b

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
