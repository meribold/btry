This sometimes works on my ThinkPad X220 running Linux.  Other times the
`/sys/class/power_supply/BAT0/energy_now` file does not exist and it breaks.

Usage:

    $ btry
    42 Wh

When my ThinkPad is plugged in at the time I wake it from suspend mode, I get the
`charge_now` file.  When it is not plugged in I get the `energy_now` file.  At least I
think that's how it works.  Since this program requires the `energy_now` file,
unsuspending without unplugging first is considered user error.
