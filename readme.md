A battery status program for x86-64 Linux laptops in the form of a 303-byte ELF
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
9bc8nZdvOusAMtDFnv5E2hsSuIh5IhxLCVZ7WM35hVcPC/CrXyHB06iQUFj6gp5H5jR9IUzjTcNObVQRTdm36
86DsBgVh62e8VQyAXFAEbtdOAqDYeB3qmXhotXWrCp5dzgxbYga9wq9QV3IzbqNkA+puhyUiH2jcgBZyazsJS
1mQH5HqTKWhHkBeT2BFaJdvxYP/93cSlsZ+uGj3xi2abSMa41l7baR44cxIRDkRHKCXDQMtUtki1uw4lJk3Gm
8DLD8PsVnFGruCAQZ4PMDQXqNHzEYZCGj9opHX378AEyP/D5GMA' | unxz > btry && chmod +x btry
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
