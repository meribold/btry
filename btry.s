p_vaddr = 0x10000

start:
.byte 0x7f
.ascii "ELF"
.byte 2, 1, 1, 0
    mov     $(p_vaddr + percent_suffix - start), %r10d
    jmp     plus28
.short 2, 0x3e
.long 1
.quad 0x10008, 0x38
plus28:
    mov     $10, %r13b
    mov     $0x20685720, %r12d # " Wh "
    jmp     plus68
percent_suffix: .ascii "%)\n"
.short 0x38

.long 1, 7
.quad 0, p_vaddr
plus50:
    syscall
    mov     $60, %al   # system call 60 is exit
    xor     %edi, %edi # we want return code 0
    syscall            # invoke operating system to exit
.quad end - start, 0x200

plus68:
    # read the contents of the file specified by the path at $path into %r14
    call    get_number

    # copy the result of get_number (the energy_full or charge_full value) and read the
    # energy_now or charge_now file (store the contents in %r14)
    mov     %r14d, %r15d

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
    xchg    %r15d, %eax
    call    add_eax_to_output_string_as_decimal

    # prepend "/ " and then " Wh " (or " Ah ") to the output string
    movw    $0x202f, -2(%r10)
    sub     $6, %r10
    movl    %r12d, (%r10)

    # prepend the energy_now (or charge_now) value to the output string
    xchg    %r14d, %eax
    call    add_eax_to_output_string_as_decimal

    # write(1, %r10, $0x10036 - %r10)
    push    $1          # system call 1 is write
    pop     %rax
    mov     %eax, %edi  # file handle 1 is stdout
    mov     %r10d, %esi # address of string to output
    mov     $0x10036, %edx
    sub     %r10d, %edx
    jmp     plus50

# read the file specified via %rdi; convert the contents to an integer stored in %r14
get_number:
    # e.g. open("/sys/class/power_supply/BAT0/energy_now", O_RDONLY)
    mov     $(p_vaddr + path - start), %edi
    push    $2
    pop     %rax       # system call 2 is open
    xor     %esi, %esi # 0 means read-only
    syscall

    # sometimes there are no energy_* files but charge_* files instead
    test    %eax, %eax
    js      charge

    # change the path to "/sys/class/power_supply/BAT0/energy_now" (or "charge_now")
    movl    $0x00776f6e, 36(%rdi) # "now\0"

    # read(fd, buffer, 9)
    xchg    %eax, %edi # open returns a file descriptor in %rax; read expects it in %rdi
    xchg    %esi, %eax # system call 0 is read
    lea     -9(%rsp), %rsi # save file contents read from fd on the stack
    push    $9
    pop     %rdx       # read up to 9 bytes
    syscall            # the number of bytes read goes into %rax

    # convert file contents to an integer (stored in %r14)
    lea     -1(%rax), %ecx # subtract 1 so we don't process the newline
    xor     %r14d, %r14d
next_char:
    imul    $10, %r14
    lodsb              # load one character/byte/digit into %al and increment %rsi
    sub     $'0, %al   # convert the character from ASCII
    add     %rax, %r14 # add this digit
    loop    next_char  # loop until %rcx is zero
    ret
charge:
    mov     $0x4120, %r12w # " A"

    # change the path to "/sys/class/power_supply/BAT0/charge_full"
    movl    $0x72616863, 29(%rdi) # "char"
    movb    $'e, 34(%rdi)
    jmp     get_number

# prepend `%eax / 1000000` with one decimal place to the output string; invalidates %eax,
# %edx, and %r9d
add_eax_to_output_string_as_decimal:
    xor     %edx, %edx
    mov     $1000000, %r9d # 4-byte divisor
    div     %r9d           # div stores the quotient in %eax
    push    %rax           # save the quotient

    # compute one decimal place
    imul    $10, %edx, %eax # make the remainder multiplied by 10 the new dividend
    xor     %edx, %edx
    div     %r9d # divide by one million again

    add     $'0, %al # convert the quotient to ASCII
    dec     %r10
    movb    %al, (%r10)

    dec     %r10
    movb    $'., (%r10)
    pop     %rax

# prepend %eax to the output string; invalidates %eax and %edx
add_eax_to_output_string:
    xor     %edx, %edx
    div     %r13d    # quotient and remainder are stored in %eax and %edx, respectively
    add     $'0, %dl # convert the remainder to ASCII
    dec     %r10
    mov     %dl, (%r10)
    test    %eax, %eax
    jne     add_eax_to_output_string
    ret

path: .ascii "/sys/class/power_supply/BAT0/energy_full"
end:
