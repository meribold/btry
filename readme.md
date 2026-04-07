A battery status program for x86-64 Linux laptops in the form of a 298-byte ELF
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
base64 -d <<< 'AAAAgAD//////////wA/kdbV/T4SKqi4gu7TNukZJeNdhjgGWjLCw6YYwm3tgKjiZLitH
TPynRup8/TcSWlb7S75z0Swm5ipLfTcVY6E8/U348s4Og9wn9AgwNCgnr0A0kXHg5O3HvOy7A/FMZVjVqjQy
trAuDJun4UWBOpPsREPuvRIkQw3x2/i9swEaWPcjw1UpaonANEY/kXoLt4PoHvTlNulQGdNRNiv8ceHxpgOo
FPX7wLmbeMEUlwLal8kpRg74q84kP7Uic+iE8z7kFHjzyK0W1LsQLUosF8B8F+55Iw5QWtgbJ9HzPm2cUofz
tBnp3vx7ERXQ+mz1jF6sqi63Op7TLjN9PbTebxoRYOfTfp88AA=' | xz -d > btry && chmod +x btry
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
