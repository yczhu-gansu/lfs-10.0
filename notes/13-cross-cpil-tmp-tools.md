# Section 6.1 Introduction

This chapter 6 shows how to cross-compile basic utilities using the just built
cross-toolchain.

Those utilities are installed into their final location, but cannot be used yet.
Basic tasks still rely on the host's tools. Nevertheless, the installed
libraries are used when linking.

Using the utilities will be possible in next chapter after enter the "chroot"
environment. But all the packages built in the present chapter need to be built
before we do that. Therefore we cannot be independent of the host system yet.

## Section 6.2 m4
The m4 package contains a macro processor.
```bash
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/g lib/*.c
```
edit files in place (makes backup if SUFFIX supplied).

## Section 6.3 Ncurses
The Ncurses package contains libraries for terminal-independent handling of
character screens.

### The meaning of the new configure options:
```bash
--with-manpage-format=normal
```
Prevents Ncurses installing compressed manual pages, which may happen if the
host distribution itself has compressed manual pages.
```bash
--without-ada
```
Ensures that Ncurses does not build support for the Ada compiler which may be
present on the host but will not be available once we enter the chroot
environment.
```bash
--enable-widec
```
Causes wide-character libraries (e.g., libncursesw.so.6.2) to be built instead
of normal ones (e.g., libncurses.so.6.2). These wide-character libraries are
usable in both multitype and traditional 8-bit locales, while normal libraries
work properly only in 8-bit locales. Wide-character and normal libraries are
source-compatible, but not binary-compatible.
```bash
--without-normal
```
This switch disables building and installing most static libraries.

#### The meaning of the install options:
```bash
TIC_PATH=$(pwd)/build/progs/tic install
```
We need to path the path of the just built tic able to run on the building
machine, so that the terminal database can be created without errors.
```bash
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
```
The libncursesw.so library is needed by a few packages we will build soon. We
create this small linker script.

## Section 6.4

The Bash package contains the Bourne-Again SHell.

### The meaning of the configure options:
```bash
--without-hash-malloc
```
Turns off the use of Bash's memory allocation (malloc) function which is know to
cause segmentation faults. By turning this option off, Bash will use the
*malloc* function from Glibc which are more stable.

## Section 6.5 Coreutils
The Coreutils package contains utilities for showing and setting the basic
system characteristics.

### The meaning of the configure options:
```bash
--enable-install-program=hostname
```
Enables the *hostname* binary to be built and installed - it is disabled by
default but is required by the Perl test suite.

## Section 6.6 Diffutils
The Diffutils package contains programs that show the differences between files
or directories.

## Section 6.7 File
The File package contains a utility for determining the type of a given file or
files.

## Section 6.8 Findutils
The Findutils package contains programs to find files. These programes are
provided to recursively search through a directory tree and to create, maintain,
and search a database (of faster than the recursive find, but is unreliable if
the database has not been recently updated).

## Section 6.9 Gawk
The Gawk package contains programs for manipulating text files.

## Section 6.10 Grep
The Grep package contains programs for searching through the contents of files.

## Section 6.11 Gzip
The Gzip package contains programs for compressing and decompressing files.

## Section 6.12 Make
The Make package contains a program for controlling the generation of
executables and other non-source files of a package from source files.

### The meaning of the new configure option:
```bash
--without-guile
```
Although we are cross-compiling, configure tries to use guile from the build
host if it finds it. This makes compilation fails, so this switch prevents using
it.

## Section 6.13 Patch
The Patch package contains a program for modifying or creating files by applying
a "path" file typically created by the diff program.

## Section 6.14 Sed
The Sed package contains a stream editor.

## Section 6.15 Tar
The Tar package contains the ability to create tar archives as well as perform
various other kinds of archive manipulation. Tar can be used on previously
created archives to extract files, to store additional files, or to update or
list files which were already stored.

## Section 6.16 Xz
The Xz package contains programs for compressing and decompressing files. It
provides capabilities for the lzma and the newer xz compression formats.
Compressing text files with xz yields a better compression percentage than with
the traditional gzip or bzip2 commands.

## Section 6.17 Binutils
The Binutils package contains a linker, an assembler, and other tools for
handling object files.

### The meaning of the new configure option:
```bash
--enable-shared
```
Builds libbfd as a shared library.
```bash
--enable-64-bit-bfd
```
Enables 64-bit support (on hosts with narrower word sizes). May not be needed on
64-bit systems, but does no harm.

## Section 6.18 GCC Pass 2

The GCC package contains the GNU compiler collection, which includes the C and
C++ compilers.

### The meaning of the new configure option:
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
