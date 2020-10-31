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
