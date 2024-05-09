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
4AGjAUsAAD+R1tX9PhIqx7s6AgikVMBoBbiL9hmCw+rwTKQ87EL5gmGEQrozKv0IF3Ai6bdWjVHD
YRfqi6N2TUugJRruApsHmrOhzIMdQvxxKVcRFqMH60qm5Tq0orhyEbcFrdAIJWU1GRXqiMaaW0U8
uhXk+qh0NFZYY5aejLrgg5RcY4u/8xv6hxYDyWi9Jv6MKrjeVTOaWGE/JBGMcBxQ7U+M1GkPCSN4
A2PR35W4C++iz4B5y4E6x0wP2Zpin9ORz7IGYSEFUhdjgRAsAsvncFVDamJKwRUCsJMFjrXUR4IG
KD4p5KhUXaKZ6yQ+A2zTxIgiVlcvc8F05ACtSUCIUN60zBv6Hd3nn4/7hMgF6AfM1sjZPHNaKvwb
eZxmmA++wKZuwxZfYetYkY9MvpDKhOv3g0Y0svCIOyba0VmphFl7dmLa9U9/VabFJo0/eFQA
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
