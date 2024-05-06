A battery status program for x86-64 Linux laptops in the form of a 427-byte ELF
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
4AGqAU8AAD+R1tX9PhIqx7s6AgikVMGE8lf5Lf5g4xQNh34bUxl6NgnsxP/zD9NfH/qFR/v0IlFgN
3Jh9U5mN+BuMH1atbt+k6ewlS8Tf4UAEMqqkGqAQT0jU7QsgWX2xxdjm1izdGkFEYgiUlywy180T7
cENUU+Ye8Z5C2GRMRy3UWe7Rc6u9shJp9NdcZY1/rBE8Kxwq5XBMtfTmfFJD9abxBnsEv3ffXzvfG
Uln048dTOyqBI54pmibn26KNsmCCGVQPzdXq19icQfuTmv0fOyofaGRlV2g6UtDAx67DttQpTKihs
tuYexfE8e1O8cqZfQ/zBgHkKsF4d5o4tQteX/bENgEVx6MVjuH492J49DYp1Mu6d7KcoVrOV4BqGS
TjW9UPaDEgoS/TvqHPyKQZUF4co554KKvqM2zcRhdBc93utLHV6zwJ/hwGkYqhA6FxXdBcwAA==
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
