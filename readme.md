A battery status program for x86-64 Linux laptops in the form of a 320-byte ELF
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
4AE/AQ4AAD+R1tX9PhIqqLiC7tM26Rkl412GOAZaMsLDphi1cs8l0AaEDYi5pbQ4OZtD5X+bx3S
iqJd2Ay7FQOvX0lDKEhiVlP3TwXvDYFVEnzyinGngV74ByN916Db6EAChik3UZ+HQFWtTrU11f6
fDlEhaVcHPeUobN9b6wKDmJw1JfNhClh5YRviGZusYyLYH+E5QKgot2JeCtoKGBjwtmW7j8pd7C
dZpAy0bMql8ZDKdrCOVWmBvh5KV4u/FY4zUqK4+O2y3mtlaaGd31zlioSTZRTPT9bgl678y+9yL
T0Vn87AfZIUADANivjSPQO8+FmaGHcJq2OSjyqAbb+QF7qU8EPcc9gXyzfyBTv/EFZu4UwA=
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
