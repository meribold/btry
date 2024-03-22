.PHONY: run
run: btry
	./btry

btry: btry.s
	gcc $^ -nostdlib -no-pie -s -Wl,-z,noseparate-code,--build-id=none -o $@
	objcopy --strip-section-headers btry
	@# Change the first program header's `p_flags` byte from 5 to 7.  This makes the
	@# segment writable in addition to being executable and readable and allows us to use
	@# a single segment for both code and data.
	printf '\x07' | dd of=btry bs=1 seek=68 count=1 conv=notrunc
	./optimize.py

btry-debug: btry.s
	gcc $^ -nostdlib -no-pie -g -o $@

.PHONY: clean
clean:
	rm -rf btry btry-debug

.PHONY: strace
strace: btry
	strace ./btry >/dev/null

.PHONY: debug
debug: btry-debug
	gdb -ex 'tb _start' -ex 'run' -ex 'layout regs' $<
