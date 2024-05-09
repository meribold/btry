A battery status program for x86-64 Linux laptops in the form of a 424-byte ELF
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
4AGnAVQAAD+R1tX9PhIqx7s6AgikVMGE8lf5Lf5g4xQNh34bUxl6Ngns1gbr73fOzFZPPsBsyVIqRV
aC3sy9PQqn3pqq2FlQnhOvXVh7Zh/t4DWYP8mLacIdIMr6q4+wbGFAnmp5IgbRtuD9ctEoBttr17Iv
9a8OU5rEqhqs9inqeq5HPVA52Nc8kPK6OzyfJzhfznLlEedCy4v39PxYUA8dWNvIN+0hZRPbsPvj4P
FpMd3ehOb+sp+svzwlVfpuuq4hy4ILjm2G6UKFM+GzBbS4BEle/zgHgYzRyMtfT/ks0GdYMdvwfWEs
qfmmQM2ls2BLz6WZ1Wj+ZvUfJ75CBJJrf1t0DffVAMlvpQdG+hewbFPSOvW69+PsECMQAKD4fhdyNu
Wa6xBOygeIIdtI9vIotnM9DE+qZpc5ws6M+S9hZOWV/W5D7VqcfSt3i3IWAFNVwjxmPONyFQAA
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
