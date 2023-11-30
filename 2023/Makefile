executables :=

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
