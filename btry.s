.byte 0x7f
.ascii "ELF"
.byte 2, 1, 1, 0, 0
.zero 7
.short 2, 0x3e
.long 1
.quad 0x400113, 0x38
.ascii "\0\0\0\0\0%)\n"
.long 0
.short 0x40, 0x38

.long 1, 7
.quad 0, 0x400000, 0x400000, 0x1ba, 0x1bb, 0x1000

# read the file specified via %rdi; convert the contents to an integer stored in %r14
get_number:
    # e.g. open("/sys/class/power_supply/BAT0/energy_now", O_RDONLY)
    xor     %eax, %eax
    mov     $2, %al    # system call 2 is open
    xor     %esi, %esi # 0 means read-only
    syscall

    # sometimes there are no energy_* files but charge_* files instead
    test    %rax, %rax
    js      charge

    # read(fd, buffer, 9)
    mov     %eax, %edi # open returns a file descriptor in %rax; read expects it in %rdi
    xor     %eax, %eax # system call 0 is read
    lea     -9(%rsp), %rsi # save file contents read from fd on the stack
    xor     %edx, %edx
    mov     $9, %dl    # read up to 9 bytes
    syscall            # the number of bytes read go into %rax

    # convert file contents to an integer (stored in %r14)
    dec     %al # subtract 1 so we don't process the newline
    xor     %r14d, %r14d
    xor     %ecx, %ecx
    xor     %edx, %edx
next_char:
    imul    $10, %r14
    mov     -9(%rsp, %rcx), %dl # load one character/byte/digit
    sub     $'0, %dl            # convert the character from ASCII
    add     %rdx, %r14          # add this digit
    inc     %rcx
    cmp     %rcx, %rax
    jne     next_char
    ret
charge:
    mov     $0x4120, %r12w # " A"

    # change the path to "/sys/class/power_supply/BAT0/charge_full"
    movl    $0x72616863, 29(%rdi) # "char"
    movb    $'e, 34(%rdi)
    jmp     get_number

# prepend `%eax / 1000000` with one decimal place to the output string; invalidates %eax,
# %edx, %r8d, and %r9d
add_eax_to_output_string_as_decimal:
    xor     %edx, %edx
    mov     $1000000, %r9d # 4-byte divisor
    div     %r9d           # div stores the quotient in %eax
    mov     %eax, %r8d     # copy the quotient to %r8d

    # compute one decimal place
    mov     %edx, %eax    # the remainder is the new dividend
    xor     %edx, %edx
    mov     $100000, %r9d # 4-byte divisor
    div     %r9d          # div stores the quotient in %eax

    # convert %eax to text (just one character)
    mov     $10, %r9b # 1-byte divisor
    div     %r9b      # quotient and remainder are stored in %al and %ah, respectively
    add     $'0, %ah  # convert the remainder to ASCII
    dec     %r10
    mov     %ah, %al
    movb    %al, (%r10)

    dec     %r10
    movb    $'., (%r10)
    mov     %r8d, %eax
    call    add_eax_to_output_string
    ret

# prepend %eax to the output string; invalidates %eax, %edx, and %r9d
add_eax_to_output_string:
    mov     $10, %r9d # 4-byte divisor
more_digits:
    xor     %edx, %edx
    div     %r9d     # quotient and remainder are stored in %eax and %edx, respectively
    add     $'0, %dl # convert the remainder to ASCII
    dec     %r10
    mov     %dl, (%r10)
    test    %eax, %eax
    jne     more_digits
    ret

_start:
    mov     $0x40002d, %r10d
    mov     $0x20685720, %r12d # " Wh "

    # read the contents of the file specified by the path at $path into %r14
    mov     $0x400192, %edi
    call    get_number
    mov     $0x400192, %edi

    # copy the result of get_number (the energy_full or charge_full value) and read the
    # energy_now or charge_now file (store the contents in %r14)
    mov     %r14d, %r15d

    # change the path to "/sys/class/power_supply/BAT0/energy_now" (or "charge_now")
    movl    $0x00776f6e, 36(%rdi) # "now\0"

    call    get_number

    # calculate the remaining energy as a percentage
    xor     %edx, %edx
    mov     %r14d, %eax
    imul    $100, %rax
    div     %r15
    call    add_eax_to_output_string

    # prepend "(" and then " Wh " (or " Ah ") to the output string
    movb    $'(, -1(%r10)
    sub     $5, %r10
    movl    %r12d, (%r10)

    # prepend the energy_full (or charge_full) value to the output string
    mov     %r15d, %eax
    call    add_eax_to_output_string_as_decimal

    # prepend "/ " and then " Wh " (or " Ah ") to the output string
    movw    $0x202f, -2(%r10)
    sub     $6, %r10
    movl    %r12d, (%r10)

    # prepend the energy_now (or charge_now) value to the output string
    mov     %r14d, %eax
    call    add_eax_to_output_string_as_decimal

    # write(1, %r10, $0x400030 - %r10)
    xor     %eax, %eax   # system call 1 is write
    inc     %eax
    mov     %eax, %edi # file handle 1 is stdout
    mov     %r10d, %esi # address of string to output
    mov     $0x400030, %edx
    sub     %r10d, %edx
    syscall

    # exit(0)
    mov     $60, %al   # system call 60 is exit
    xor     %dil, %dil # we want return code 0
    syscall            # invoke operating system to exit

.ascii "/sys/class/power_supply/BAT0/energy_full"
