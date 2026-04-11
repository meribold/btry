A battery status program for x86-64 Linux laptops in the form of a 307-byte ELF
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
base64 -d <<< 'AAAAgAD//////////wA/kdbV/T4SKqi4gu7TNukZJeNdhjgGWjLCw6YYwm3tgKjiZLis8j
hz7+A+BEXQGjYrdisdU/fmh6I+bXFgKXsBP1Qihg6wueK0wKD1tL2vQRd8ZjmQi20OduGmiMyPyfsS2cSUUCK
SpQXtdHbQMRMn1UD6k/HrwFt3i+wzPNoG0tEHEZbJUTvdAVs0xS9PYrTTc4uSskePYWAK8t6VK/pmpItKsGnb
/qyGaIMl2/5TiqjHXTczFv3YkiNnJ7iqK8CtWhMwMlQxeyRuW3fpYgRKVPNKrX14kKobJSHZy4MuC9TE7lgYX
YJhBim5yRoO7wnYG3ezKX86Xvw/AFHGG8CTnD49szn/eHZAAA==' | unlzma > btry && chmod +x btry
```

## Limitations

* Anything that's not x86-64 and Linux is definitely not supported.
* I don't know how standard/portable the `/sys/class/power_supply/BAT0` path used actually
  is.
* If neither an `energy_full` nor a `charge_full` file exists in
  `/sys/class/power_supply/BAT0`, an infinite loop results.
* Extra batteries (like in the ThinkPad T480) are ignored.

## Build instructions

### Linux on x86-64

    make

### Other platforms

No.

## Notes

When my ThinkPad X220 is plugged in at the time I wake it from suspend mode, I get the
`charge_now` file.  When it is not plugged in I get the `energy_now` file.  At least I
think that's how it works.
