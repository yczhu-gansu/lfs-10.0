# Rational for Packages in the Book

The goal of LFS is to build a complete and usable foundation-level system. This
includes all packages needed to replicate itself whie providing a relatively
minimal base from which to customize a more complete system based on the choices
of the user.

Several important packages are included that are not strictly required.

The lists below document the rational for each package in the book.
1. Acl, Contains utilities to administer Access Control Lists, which are used to
   define more fine-grained discretionary access rights for files and
   directories.
2. Attr, Contains programs for administering extended attributes on filesystem
   objects.
3. Autoconf, Contains programs for producing shell scripts that can automatically
   configure source code from a developer's template. It is often needed to
   rebuild a package after updates to the build procedures.
4. Automake, Contains programs for generating Make files from a templete. It is
   often needed to rebuild a package after updates to the build procedures.
5. Bash, Satisfies an LSB core requirement to provide a Bourne Shell interface to
   the system. It was chosen over other shell packages because of its common
   usage and extensive capabilities beyond basic shell functions.
6. Bc, Provides an arbitrary precision numeric processing language. It satifies
   a requirement needed when building the Linux kernel.
7. Binutils, Contains a linker, an assembler, and other tools for handling
   object files. The programs in this package are needed to compile most of the
   packages in an LFS system and beyond.
8. Bison, Contains the GNU version of yacc (Yet Another Compiler Compiler)
   needed to build serveral other LFS programs.
9. Bzip2, Contains programs for compressing and decompressing files. It is
   required to decompress many LFS packages.
1. Check, Contains a test harness for other programs.
1. Coreutils, Contains a number of essential programs for viewing and
   manipulating files and directories. These programs are needed for command line
   file management, and are necessary for the installation procedures of every
   package in LFS.
1. DejaGNU, Contains a framework for testing other programs.
1. Diffutils, Contains programs that show the differneces between files or
   directories. These programs can be used to create patches, and are also used
   in many packages' build procedures.
1. E2fsprogs, Contains utilities for handling the ext2, ext3 and ext4 file
   systems. These are the most common and thoroughly tested file systems that
   Linux supports.
1. Eudev, This package is a device manager. It dynamically controls the
   ownership, permissions, names, and symbolic links of devices in the /dev
   directory as devices are added or removed from the system.
1. Expat, Contains a relatively small XML parsing library. It is required by the
   XML::Parser Perl module.
1. Expect, Contains a program for carry out scripted dialogues with other
   interactive programs. It is commonly used for testing other packages. It is
   only installed in the temporary toolchain.
1. File, Contains a utility for determining the type of a given file or files. A
   few packages need it in their build scripts.
1. Findutils, Contains programs to find files in a file system. It is used in
   many packages' build scripts.
1.  Flex, Contains a utility for generating programs that recognize patterns in
   text. It is the GNU version of lex (lexical analyzer) program. It is required
   to build several LFS packages.
1.  Gawk, Contains programs for manipulating text files. It is the GNU version of
   awk (Aho-Weinberg-Kernihan). It is used in many other package's build scripts.
1.  GCC, This package is the Gnu Compiler Collection. It contains the C and C++
   compilers as well as several others not built by LFS.
1.  GDBM, Contains the GNU Database Manager library. It is used by one other LFS
   package, Man-DB.
1.  Gettext, Contains utilities and libraries for internationalization and
   localization of numberous packages.
1.  Glibc, Contains the main C library. Linux programs will not run without it.
1.  GMP, Contains the math libraries that provide useful functions for arbitrary
   precision arithmetic. It is required to build GCC.
1.  Gperf, Contains programs that generates a perfect hash function from a key
   set. It is required for Eudev.
1.  Grep, Contains programs for searching through files. These programs are used
   by most packages' build script.
1.  Groff, Contains programs for processing and formatting text. One important
   function of these programs is to format man pages.
1.  GRUB, Is the Grand Unified Boot Loader. It is one of several boot loaders
   available, but is the most flexible.
1.  Gzip, Contains programs for compressing and decompressing files. It is needed
   to decompress many packages in LFS and beyond.
1.  Iana-etc, Provides data for network services and protocols. It is needed to
   enable proper networking capabilities.
1.  Inetutils, Contains programs for basic network administration.
1.  Intltool, Contains tools extracting translatable from source files.
1.  IProute2, Contains programs for basic and advanced IPv4 and IPv6 networking.
   It was chosen over the other network tools package (net-tools) for its IPv6
   capabilities.
1.  Kbd, Contains key-table files, keyboard utilities for non-US keyboards, and a
   number of console fonts.
1.  Kmod, Contains programs needed to administer Linux kernel modules.
1.  Less, Contains a very nice text file viewer that allows scrolling up or down
   when viewing a file. It is also used by Man-DB for viewing manpages.
1.  Libcap, Implements the user-space interfaces to the POSIX 1003.1e
   capabilities available in Linux kernels.
1.  Libelf, The elfutils project provides libraries and tools for ELF files and
   DWARF data. Most utilities in this package are available in other packages,
   but the library is needed to build Linux kernel using the default (and most
   efficient) configuration.
1.  Libffi, Implements a portable, high level programming interface to various
   calling conventions. Some programs may not know at the time of compilation
   what arguments are to be passed to a function. For instance, an interpreter
   may be told at run-time about the number and types of arguments used to call a
   given function. Libffi can be used in such programs to provide a bridge from
   the interpreter program to compiled code.
1.  Libpipeline, Contains a library for manipulating pipelines of subprocesses in
   a flexible and convenient way. It is required by the Man-DB package.
1.  Libtool, Contains the GNU generic library support script. It wraps the
   complexity of using shared libraries in a consistent, portable interface. It
   is needed by the test suites in other LFS packages.
1.  Linux Kernel, Is the Operating System. It is the Linux in the GNU/Linux
   environment.
1.  M4, Contains a general text macro processor useful as a build tool for other
   programs.
1.  Make, Contains a program for directing the building of packages. It is
   required by almost every package in LFS.
1.  Man-DB, Contains programs for finding and viewing man pages. It was chosen
   instead of the man package due to superior internationalization capabilities.
   It supplies the man program.
1.  Man-pages, Contains the actual contents of the basic Linux man pages.
1.  Meson, Provides a software tool for automating the building of software. The
   main goal for Meson is to minimize the amount of time that software developers
   need to spend configuring their build system.
1.  MPC, Contains functions for the arithmetic of complex numbers. It is required
   by GCC.
1.  MPFR, Contains functions for multiple precision arithmetic. It is required by
   GCC.
1.  Ninja, Contains a small build system with a focus on speed. It is designed to
   have its input files generated by a higher-level build system, and to run
   builds as fast as possible.
1.  Ncurses, Contains libraries for terminal-independent handling of character
   screens. It is often used to provide cursor control for a menuing system. It
   is needed by a number of packages in LFS.
1.  Openssl, Provides management tools and libraries to cryptography. These are
   useful for providing cryptographic functions to other packages, including the
   Linux kernel.
1.  Patch, Contains a program for modifying or creating files by applying patch
   file typically created by the diff program. It is needed by the build
   procedure for several LFS packages.
1.  Perl, Is an interpreter for the runtime language PERL. It is needed for the
   installation and test suits of several LFS packages.
1.  Pkg-config, Provides a program that returns meta-data about an installed
   library or package.
1.  Procps-NG, Contains programs for monitoring processes. These programs are
   useful for system administration, and are also used by LFS Bootscripts.
1.  Psmisc, This package contains programs for displaying information about
   running processes. These programs are useful for system administration.
1.  Python3, Provides an interpreted language that has a design philosophy that
   emphisizes code readablity.
1.  Readline, Is a set of libraries that offers command-line editing and history
   capabilities. It is used by Bash.
1.  Sed, Allows editing of text without opening it in a text editor.
   It is also needed by most LFS packages' configure scripts.
1.  Shadow, Contains programs for handling passwords in a secure way.
1.  Sysklogd, Contains programs for logging system messages, such as those given
   by the kernel or daemon processes when unusual events occur.
1.  Sysvinit, Provides the init program, which is the parent of all other
   processes on the Linux system.
1.  Tar, Provides archiving and extraction capabilities of virtually all packages
   used in LFS.
1.  Tcl, Contains the Tool Command Language used in many test suits in LFS
   packages.
1.  Texinfo, Contains programs for reading, writing, and converting info pages. It
   is used in the installation procedures of many LFS packages.
1.  Util-linux, Contains misellaneous utility programs. Among them are utilities
   for handling file systems, consoles, partions, and messages.
1.  Vim, This package contains an editor. It was chosen because of its
   compatibility with the classic vi editor and its huge number of powerful
   capabilities. An editor is a very personal choice for many users and any other
   editor could be substituted if desired.
1.  XML::Parser, Is a Perl module that interfaces with Expat.
1.  XZ utils, Contains programs for compressing and decompressing files. It
   provides the highest compression generally available and is useful for
   decompressing packages in XZ or LZMA format.
1.  Zlib, Contains compression and decompressing routines used by some programs.
1.  Zstd, Contains compression and decompressing routines used by some programs.
   It provides high compression ratios and a very wide range of compression /
   speed trade-offs.
