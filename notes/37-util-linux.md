# Section 7.13 Util-linux

Contains miscellaneous utility programs.

## Configure Arguments
```bash
ADJTIME_PATH=/var/lib/hwclock/adjtime
```
This sets the location of the file recording information about the hardware
clock in accordance to the FHS. This is not strictly needed for this temporary
tool, but it prevents creating a file at another location which would not be
overwritten or removed when building the final util-linux package.
```bash
--disable-*
```
Prevent warnings about building components that require packages not in LFS or
no installed yet.
```bash
--without-python
```
Disables using Python. It avoids trying to build unneeded bindings.
