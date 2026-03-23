A battery status program for x86-64 Linux laptops in the form of a 332-byte ELF
executable.

## Usage

    $ btry
    30.6 Wh / 31.1 Wh (98%)

Sometimes there are no `energy_now` and `energy_full` files, but `charge_*` files instead
(at least on my ThinkPad X220).  If this is the case, `btry` prints ampere hours instead
of watt hours.

    $ btry
    2.2 Ah / 2.8 Ah (78%)

## Installation

```
base64 -d <<EOF | unxz -Fraw --lzma2=dict=4K > btry && chmod +x btry
4AFLARkAAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi1cs8l0AaEDYi5pbQ4OZtD5X+bx3SiqJ
d2Ay7FQOvYLZ+PpMU3+zJj1FYr2HF99Lg44plaIaKzx+oH8mL+qGqN0RF8j4eGOO1BD19thc4HHb90
5wB+K9qO+he8i3aoIWAeH9AOi2mqJinQHvwUn5qDEGcPgKdjY+bvoJk1UVx8bCPEOm2TVMM4MgBrbQ
xnCbQRYt/4YB/VzvYj7lCdo3ti7u6e/Cmv4DBj3W2vH6rbwEGF8M/KMOE0o2FUKdPHh2YD3M7n3dtd
1aSFqUdUIdqAKNDKQVlMzvU7BN8DMRu7NUhW+HRAjQCCurL3hjkg/rZguratxR0Ofl5ucyNnAA==
EOF
```

## Limitations

*   Anything that's not x86-64 and Linux is definitely not supported.
*   I don't know how standard/portable the `/sys/class/power_supply/BAT0` path used
    actually is.
*   If neither an `energy_full` nor a `charge_full` file exists in
    `/sys/class/power_supply/BAT0`, an infinite loop results.
*   Extra batteries (like in the ThinkPad T480) are ignored.

## Build instructions

### Linux on x86-64

    make

### Other platforms

No.

## Notes

When my ThinkPad X220 is plugged in at the time I wake it from suspend mode, I get the
`charge_now` file.  When it is not plugged in I get the `energy_now` file.  At least I
think that's how it works.
