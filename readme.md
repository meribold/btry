A battery status program for x86-64 Linux laptops in the form of a 369-byte ELF
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
4AFwATQAAD+R1tX9PhIql6sjxkjsaokIKBWGZx/84juTwnC0Z1zPT1NrX7p18E3d+SYZAoDxhoI6EZaJVYtZP
l3Q5fJpp2zmTZv5jqVSSbG4r9Uu0PBaDvA834cD8YdYbjevPfqJMUNivToN2fdakYyWox1HTtkZznaF7DDUPd
tN39d+16K8PsH5nou4IwxY+JmvD7lT+G4GG4ZcHroE5zDHRc4mgXlsJyl62JbiSEmgHho7RBXEEjE1QajclGs
90QwoJzxX/Itv2BUVQ390EjLK0frO4a6P3bPJVkWeT7lRacVlqNcA2qPUumv4UqSZU6MyM+NbKTcY5RjFU1G1
9B/ko7bf7Idulfni7fpSIX3G9nAIgmXajkh/sp6dA66Or74+jD86Ri4047ZOmJ2AGRheqCQlFogu7/tsAA==
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
