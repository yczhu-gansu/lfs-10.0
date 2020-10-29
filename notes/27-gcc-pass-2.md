# Section 6.18 GCC Pass 2

The GCC package contains the GNU compiler collection, which includes the C and
C++ compilers.

## Configure Arguments
```bash
--with-build-sysroot=$LFS
```
Normally, using --host ensures that a cross-compiler is used for building GCC,
and that compiler knows that it has to look for headers and libraries in $LFS.
But the build system of GCC uses other tools, which are not aware of this
location. This switch is needed to have them find the needed files in $LFS, and
not on the host.
```bash
--enable-initfini-array
```
This option is automatically enabled when building a native compiler with a
native compiler on x86. But here, we build with a cross compiler, so we need to
explicitly set this option.
