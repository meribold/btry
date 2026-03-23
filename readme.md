A battery status program for x86-64 Linux laptops in the form of a 371-byte ELF
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
4AFyATQAAD+R1tX9PhIql6sjxkjsaokIKBWGZx/84juTwnC0Z1zPT1NrX7p18E3d+SYZAoDxhoI6EZaJVYtZP
l3Q8cEFp2zmTZv5jqVSSbG4r9Uu0PBaDvA834cD8YdYbxJwbcx4CWGNvO36kUSJlocuOyQaR0Ny2ePHwd6OHt
pG55p3dW4pELVHmcrCPCc++cW4J5ScrKGdcmOpzVSExa0F7v6C1i9mKHUUjNPC81GvxoI64Odva2HFAeeaWUL
6RUUg1xKB0O+y4ce76grgsKxxHkb4gGxhu0dieo+wUt7fStwNWDViYsjmHADgyJ+Au4143N4VHVUzGcgeBavp
yHL/9WMlUtQ392hflPwlDKJ8g4AlhzJfQLwIuZlrlzlf/bahz2buBAHnnN8fdSu0H+CCsIFparJv9enAAA==
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
