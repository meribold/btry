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
base64 -d <<EOF | lzcat > btry
XQAAgAD//////////wA/kUWEaD2JptqKzJPiTtkDivxsK2zofYLNvkRewC6B8YmKnA3ZcXVwKtydE1RoSynxKA
sx++uJulwUW9QX/l57HmD8/H5Smrfwtr/NQHDQTUPRWmGvcKZ+qPlOhrFIHEb/AcmWWQpAYFlSGlFc1iNaN+lg
BVhykIiTMQFNu1dgrAWWzl1Aa2jXO2GS/a4n8l8VTO2iEAy9JubqzizBthQmTnW0CJ3vtwxXCKNYlbR3TxinFg
kyC8YA+IKvfABSTZKALc0pamJubMGiLaaIYgDUdftnvcp+8Fjv0eeTXSu63rIwvvMbtTxFL/2x0hRAjPQSLskx
oo28YAMnusXVPEKjWx5erbVXoUXAKZ2wRow5PqNOI7dojbKKYcKiPmdBB0LZNCM99O+6ugKKSGRdE9x2ZsoqPb
NUEw8KRCNKZ890ygyU3pRZAX5MhiAv6C2x3fx+NJplDCOYNl9CtPkH4RHG2qmqYWjA5LJ2D+Mjvatd3P/sPpUH
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
