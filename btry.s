.global _start

_start:
    # open("/sys/class/power_supply/BAT0/charge_now", O_RDONLY)
    mov     $2, %rax          # system call 2 is open
    mov     $charge_now, %rdi # address of path to open
    mov     $0, %rcx          # 0 means read-only
    syscall

    # exit(0)
    mov     $60, %rax   # system call 60 is exit
    xor     %rdi, %rdi  # we want return code 0
    syscall             # invoke operating system to exit

charge_now: .ascii "/sys/class/power_supply/BAT0/charge_now"
