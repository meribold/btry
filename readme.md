A battery status program for x86-64 Linux laptops in the form of a 420-byte ELF
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
4AGjAVIAAD+R1tX9PhIqx7s6AgikVMBU3wipQkmdDmlZAPK+MLAAZX1toNsRrNQUXEgDD+FI/VTCmx
WBADKfnagio7nYUCOV/qyU+7TVLcJQeW5ur44AXlcgnWi5+mXFxguaIhC74Lk1N1rQhvpgIHTUINls
DV1noE3bIfuUloX1blg8s+hbxloup5ckJyPjS5+zy0LAJoHFSwdGvWYmc263mFZPxwCsGY0097nS+p
RdTOiuvErCk8NTF1suuVvULXGWoawHjrQLYyPIEM2Zx1SOuaER6XsibHoz2BP2lxxU6m0TA9wZGaLn
zisOzVCly5NFRK06u8oSfBHwxGocmZ2GY7Ed3M6gRPeB8s2NQpy/A1nutd0/NOjfaci0LQd9IwM+Dz
/6LOho+WjBBW/B1N58IZVGyzF6RnBI/PGyh/cfr7WyeIv2Sglh7EJQdr7nYcnzHIs9Qu8AAA==
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
