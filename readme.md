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
4AHRAWYAAD+R1tX9PhIqx7s6AgikVMEPsJf5Lf5g4xQNjMWNtO8HAveeDflMxgfGZN5pxN98AvJONoWtSD
3r/2fD8+pTo1z0Wmg8ckBXn37pnLqK7VPWLb6BuravlyX2UUroOamQkHpZS1FigDpKLb5Edf65UkxNpkoi
3iWRZwSsxUJ2HMKXYSgHwzeQFS4Zfij1QBNGWzg/UDubHHOVEamwVkYhsUN2am8QESfmLAf7Oi0zmMplZY
6KYRLvkIb8gXo6+Ap0MRH4nDrbevK5bYvv5Vi4hwOHLxcqLdj+xDcfvl2IKPHCj+h9kzXdcGxZDxGKxty3
pP8F9vzzu988KhqPckjE3ijWuBgpzsoTiuHy8hscYCjmR3Dj6JY34rMYfBTqx/R0xNidKjWtm2mdFbS6u2
EBiQyywVp1incoC3VxC/T2Qo5iNSsEpPc30Li9mW374HzQJDJNZNrCtp4bkvJnNxjeU3BdYhiv7XwA
EOF
chmod +x btry
```

## Build instructions

### Linux on x86-64

    $ make

### Other platforms

No.

## Notes

When my ThinkPad is plugged in at the time I wake it from suspend mode, I get the
`charge_now` file.  When it is not plugged in I get the `energy_now` file.  At least I
think that's how it works.
