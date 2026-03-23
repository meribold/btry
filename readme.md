A battery status program for x86-64 Linux laptops in the form of a 338-byte ELF
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
4AFRAR0AAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi1cs8l0AaEDYi5pbQ4OZtD5X+bx3SiqJd
2Ay7FQOvYVs3AsxacqugeescD9yUGwfGiOJmR5rEvt7RuKSNUD14iqo5/xYrX+ZOLfpzLcUieoVBqgK
ptY1xg2pRxFzcBmEDzfd4ic9g9xwbFLmpK7QJQwkez+RcvoNTICgS8UdoVz1TwoXkn7hhGIvdGWx6vl
neSVmFKrIe4T7zdTMjWLGD/CC+btlLN8/TTqwuuoFka1TVL7qLwANW4tFlNnbIGDx4P/9gTPUriGMuA
cDahddfjd7uVj2JsgU+6aU3S0eWoM4J9UFPdeGDeIMSlSxnewsLNycvXcCFYBoB2mD4MVyuAbgA=
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
