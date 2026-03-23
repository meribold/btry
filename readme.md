A battery status program for x86-64 Linux laptops in the form of a 359-byte ELF
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
4AFmASoAAD+R1tX9PhIql6sjxkjsaokIKBWGZx/84juTwnC0Z1zPT1NrX7p18E3d+SYZAoDxhoI6EZaJVY
tZPl3Qp8KeGVlsZeWyTuXoiGJPz4LwI8RzZ39gQzk/qzkk/d1HsH0PVEQyUCICZJT7dO8d4IQ7F9MPGohc
YPM+E1YaSfMsrc7NmfElRBG/5O8cWYMlEhW949u3RqAnETLNEgLSLMBseXkSevHoPpdm9nAvNloQ4fPkBH
Owh5TfhGbhy16rp+FWqmGdCmryG8YXGFiBCOFmg+4zNY8DjS4mg87svJNmYN5BUQmi5rXP6rC2Q7Wz0On7
BFgVXwd4xfPMb48kMaHwbSvIMnk13d2fpgs1b7byEshte/XEZIp16DlOvhNJ2jyp5RWVBS8Y8g4s0mAA
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
