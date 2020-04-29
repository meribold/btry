.global _start

get_number:
    # open("/sys/class/power_supply/BAT0/energy_now", O_RDONLY)
    mov     $2, %rax           # system call 2 is open
    mov     $0, %rsi           # 0 means read-only
    syscall

    # read(fd, buffer, 8)
    mov     %rax, %rdi  # open returns a file descriptor in %rax; read expects it in %rdi
    xor     %rax, %rax  # system call 0 is read
    sub     $9, %rsp    # "allocate" 9 bytes of stack space
    mov     %rsp, %rsi  # save file contents read from fd on the stack
    mov     $9, %rdx    # read up to 9 bytes
    syscall             # the number of bytes read go into %rax

    # convert file contents to an integer (stored in %r8)
    sub     $1, %rax    # subtract 1 so we don't process the newline
    xor     %r8, %r8
    xor     %rcx, %rcx
    xor     %rdx, %rdx
next_char:
    imul    $10, %r8
    mov     (%rsp, %rcx), %dl  # load one character/byte/digit
    sub     $48, %dl           # convert the character from ASCII
    add     %rdx, %r8          # add this digit
    inc     %rcx
    cmp     %rcx, %rax
    jne     next_char

    # convert from microwatt to watt hours
    xor     %edx, %edx
    mov     %r8, %rax       # dividend
    mov     $1000000, %r9d  # 4-byte divisor
    div     %r9d            # div stores the quotient in %eax
    mov     %rax, %r8       # store the quotient in %r8

    # compute one decimal place
    mov     %edx, %eax     # the remainder is the new dividend
    xor     %edx, %edx
    mov     $100000, %r9d  # 4-byte divisor
    div     %r9d           # div stores the quotient in %eax

    # return
    add     $9, %rsp
    ret

push_number:
    # put the return address into %r15
    pop     %r15

    # convert %ax to text (just one character)
    mov     $10, %r9b    # 1-byte divisor
    div     %r9b         # quotient and remainder are stored in %al and %ah, respectively
    add     $48, %ah     # convert the remainder to ASCII
    dec     %rsp
    mov     %ah, (%rsp)  # put the character on the stack

    # put the string "." on the stack
    dec     %rsp
    movb    $46, (%rsp)

    # convert %r8 to text
    mov     %r8, %rax
    mov     $10, %r9d  # 4-byte divisor
more:
    xor     %edx, %edx
    div     %r9d        # quotient and remainder are stored in %eax and %edx, respectively
    add     $48, %dl    # convert the remainder to ASCII
    dec     %rsp
    mov     %dl, (%rsp)
    inc     %r10         # we record the number of character in %r10
    cmp     $0, %eax
    jne     more

    # return
    jmp *%r15

_start:
    # put the string " Wh\n" on the stack
    sub     $4, %rsp
    movl    $174610208, (%rsp)

    # process the file specified by the path at $energy_full
    mov     $energy_full, %rdi
    call    get_number
    call    push_number

    # put the string "h / " on the stack
    sub     $4, %rsp
    movl    $539959400, (%rsp)
    # put the string " W" on the stack
    sub     $2, %rsp
    movw    $22304, (%rsp)

    # process the file specified by the path at $energy_now
    mov     $energy_now, %rdi
    call    get_number
    call    push_number

    # write(1, energy, %r8 + 4)
    mov     $1, %rax      # system call 1 is write
    mov     $1, %rdi      # file handle 1 is stdout
    mov     %rsp, %rsi    # address of string to output
    # number of bytes: %r10 plus 14 for " Wh / ", " Wh\n", two times "." etc.
    lea     14(%r10), %rdx
    syscall

    # exit(0)
    mov     $60, %rax   # system call 60 is exit
    xor     %rdi, %rdi  # we want return code 0
    syscall             # invoke operating system to exit

energy_full: .ascii "/sys/class/power_supply/BAT0/energy_full\0"
energy_now: .ascii "/sys/class/power_supply/BAT0/energy_now"
