A battery status program for x86-64 Linux laptops in the form of a 442-byte ELF
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
4AG5AVgAAD+R1tX9PhIqx7s6AgikVMIvuIkLWFsiS+t/qTGVCzqgdyaGYLHoEgq8xqDeV3KfMBGqoNF
wcDczzYLm+7dDhYsqcCI1IQuOc/4TF1GPMI9ohUqm3APqjzMe5TwLu0d1ynen9NhhR5WsmETLjmJy0K
uvf4k3Ev1zkt7cq0lggfFlMuS8kJZXN73Bnon54gqvM8wf2+jUCMNbBkuOFMYYuHUaNJKZb+xtHLywc
8aqD06AvUz9fBvUmjkgBUZ575svaNR5NAgkgOCQd2lueZgw8oUpN7nmneOerDALNoXdjBpD2fyiyZ9a
NzWiGRRWvQeEKuYr+h36O/R4OMw9mK9pNLjdMNG23DTGN+MWnkH3/LUrEyTX218Ftx/DONtpSQY1lY5
yrI4O4BXXVH6cvB88H7fk2LkXJsAtTT02RXXmatfKQuvW9E0z39KQYBmLIkVSKeKy9e216uCUAA==
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
