.PHONY: run
run: btry
	./btry

btry.o: btry.s
	as -mx86-used-note=no $< -o $@

btry: btry.o
	objcopy -O binary $< $@
	chmod +x $@

.PHONY: clean
clean:
	rm -f btry.o btry

.PHONY: strace
strace: btry
	strace ./btry >/dev/null
