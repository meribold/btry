.PHONY: run
run: btry
	./btry

btry: btry.s
	gcc $^ -nostdlib -no-pie -o $@

.PHONY: clean
clean:
	rm -rf btry

.PHONY: strace
strace: btry
	strace ./btry >/dev/null

.PHONY: debug
debug: btry
	gdb -ex 'tb _start' -ex 'run' -ex 'layout regs' ./btry
