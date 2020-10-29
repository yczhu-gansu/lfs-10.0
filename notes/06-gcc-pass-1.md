# Section 5.3 GCC-10.2.0 - Pass 1

## The usage of sed
set the default directory name for 64-bit libraries to "lib"
```bash
sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
```

## configure args
```bash
--with-glibc-version=2.11
```
This option ensures the package will be compatible with the host's version of
glibc. It is set to the minimum glibc requirement specified in the Host System
Requirements.
```bash
--with-newlib
```
Since a working C library is not yet available, this ensures that the
inhibit\_libc constant is defined when building libgcc. This prevents the
compiling of any code that requires libc support.
```bash
--without-headers
```
When creating a complete cross-compiler, GCC requires standard headers
compatible with the target system. For our purposes these headers will not be
needed. This switch prevents GCC from looking for them.
```bash
--enable-initfini-array
```
This switch forces the use of some internal data structures that are needed but
cannot be detected when building a cross compiler.
```bash
--disable-shared
```
Forces GCC to link its internal libraries statically. We need this because the
shared libraries require glibc, which is not yet installed on the target system.
```bash
--disable-multilib
```
On x86\_64, LFS does not support a multilib configuration. This switch is
harmless for x86.
```bash
--disable-decimal-float
--disable-threads
...
--disable-libstdcxx
```
These switches disable support for the decimal point extension and some releated
library. These features will fail  to compile when building a cross-compiler and
are not necessary for the task of cross-compiling the temporary libc.
```bash
--enable-languages=c,c++
```
Ensures that only the C and C++ compilers are built. These are the only
languages needed now.
```

