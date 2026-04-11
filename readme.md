A battery status program for x86-64 Linux laptops in the form of a 309-byte ELF
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
hz7+A+BEXQGjYrdir7Xnf3pZU9kJmd8xTlms7vnganG1PU0yH+S+VrfatOUEGMDpsGc35AU1w3J8Smj60+Qwr
iqloYa4uG476UL8T6pf66ohNbvzrRw5jsFW6VLHmZArWbrzodgCrNyBQUSxAq+e4Z2bckAwM+5ZuPRnnT1bwo
fiOR4ctCg2WkoSzEdKS1Ckrc6WbPpDENpZe9j+4ocykLKFjEz+6N66gxAwzQ0YyZ2fa8Xs5THGU5/4oBT3TlN
iT3KwY1tYQY/A9Hfz2G28GOh3hii1BHTu71D/khdrO+uPzLUEA=' | unxz > btry && chmod +x btry
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
