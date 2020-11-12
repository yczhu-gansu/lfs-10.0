# Additional Temporary Tools

## Section 7.7 Libstdc++ from GCC
When building gcc-pass2 we had to defer the installation of the C++ standard
library because no suitable compiler was available to compile it.

We could not use the compiler built in that section because it is a native
compiler and should not be used outside of chroot and risks polluting the
libraries with some host components.

### The meaning of the configure options:
```bash
CXXFLAGS="-g -O2 -D_GNU_SOURCE"
```
These flags are passed by the top level Makefile when doing a full build of GCC.
```bash
--host=$(uname -m)-lfs-linux-gnu
```
We have to mimic what would happen if this package were built as part of a full
compiler build. This switch would be passed to configure by GCC's build
machinery.
```bash
--disable-libstdcxx-pch
```
This switch prevents the installation of precompiled include files, which are
not needed at this stage.

## Section 7.8 Gettext
The Gettext package contains utilities for internationalization and
localization. These allow programs to be compiled with NLS (Native Language
Support), enabling them to output messages in the user's native language.

### The meaning of the configure options:
```bash
--disable-shared
```
We do not need to install any of the shared Gettext libraries at this time,
there for there is no need to build them.

## Section 7.9 Bison
The Bison package contains a parser generator.

### The meaning of the new configure options:
```bash
--docdir=/usr/share/doc/bison-3.7.1
```
This tells the build system to install bison documentation into a versioned
directory.

## Section 7.10 Perl
The Perl package contains the Parctical Extraction and Report Language.

### The meaning of the new configure options:
```bash
-des
```
This is a combination of three options:
1. -d uses defaults for all items;
2. -e ensures completion for all tasks;
3. -s silence non-essential output.

## Section 7.11 Python 3
The Python 3 package contains the Python development environment. It is useful
for object-oriented programming, writing scripts, prototyping large programs, or
developing entire applications.

### The meaning of the configure options:
```bash
--enable-shared
```
This switch prevents installation of static libraries.
```bash
--without-ensurepip
```
This switch disables the Python package installer, which is not needed at this
stage.

## Section 7.12 Textinfo
Contains programs for reading, writing, and converting info pages.

## Section 7.13 Util-linux
Contains miscellaneous utility programs.

### The meaning of the configure options:
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
