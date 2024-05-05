A battery status program for x86-64 Linux laptops in the form of a 457-byte ELF
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
4AHIAWEAAD+R1tX9PhIqx7s6AgikVMC0JxO/4Krtv7t118zuQqBXR/ixVaN4HTUj7Mgo5U7hgMdBDdQJ1
zsR58weGsS4Z54FN9uzsJyhQhSouehSRbYb49NNi0rcs9y8fBfPmhbP57dDoy80NFVtXxY5KpG4GBdtBX
8uYzQzOmF1quGlrjSNTJq3eNAgNl9hwxHzgHGs99bXWmIc71fQZRuOtKRokp8k8C6uOK7oDbQjY/iG5Et
Jhd3waSglAsic1AKqyTw1fIzq9sbx22gbNAP2Jy/L7LmQqRgy0A0WSyVH9+TMDnpzxji57uK/znJTAe1G
AMDbc0OXyE2SkLUxyvj5FljkE8VAu0HmtTjs7bXrfCLLUemAd+TeXZA/hQV4oUF1JwFY2G8cX7Gw1N0hh
FgbyEPzJmW4tdVXRuexPb09ns7kZFarOk0NM7FF+aUJx624a/3xmoIc3aowEEmpG2ZmarIIBdypAA==
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
