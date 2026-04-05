A battery status program for x86-64 Linux laptops in the form of a 316-byte ELF
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
4AE7AQ4AAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi6dTMOPSJIV5ULmIGxbZk8wnNmmkf
MLP9IF5oZuMt48IV4lnnkTcCGazpyntaqpReKp1C0XTuKwxXn2n70PohkTRfhRcpVIK2Haohg+s
kiLS0n4Tu+qEzTvVUxp4NDLYyGlJsFghrASmfrTLlLSfY3onk+mbGniIR06N3SkoK7r3u51byWY
+auX/0MBG28bJ/zS1dLaPXmgA1pA3/IXsX8pDpkpsFDW5Xka8azZ8SbGKq3RCsciSyqcZcRu23W
rIzzA5ZNG+R/EUzMosJbEpfEGcCy6XsHW98jUHKhFpfhldSAIpGGxcTsvkdk+B6p2/TkagA=
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
