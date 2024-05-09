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
4AGjAU4AAD+R1tX9PhIqx7s6AgikVMBU3wipQkmdDmlZAPK+MLAAZX1toNsRrNQUXEgDD+FDULpK
kyTNqD5vUkFrv1kwMv5HdG9+OMhLqtc3Nd576XUVVnpJ0nKxElRCYl0eDjiuYdkibfw73hMY7n7e
18HMrPkR/6KkxJPE1neNvR4O4rxDo2Td/RtzDWhvFmEQSuBE1gPJvGA18NCG3Ws7wYa7VtAPbMZ4
cLT5ADEKizEn+MCsfUtyVZVkiOX22u2piqk7Y/+g9ByEJUjEGmalFnBBqO1ftRuzuRm6HWL0z8Zs
yXbfcy5oM1oMPTs50VxZdn7SJ8QCjvjQZBFqWQ6eL/7iS2rQsDqu3+eGDBnaI4ZeICUNGgGyAJOP
2PuncqR6L2IFrY2WlvCWh+oORZpVuq2FttQUIe1reQTZ+LqKjrR2ruJj+UUWr55RfCLA3PefQAAA
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
