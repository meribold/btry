.global _start

_start:
    # exit(0)
    mov     $60, %rax   # system call 60 is exit
    xor     %rdi, %rdi  # we want return code 0
    syscall             # invoke operating system to exit
