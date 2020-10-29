# Section 6.17 Binutils

The Binutils package contains a linker, an assembler, and other tools for
handling object files.

## Configure Arguments
```bash
--enable-shared
```
Builds libbfd as a shared library.
```bash
--enable-64-bit-bfd
```
Enables 64-bit support (on hosts with narrower word sizes). May not be needed on
64-bit systems, but does no harm.
