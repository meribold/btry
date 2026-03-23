A battery status program for x86-64 Linux laptops in the form of a 335-byte ELF
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
4AFOARwAAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi1cs8l0AaEDYi5pbQ4OZtD5X+bx3SiqJd
2Ay7FQOvYQ2ZhOm4eCuLcHsfeY4//ARCGcG3GJ5TqbHkEPxg28PG7uy0SWVrenfbfcyQgJsevfDJrkw
KT+nReYNV7SI5il3ey4OzmR6zb2iCLv6oj7ctX+aH3GfkYFSmnFdTfNYUqAqXC0xbI9MS+WVZk6NTe/
rAYqDcYE1v6+xeukvHjrfNBUcQ4VqDqyZhZNKYxr3dJkccwnCaBZNCeKZqUDnstsSy4jEJQrSZ8IISn
TMyvxFtkuRU9pi5DXu4Ujd1u0ijdSttyZAcu/ikNZNOaOYL5EmT5m1evAHsCps1AvpnGdv0AAA==
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
