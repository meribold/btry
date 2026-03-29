A battery status program for x86-64 Linux laptops in the form of a 323-byte ELF
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
4AFCAQwAAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi1cs8l0AaEDYi5pbQ4OZtD5X+bx3
SiqJd2Ay7FQOvX6bMXQizytQZKnGUfq976P5Et40R5tPw+am9xZTDtd/5iGodqK+XogOs06Zd4
mRnkOjzetIxfm/t8PusP/W0W7qdQfjmsJp01et83zL1NsDWZwaqXVgB/mizP3rDS/Yfw3sv1WS
Scke1AeMGQoQEnR7E8nDUGet9HQCLKNICtrVQ2m921mURGttfT6H+wttPkKUJRNgGQSMIVmAnH
RLFAgAmsaG/M/dbt84QXLFNCbBnFZfGukumWuKfoIsSEHIip7jL2FuBEUlC49Vr8NcnLlAAA
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
