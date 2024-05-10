A battery status program for x86-64 Linux laptops in the form of a 393-byte ELF
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
base64 -d <<EOF > btry && chmod +x btry
f0VMRgIBAQBBujEAAQDrGAIAPgABAAAACAABAAAAAAA4AAAAAAAAAEG9CgAAAOsgACUpCkAAOAABAAAABwAAAAAA
AAAAAAAAAAABAAAAAABBvCBXaCDrEIkBAAAAAAAAAAIAAAAAAADoWgAAAEWJ9+hSAAAAMdJEifBIa8BkSff36MgA
AABBxkL/KEmD6gVFiSJBl+iFAAAAZkHHQv4vIEmD6gZFiSJBluhwAAAAMcD/wInHRInWujQAAQBEKdIPBbA8Mf8P
Bb9hAQEAMcCwAjH2DwWFwHg0x0ckbm93AJeWSI10JPcx0rIJDwX+yEUx9jHJMdJNa/YKilQM94DqMEkB1kj/wUg5
yHXqw2ZBvCBBx0cdY2hhcsZHImXrqTHSQblAQg8AQffxQZCSMdJBuaCGAQBB9/FB9vWAxDBJ/8qI4EGIAkn/ykHG
Ai5BkDHSQff1gMIwSf/KQYgShcB17sMvc3lzL2NsYXNzL3Bvd2VyX3N1cHBseS9CQVQwL2VuZXJneV9mdWxs
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
