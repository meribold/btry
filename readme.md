A battery status program for x86-64 Linux laptops in the form of a 384-byte ELF
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
4AF/AUIAAD+R1tX9PhIql6sjxkjsaokIKBWGZx/84juTwnC0Z1zPT1NrX7p18E3d+SYZAoDxhoI6EZaJVYtZPl3R
Q0GmvBz3Jpv7zJ0Mejc8xhxNzv48cldvmf1G7JlbiLQqwNU38t9FmUN0yd7iBvOy1V9kLQfYAQnRBknAjvvoYTTG
30UkkfizhtW6tCsfsG3fEsm3MvG41qzqCrQjm8NMwkiQyGpf/o3Uzf4jIctfUBEL19LAmr9t0cVJTrUCVYy0GW9c
vPd/2izGOtFw/14myD8lseTo0EpXtChauuNLZwgWlTynXkSAK7mP5HXtIyTA7QEWZ7glaptCYfF5ZE38eR+BYZ4B
bMHK3oYqcY0rsWWjSVvpMZpghUEnzQw6cSYuHN5nj0BpdKR/zHyp942jAts/FTHT6GDTu5o15fn8PQP76YOG9UQA
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
