# We could also build `btry` in one step with `gcc -nostdlib`.
btry: btry.o
	ld $^ -o $@

btry.o: btry.s
	gcc -c $^

.PHONY: clean
clean:
	rm -rf btry btry.o

.PHONY: strace
strace: btry
	strace ./btry >/dev/null
