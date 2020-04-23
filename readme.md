## Usage

    $ btry
    42 Wh

This *usually* works on my ThinkPad X220 running Linux.  Sometimes the
`/sys/class/power_supply/BAT0/energy_now` file, which `btry` reads, does not exist.  This
situation is indicated to the user by dumping core.

## Build instructions

### Linux on x86-64

    $ make

### Other platforms

No.

## Notes

When my ThinkPad is plugged in at the time I wake it from suspend mode, I get the
`charge_now` file.  When it is not plugged in I get the `energy_now` file.  At least I
think that's how it works.  Since `btry` requires the `energy_now` file, unsuspending
without unplugging first is considered user error.
