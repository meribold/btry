.PHONY: run
run: btry
	./btry

btry: btry.s
	gcc $^ -nostdlib -no-pie -s -Wl,-z,noseparate-code,--build-id=none -o $@
	objcopy --remove-section=.note.gnu.property btry

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
