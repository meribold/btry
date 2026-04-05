p_vaddr = 0x10000

start:
.byte 0x7f
.ascii "ELF"
.byte 2, 1, 1, 0
    mov     $(p_vaddr + percent_suffix - start), %ebx
    jmp     plus28
.byte 0
.short 2, 0x3e
.long 1
.quad 0x10008, 0x38
plus28:
    mov     $10, %r13b
    mov     $0x20685720, %ebp # " Wh "
    jmp     plus68
.byte 0
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
    # read the contents of the file specified by the path at $path into %eax
    call    get_number

    # copy the result of get_number (the energy_full or charge_full value) and read the
    # energy_now or charge_now file (store the contents in %eax)
    push    %rax

    call    get_number
    pop     %rcx
    push    %rax

    # calculate the remaining energy as a percentage
    cdq
    imul    $100, %rax
    div     %rcx
    call    add_eax_to_output_string

    # prepend "(" and then " Wh " (or " Ah ") to the output string
    movb    $'(, -1(%rbx)
    sub     $5, %ebx
    movl    %ebp, (%rbx)

    # prepend the energy_full (or charge_full) value to the output string
    xchg    %ecx, %eax
    call    add_eax_to_output_string_as_decimal

    # prepend "/ " and then " Wh " (or " Ah ") to the output string
    movw    $0x202f, -2(%rbx)
    sub     $6, %ebx
    movl    %ebp, (%rbx)

    # prepend the energy_now (or charge_now) value to the output string
    pop     %rax
    call    add_eax_to_output_string_as_decimal

    # write(1, %rbx, $0x10036 - %rbx)
    mov     $1, %al    # system call 1 is write (we know that %eax is zero here)
    mov     %eax, %edi # file handle 1 is stdout
    mov     %ebx, %esi # address of string to output
    mov     $0x36, %dl
    sub     %bl, %dl
    jmp     plus50

# read the file specified via %rdi; convert the contents to an integer stored in %eax
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

    # convert file contents to an integer (stored in %eax)
    lea     -1(%rax), %ecx # subtract 1 so we don't process the newline
    xor     %edi, %edi
next_char:
    imul    $10, %edi
    lodsb              # load one character/byte/digit into %al and increment %rsi
    sub     $'0, %al   # convert the character from ASCII
    add     %eax, %edi # add this digit
    loop    next_char  # loop until %rcx is zero
    xchg    %edi, %eax
    ret
charge:
    mov     $0x4120, %bp # " A"

    # change the path to "/sys/class/power_supply/BAT0/charge_full"
    movl    $0x72616863, 29(%rdi) # "char"
    movb    $'e, 34(%rdi)
    jmp     get_number

# prepend `%eax / 1000000` with one decimal place to the output string; invalidates %eax,
# %edx, and %esi
add_eax_to_output_string_as_decimal:
    # divide by one million in two steps
    cdq                   # clear %edx since the dividend is %edx:%eax
    mov     $100000, %esi # one hundred thousand
    div     %esi          # %eax / 100000 (4-byte divisor)
    cdq                   # clear %edx again for a second division
    div     %r13d         # %eax / 10 (4-byte divisor)

    # we have Wh (or Ah) in %eax (quotient) and the tenths digit in %edx (remainder)
    sub     $2, %ebx
    movw    $0x302e, (%rbx) # ".0"
    add     %dl, 1(%rbx)    # add the tenths digit (%dl) to 0x30 ($'0)

# prepend %eax to the output string; invalidates %eax and %edx
add_eax_to_output_string:
    cdq
    div     %r13d    # quotient and remainder are stored in %eax and %edx, respectively
    add     $'0, %dl # convert the remainder to ASCII
    dec     %ebx
    mov     %dl, (%rbx)
    test    %eax, %eax
    jne     add_eax_to_output_string
    ret

path: .ascii "/sys/class/power_supply/BAT0/energy_full"
end:
