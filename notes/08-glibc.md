# Section 5.5

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

# Configure arguments
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
