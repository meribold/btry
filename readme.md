A battery status program for x86-64 Linux laptops in the form of a 434-byte ELF
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
4AGxAVQAAD+R1tX9PhIqx7s6AgikVMH4fokLWFsiS+t/qTGVCzqgdyaGYLHoEGSkxewyQb4HffZ3ax
iF5Vf2KwapTm9PsbpY7aqEIukNlK/3fBC+i7kd3ngdwGfUIZ9OajpM0jeJd14qVQaRG8ODph4FuxpU
DLUoPuFrNw856wXT5HIQch7LRiqOetdlNNFTgMyl2YY2GaP3nNZrV0YOvrZsju7KiOsAgTUJ5QwdFZ
HUQOwXD0cjGw9qhBZoBxbJ41lt8eERq62ImzECmAX56CsDq+Ij5k/xWrinpa3nFCPPsYKHDG4/kXgc
PTufP9ahY76fbEdENfO3fmxcAvwSTgjanm9upxxzt/Czz8eeCzUmAs4qIIBBGiirXPX0z6x3slCgFH
FU6F9A8o/tGgqe0POdubjwIOjlo+2L8bqmbxUy4eEgn/abg6vs5qHbJgYWgB6PC8X9f4otvQkA
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
