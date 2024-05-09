A battery status program for x86-64 Linux laptops in the form of a 417-byte ELF
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
4AGgAUYAAD+R1tX9PhIqx7s6AgikVMuOCq0wHcvBltMoA88vVX845B4BUb7RjwicfvoEpOWIVfDilySQev/YzgTQTr
rICLue8hLSZGKsdAlcd9sKWJ+sk64MdZEThZu0X/xKCTs/snSamnohh/0MOIu8/jlCugHy9VMosqc16EibkMC2ykC7
w8iX/HvZj8BkfC+i/2/FArVAykJfvaEPQDp9eG/iCMT23yU2U9+ESiURnTBU5rKzLDDBXMHZFn7fnpVcoERFLigQtI
HDtkL3I/LhkFdt3xLH3hJm9N4Uj5ZC9/mCMjH+WtMQ4wMdI5mTGK4J5xsTmqv7ITXR4MVA+6UWu8jfv+JOQn5EeJMO
2NBuie6OQvEEMiSQ+mpSDVZEk2aR6TMQJDBog9KA9aiNhupwa6O0k5KUvYm84RBUlQRtDF1iYSKSZEVkukA6AA==
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
