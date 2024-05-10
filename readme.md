A battery status program for x86-64 Linux laptops in the form of a 393-byte ELF
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
4AGIAUcAAD+R1tX9PhIql6sjsG/MaokIKBWGZx/84juTwnC0aETAkh4I2GwP7B2ScZ1gcta+TcpQ/G5azu7Pz/uhPo
S7fh1vztQY2xpH05tRlti4UDwBUccRedex4zmxwgW3V7k5RwCf+lCEfh4h23izctwowdv2Z5cMODWMRccJbrL9YnY3
dfDawnHE+a2T/8Sy3vNY6W5Bpql9TSTEVLlWC5Ue51qX17lmXJFIxPKrtLe8mOLBBOqYDLpHbqI1cap7sIDFOBZlS0
rY08U0vC1FH0+r4ze7v3vypxNadKci5/sffC0bQOXyxNKDoZbYvzkVS4P/1+OeXLpK5UMYJXhkFU0Vk1ZpxNwiZD0W
HMte9ZJd9yUE2+EnpREd2s/cdbUROKlrYgF9frcXvAAr8cMlkB4dJuHf3mm/SKxe+Mt7I8kwy7sFtDq/1p9KggA=
EOF
```

## Limitations

*   Anything that's not x86-64 and Linux is definitely not supported.
*   I don't know how standard/portable the `/sys/class/power_supply/BAT0` path used
    actually is.
*   If neither an `energy_full` nor a `charge_full` file exists in
    `/sys/class/power_supply/BAT0`, an infinite loop results.
*   Some laptops (for example the ThinkPad T480) have two batteries; this isn't supported
    by `btry`.

## Build instructions

### Linux on x86-64

    make

### Other platforms

No.

## Notes

When my ThinkPad X220 is plugged in at the time I wake it from suspend mode, I get the
`charge_now` file.  When it is not plugged in I get the `energy_now` file.  At least I
think that's how it works.
