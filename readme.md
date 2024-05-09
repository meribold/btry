A battery status program for x86-64 Linux laptops in the form of a 411-byte ELF
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
4AGaAUEAAD+R1tX9PhIqx7s6AgikVMrbQkbZTlgTkXCoSG2PkWiW2MecM/ZJkKSrx3vAzFqwmlauSGGoPu1dti/q
V7mAT/IvwFO2uGOaec8I1Je9/aYt5X3GLdS8JBdjRs39wEyBj33QmxIsbvPej5sIy+u66Vff80pVZgSN2uT2Okqu
N6dNh21S65z3+Faq8Nt4DAeSj3OiJGQigzXgMFOv03+aWvNP3shi8C1AWikCvHywXQhi5gFKbEMCY1RmnW5+C1JE
L6ZDGaBnQ8WALVFGGHpYDDnydycWOMGZlOOkbMyPvWMZxpltT+6vEpTkGU6PVV9uJYtMa6MQTWMxa1X5UgwD0HoN
MVUu5WTXTXD5DE2d1YuDynfiQYIydxiTOt3BdniXE1KH1OFZ1F9ewNY80COFP5iozNjNe7djK04wXE8r1IykPAA=
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
