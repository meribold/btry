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

# Update `e_entry` of the ELF header.
e_entry = struct.unpack("<Q", btry_bytes[0x18:0x20])[0] - 0x38 * 2 - 0x30
btry_bytes[0x18:0x20] = struct.pack("<Q", e_entry)

# Update `e_phnum`.  Set it to 1.
btry_bytes[0x38:0x3A] = struct.pack("<H", 1)

# Update `p_filesz` and `p_memsz` of the one remaining program header.
btry_bytes[0x60:0x68] = struct.pack("<Q", len(btry_bytes))
btry_bytes[0x68:0x70] = struct.pack("<Q", len(btry_bytes))

# Update some addresses.  This is really brittle and likely to break for all kinds of
# reasons.  FIXME?!
for address in (
    b"\x24\x03\x40\x00",
    b"\x82\x02\x40\x00",
    b"\xab\x02\x40\x00",
    b"\x24\x03\x40\x00",
    b"\xd3\x02\x40\x00",
    b"\xfc\x02\x40\x00",
):
    idx = btry_bytes.index(address)
    new_address = struct.unpack("<L", address)[0] - 0x38 * 2 - 0x30
    btry_bytes[idx : idx + 4] = struct.pack("<L", new_address)

with open("btry", mode="wb") as f:
    f.write(btry_bytes)
