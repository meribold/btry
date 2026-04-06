A battery status program for x86-64 Linux laptops in the form of a 301-byte ELF
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
base64 -d <<< 'AAAAgAD//////////wA/kdbV/T4SKqi4gu7TNukZJeNdhjgGWjLCw6YYunUzDj0iSFeVC4
9bc8nZdvOusAMtDFnv++xuh+k7XD8kT2JnkZeG85s4MYh0/yH2Wl0xRwKILmC43c6PAwN2xTm/yQJ8QOaKHyd
J+Zt2xHr0EBjsIQU7hBdT7jE0prLAgMOe87Tsx2jqjlxM8A3MjU88T8A1bfLt81P521A7XuQ8x5E44Fp83Hca
xlKoXvonFOyhs7aVbemJES6A+7tgMxVqlc4ERNo/G2tTm57isgdow3P5LTfSbY1WE3znXezPF4Pd8mbixjlaW
SAvPBLXemDFthDOV5jBizBq4+vpPIiGwGbPoS7LHPLxtv4WcwA=' | unxz > btry && chmod +x btry
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
