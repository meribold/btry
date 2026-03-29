A battery status program for x86-64 Linux laptops in the form of a 328-byte ELF
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
4AFHARAAAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi1cs8l0AaEDYi5pbQ4OZtD5X+bx3Si
qJd2Ay7FQOvYEcTgbO03Zb+EG02HektnoYeQuNE2Re4rw0GI6AIOgsXU0Hi9ZN/KOpl4P3UC/Qd9
wbvjBWXJdNTpyC0C9bDBt0f7M3rrcjFWkL3WbIaxrsGBFm1CC/H/WlM5w+3qn3o3p9v9k5fGFoQt
TOrPH16xMWaZuvWCFox6sjiAs5Rlm8CvzuuMqm/FG1J3ECn2uM9Uab4z3zZGd2NLwCgf7PRzy8I/
g2OxN6HNyv0871638LWppaDmN2ZRN/jZdD5TRFr40ITT7W/+wjN3xNIC8cWWKHu5yfklAA==
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
