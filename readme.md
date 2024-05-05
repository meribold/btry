A battery status program for x86-64 Linux laptops in the form of a 450-byte ELF
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
4AHBAVwAAD+R1tX9PhIqx7s6AgikVMJLVYkLWFsiS+t/qTGVCzqgdyaGYLHoE7DYxwwsIbxdVPp/rpvN
rk3iPeYSlNTy2yaFetm7gzC2l1mEFMK2mdc3H6kOtjM5+AxWDIiS7pJLFPdppGVla2uknKRFIgP1YQ9s
ZkEw2FVcqzHng5816SNDPV0QHM9RwV7QCrWE4kZWpD2+7euiKKOrEPdfQmRIzswojx1bA62O80DGTFRg
ycnL+GlZ+RsmP2M71+AYbnh8OBztY8cC+plMxo5CB/VHVyYvAbJ35Yo4D1t7y3ujfVVw/BgJ+yWZ81TN
GSc7MC9F0osmxpQl/zRLrEw0d4UVTgcge9QyKORCX3oFHGEbzR/CO5tyy5gDbtV3BxJzQZFz63zw5+Vh
CwJyFFJoPToDSTw36Z4W3Wxxb+dpMcj+vIOl7bGfwtLJ0WC6Vf5nGnqcIblptLmqtJJ0WtmjAAA=
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
