# Section 8.18 Binutils

The Binutils package contains a linker, an assembler, and other tools for
handling object files.

## Configure Arguments
```bash
--enable-gold
```
Build the gold linker and install it as ld.gold (along side the default linker).
```bash
--enable-ld=default
```
Build the original bfd linker and install it as both ld (the default linker) and
ld.bfd.
```bash
--enable-plugins
```
Enables plugin support for the linker.
```bash
--enable-64-bit-bfd
```
Enables 64-bit support (on hosts with narrower word sizes). May not be needed on
64-bit systems, but does no harm.
```bash
--with-system-zlib
```
Use the installed zlib library rather than building the included version.

The meaning of the make parameter:
```bash
tooldir=/usr
```
Normally, the tooldir (the directory where the executables will ultimately be
located) is set to *$(exec_prefix)/$(target_alias)*. For example, x86\_64
machines would expand that to */usr/x86_64-unknown-linux-gnu*. Because this is a
custom system, this target-specific directory in */usr* is not required.

*$(exec_prefix)/$(target_alias)* would be used if the system was used to
cross-compile (for example, compiling a package on an Intel machine that
genetates code that can be executed on PowerPC machines).

## Contents of Binutils
Installed programs:
* addr2line, Translates program addresses to file names and file numbers; given
  an address and the name of an executable, it uses the debugging information in
  the executable to determine which source file and line number are associated
  with the address
* ar, Creates, modifies, and extracts from archives
* as, An assembler that assembles the output of gcc into object files
* c++filt, Used by the linker to de-manage C++ and Java symbols and to keep
  overloaded functions from clashing
* dwp, The DWARF packaging utility
* elfedit, Updates the ELF header of ELF files
* gprof, Displays call graph profile data
* ld, A linker that combines a number of object and archive files into a string
  file, relocating their data and tying up symbol references
* ld.gold, A cut down version of ld that only supports the elf object file
  format
* ld.bfd, Hard link to ld
* nm, Lists the symbols occuring in a given object file

Installed libraries:
* libbfd.{a,so}, The Binary File Descriptor library
* libctf.{a,so}, The Compat ANSI-C Type Format debugging support library
* libctf-nobfd.{a,so}, A libctf variant which does not use libbfd functionality
* libopcodes.{a,so}, A library for dealing with opcodes -- the "readable text"
  versions of instructions for the processor; it is used for building utilities
  like *objdump*

Installed directory:
* /usr/lib/ldscripts
