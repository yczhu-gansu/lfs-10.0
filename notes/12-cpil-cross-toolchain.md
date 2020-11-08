# Chapter 5 Compiling a Cross-Toolchain

## 5.1 Introduction
This chapter shows how to build a cross-compiler and its associated tools.

Although here cross-compilation is faked, the principles are the same as for a
real cross-toolchain.

The programs compiled in this chapter will be installed under the *$LFS/tools*
directory to keep them separate from the files installed in the follow chapters.

The libraries are installed into their final place, since they pertain to the
system we want to build.

## 5.2 Binutils-2.35 - Pass 1

The Binutils package contains a linker, an assembler, and other tools for
handling object files.

It is important that Binutils be the first package compiled because both Glibc
and GCC perform various tests on the available linker and assembler to
determine which of their own features to enable.

### The meaning of the configure options:
```bash
--prefix=$LFS/tools
```
This tells the configure script to prepare to install the binutils programs in
the $LFS/tools directory.
```bash
--with-sysroot=$LFS
```
For cross compilation, this tells the build system to look in $LFS for the
target system libraries as needed.
```bash
--target=$LFS\_TGT
```
Because the machine description in the LFS\_TGT variable is slightly different
than the value returned by the *config.guess* script, this switch will tell the
*configure* script to adjust binutils's build system for building a cross
linker.
```bash
--disable-nls
```
This disables internationalization as i18n is not needed for the temporary
tools.
```bash
--disable-werror
```
This prevents the build from stopping in the event that there are warnings from
the host's compiler.

## 5.3 GCC-10.2.0 - Pass 1

### The usage of sed
set the default directory name for 64-bit libraries to "lib"
```bash
sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
```

### The meaning of the configure options
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

This build of GCC installed a couple of internal system headers. Normally one of
them, *limits.h*, would in turn include the corresponding system *limits.h*
header, in this case, *$LFS/usr/include/limits.h*. However, at the time of this
build of GCC *$LFS/usr/include/limits.h* does not exist, so the internal header
that has just been installed is a partial, self-contained file and does not
include the extended features of the system headers. This is adequate for build
glibc, but the full internal header will be needed later.

Create a full version of the internal header using a command that is identical
to what the GCC build system does in normal circumstances.

## 5.4 Linux-5.8.3 API Headers

The Linux API Headers (in linux-5.8.3.tar.xz) expose the kernel's API for use
by Glibc.

The Linux kernel needs to expose an Application Programming Interface for the
system's C library (Glibc in LFS) to use. This is done by way of sanitizing
various C headers that are shipped in the Linux kernel source tarball.

## 5.5 Glibc

The Glibc package contains the main C library.

This library provides the basic routines for:
1. allocating memory
2. searching directories
3. opening and closing files
4. reading and writing files
5. string handling
6. pattern matching
7. arithmetic
8. ...

### The meaning of the configure options
```bash
--host=$LFS_TGT, --build=$(../scripts/config.guess)
```
The combined effect of these switches is that Glibc's build system configures
itself to be cross-compiled, using the cross-linker and cross-compiler in
$LFS/tools.
```bash
--enable-kernel=3.2
```
This tells Glibc to compile the library with support for 3.2 and later linux
kernels. Workarounds for older kernels are not enabled.
```bash
--with-headers=$LFS/usr/include
```
This tells Glibc to compile itself against the headers recently installed to the
$LFS/usr/include directory, so that it knows exactly what features the kernel
has and can optimize itself accordingly.
```bash
lib_cv_slibdir=/lib
```
This ensures that the libaray is installed in /lib instead of the default /lib64
on 64 bit machines.

### The meaning of the make options
```bash
make DESTDIR=$LFS install
```
The DESTDIR make variable is used by almost all packages to define the location
the package should be installed. If it is not set, it defaults to the root (/)
directory. Here we specify that the package be installed in $LFS.

Now that our cross-toolchain is complete, finalize the installation of the
limits.h header. For doing so, run a utility to provide by the GCC developers.
```bash
$LFS/tools/libexec/gcc/$LFS_TGT/10.2.0/install-tools/mkheaders
```

## Section 5.6 Libstdc++ from GCC

Libstdc++ is the standard C++ library. It is needed to compile the C++ code
(part of GCC is written in C++), but we had to defer its installation when we
built gcc-pass1 because it depends on glibc, which was not yet available in the
target directory.

### The meaning of the configure options
```bash
--host=...
```
Specifies the use the cross compiler we have just built instead of the one in
/usr/bin.
```bash
--disable-libstdcxx-pch
```
Prevents the installation of precompiled include files, which are not needed at
this stage.
```bash
--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0
```
This is the location where the C++ compiler should search for the standard
include files. In a normal build, this information is automatically passed to
the libstdc++ configure options from the top level directory. In our case, this
information must be explicitly given.
