A battery status program for x86-64 Linux laptops in the form of a 423-byte ELF
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
4AGmAVMAAD+R1tX9PhIqx7s6AgikVMFnoef5Lf5g4xQNh34bUxl6Ngns1gbr73fOzFZPPsBmJtIpQv
ZkTQ4UZtI4paBdH2h4WhvLZ8vzvAsduEzoXtssJjlAz/bVav0mARtakRhkLLgDj4zoqzwvKjXPQ6/s
k1X396HH6Le040n9VQ9YdOYvwh4mR9GiVZ6dTTIW2Llrogh+yyCcSlgfk2CZBGLZKRA27wJRqF6c/O
8FRkrP8HbenylAX3Fx9+4TKgjYHHsglv164UDiZq3gG6IObErtS9mbVZx35MlHrCiWALBnbXW6UBzE
ZDb+U+yQk1w6j5ceDn/8aEkSzEmAJYxTtVoyoMvJhL4PywZJb0MYR/wyLBkZntBVsKwJXpXLLA1Qhf
AEFIfiry/ECFrm2KDNOwqrMHVtznyn+JcWvXRvAyoKts5hQvG+P2rDSK5tc0SUNsItMk1SXgA=
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
