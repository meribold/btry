A battery status program for x86-64 Linux laptops in the form of a 435-byte ELF
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
4AGyAVIAAD+R1tX9PhIqx7s6AgikVMFnoef5Lf5g4xQNh34bUxl6NgnsxP/zEWqEHBHY40LpmKyVni
b+Wqbhp4BmN7Mk7dzGGFLwAHmLNqsh5QUIf6N0+8/3WwDUk/D4RWJFlQPWN+m/eQ06QwARsMiCYh9s
5hFQ9MkeYmAWuD/3OK/aMlbwUMbiB4YVmVn/sy8bYAyDtX3MqqpOa22KGevr67lkzf7WZa5vW74RNL
HQnNl7QWc568h0t8X5q0ok4sTeAsnUK7jHbXTx8qQ/AiNblduAEiLEnLd8U81mm+/ZMe86QebXsu9x
bM5bDoVwjeybdywJal2EmnqY2XyAkg6mVAOtM2MQx8C27K3U9FHYNownzf1cVg+FILq6y7Hcu1lqt+
PVuU5RP6RFuFdiR7l667MLve737xBKcD0FuQbf7EeX7VzyD5/iNXGxA0QxwhVYUzovjAbwAA==
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
