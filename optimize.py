#!/usr/bin/env python

import struct

with open("btry", mode="rb") as f:
    btry_bytes = bytearray(f.read())

# Remove two program headers that we don't care about.  Each program header has a size of
# 0x38.
del btry_bytes[0x78 : 0x78 + 0x38 * 2]

# Remove the NOTE/GNU_PROPERTY segment that each of the two removed program headers
# described.
del btry_bytes[0x78 : 0x78 + 0x30]

# Overlap the ELF header and the one remaining program header by 8 bytes.
del btry_bytes[0x38:0x40]
# Change `e_phoff` from 0x40 to 0x38.
btry_bytes[0x20:0x28] = b"\x38\x00\x00\x00\x00\x00\x00\x00"

# Remove data at the very end of the executable.
del btry_bytes[-len("111.1 Wh / 111.1 Wh (100%)\n") :]
# Add the last three characters of the string `btry` will print in a location of the ELF
# header where it won't cause damage.
btry_bytes[0x2D:0x30] = b"%)\n"
# Change references to `$output` (which we removed) so that we will build the output
# string by overwriting parts of the ELF header instead.
btry_bytes = btry_bytes.replace(b"\xa7\x02\x40\x00", b"\x2d\x00\x40\x00")
btry_bytes = btry_bytes.replace(b"\xaa\x02\x40\x00", b"\x30\x00\x40\x00")

# Update `e_entry` of the ELF header.
e_entry = struct.unpack("<Q", btry_bytes[0x18:0x20])[0] - 0x38 * 2 - 0x30 - 8
btry_bytes[0x18:0x20] = struct.pack("<Q", e_entry)

# Update `e_phnum`.  Set it to 1.
btry_bytes[0x38:0x3A] = struct.pack("<H", 1)

# Update `p_filesz` and `p_memsz` of the one remaining program header.
btry_bytes[0x58:0x60] = struct.pack("<Q", len(btry_bytes))
btry_bytes[0x60:0x68] = struct.pack("<Q", len(btry_bytes))

# Update some addresses.  This is really brittle and likely to break for all kinds of
# reasons.  FIXME?!
for address in (
    b"\x66\x02\x40\x00",
    b"\x66\x02\x40\x00",
):
    idx = btry_bytes.index(address)
    new_address = struct.unpack("<L", address)[0] - 0x38 * 2 - 0x30 - 8
    btry_bytes[idx : idx + 4] = struct.pack("<L", new_address)

with open("btry", mode="wb") as f:
    f.write(btry_bytes)
