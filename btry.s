.global _start

_start:
    # open("/sys/class/power_supply/BAT0/charge_now", O_RDONLY)
    mov     $2, %rax           # system call 2 is open
    mov     $charge_now, %rdi  # address of path to open
    mov     $0, %rcx           # 0 means read-only
    syscall

    # read(fd, buffer, 8)
    mov     %rax, %rdi  # open returns a file descriptor in %rax; read expects it in %rdi
    xor     %rax, %rax  # system call 0 is read
    sub     $8, %rsp    # "allocate" 8 bytes of stack space
    mov     %rsp, %rsi  # save file contents read from fd on the stack
    mov     $8, %rdx    # read up to 8 bytes
    syscall

    # write(1, charge, 8)
    mov     $1, %rax    # system call 1 is write
    mov     $1, %rdi    # file handle 1 is stdout
    mov     %rsp, %rsi  # address of string to output
    syscall             # skip `mov $8, %rdx` because %rdx is already 8

    # exit(0)
    mov     $60, %rax   # system call 60 is exit
    xor     %rdi, %rdi  # we want return code 0
    syscall             # invoke operating system to exit

charge_now: .ascii "/sys/class/power_supply/BAT0/charge_now"
