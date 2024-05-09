A battery status program for x86-64 Linux laptops in the form of a 415-byte ELF
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
4AGeAUQAAD+R1tX9PhIqx7s6AgikVMrbQkbZTlgTkXCoSG2PkWiW2MecNBhuEKSrx3tAC2+YtQFoqefK5cZqYWIl2
FkwD5F5eG4Rm9QxAdShSyfhFGJUnG7V91UQ4iNM/fWvjfiGy51uWyKEBj5LaISHtwopZSP5jPrFxd8b3udSo/QVG8
FQwC8VJArZ07Ljz7QVepYO53kgz4EcuNBnKJYiNPBMvlAA1FNAEYAd13FS9SovPM1pWOVBjIY/nnjcBr2U0hYYZCp
AD3CKjk38WF0egAExj3M2a6J557CPjQy9pOCra348Syuk8AsrsJVZYxUsOeWEiOAoQtqCmCnYNs+DXJZDLASt57Nn
TY9OYJzdilYAfJBsB8ZSwtAVlhwKZNy9Zo9vLzXtsbp0R5Zbunw5p4tvbYdgs++yYgCDesyiUqKq+wdyBad3sQA=
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
