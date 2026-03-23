A battery status program for x86-64 Linux laptops in the form of a 355-byte ELF
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
4AFiAScAAD+R1tX9PhIql6sjxkjsaokIKBWGZx/84juTwnC0Z1zPT1NrX7p18E3d+SYZAoDxhoI6EZaJV
YtZPl3QkBmSGVlsZeWWD3WpiGJOyTKFabJ7A3kP10w38u0xXhe93JIVy/Fb7N5DHWD8LfvOXEsPmBxuLP
RSPyZh90sEg85zJ7SCtqkx5szTnZNdE/cyioP6kCXJpUFtMowzu78hJXsvraXFF8+D7bmYuvnk8uICY0W
cLPI8xaML7MUPVWLhElDBUan+UCxlB2RYRRG7o7rUJy/+Hp84v2izIurAvTSxNnyasM9kKKp+KyzOTxM+
ZXO+ZZsN0tfJ0MIR+/MZNyDz4YnAllCQhpRd50tuv6VrsJ1zAiiKSuLBtvNrPDjAJ0UM8vxTw1aMowAA
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
