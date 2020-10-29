# Section 7.7 Libstdc++ from GCC

When building gcc-pass2 we had to defer the installation of the C++ standard
library because no suitable compiler was available to compile it.

We could not use the compiler built in that section because it is a native
compiler and should not be used outside of chroot and risks polluting the
libraries with some host components.

## Configure Arguments
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
