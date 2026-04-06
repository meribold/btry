A battery status program for x86-64 Linux laptops in the form of a 302-byte ELF
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
9bc8nZdvOusAMtDFnv5E2hsSuIh5IhxLCVZ7WM35hVcPC/CrXyHBd6jQUFj6gp5H5jR9IUyg2Y2+BuoYzR4jn
7jYEIfm4Ge/nNWXtsKXxQfEIDP2NJFvUygoUI1Z+PA4zZv5j9gl9s9zCvvSi4YIbts172YCF0qDFX5AlgfxnX
Sr/xfEb96lxb22qXCSC4UO7W/GZcDshcLE3ML0IQFd3yZoQO1Eusg/HqS2YdT7Fw6fj9/Yc4YaV0O+2bp5Y3B
JYUjaImVbH6TqV7lr0bivk6lLjV5RDt/H0T8cJ4ce4L/+3kG6A=' | unxz > btry && chmod +x btry
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
