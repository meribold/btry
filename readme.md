A battery status program for x86-64 Linux laptops in the form of a 458-byte ELF
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
base64 -d <<EOF | unxz -Fraw --lzma2=dict=4K > btry
4AHJAWAAAD+R1tX9PhIqx7s6AgikVNieRinGww2EMS6e7tBgQB1qzJAkJcDqZNVT9rhKZ0cKZkytNeiU
Un8N0PZsva9qktkytDnza5yzVz8a/cHyDhfdYJiKXctvwywjHlKsWj600KKpYQjm6AxEOIOO3hPPXZg3
aEWyMvw0qeRewOdBnA+FFnzpUFUKckcU1pla3WF2jmMmgaM/EVCC0KvRTGjlqVLDoxU0eGOxR/Vtkk/z
NpDh4d891UPYdYbYbkBOMKJV+18tUrXhcGlP4iXAvGcNryIBGBr1plc5ZEKg3ebBdYEUwttIK9l/h0mp
x+5WsNoZki+VUKCUI+hCMM3GlwtuoPvrb43uejXwvuRNWGwYCW76WecYpjnxYtDmvqhGi668uEAxR1DR
EPM+vTUnzzYF+H84gNs7d82/Cg6D6YU1unv7OTYtSffMY7jTXkD1/oQqq4ma1c6q3rAiELn9N+y3DQAA
EOF
```

Then make the program executable: `chmod +x btry`.

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
