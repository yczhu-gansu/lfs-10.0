# Important Preliminary Material

## I. Introduction
This part is divided into three stages:
1. Build a cross compiler and its associated libraries;
2. Use this cross toolchain to build several utilities in a way that isolates
   them from the host distribution;
3. Enter the chroot environment, which further imporves host isolation, and
   build the remaining tools needed to build the final system.

## Toolchain Technical Notes
The overall goal of Chapter 5 and Chapter 6 is to produce a temporary area that
contains a known-good set of tools that can be isolated from the host system.

By using **chroot**,  the commands in the remaining chapters will be contained
within that environment, ensuring a free, trouble-free build of the target LFS
system.

The build process is based on the process of cross-compilation.

### About cross-Compilation
Some Terms Used in This Context:
1. build, is the machine we build programs.
2. host, is the machine/system where the built programs will rum.
3. target, is the machine the compiler produces code for.

A example scenario
1. Machine A, a slow machine, with a compiler named ccA;
2. Machine B, a fast machine, with no compiler;
3. Machine C, we want to produce code for.

To build a compiler for machine C, we would have three stages:

| **Stage** | **Build** | **Host** | **Target** | **Action** |
| --- | --- | --- | --- | --- |
| 1 | A | A | B | Build cross compiler cc1 using ccA on A |
| 2 | A | B | B | Build cross compiler cc2 using cc1 on A |
| 2 | B | C | C | Build cross compiler ccC using cc2 on B |

Then, all the other programs needed by machine C can be compiled using cc2 on
the fast machine B (if you can compile a compiler, you can compile all the
other programs).

Note that unless B can run programs produced for C, there is no way to test the
built programs machine C itself is running. For example, for testing ccC, we
need to add a fourth stage:

| **Stage** | **Build** | **Host** | **Target** | **Action** |
| --- | --- | --- | --- | --- |
| 4 | C | C | C | rebuild and test ccC using itself on C |

In the example above, only cc1 and cc2 are cross compilers, that is, they
produce code for a machine that is different from the one they are run on.

The other compilers ccA and ccC produce code for the machine they are run on.
Such compilers are called native compilers.

### Implementation of Cross-Compilation for LFS
1. Machine triplet: cpu-vendor-kernel-os.

A simple way to determine your machine triplet is to run the config.guess script
that comes with the source for many packages, and note the output. For a 32-bit
Intel processor the output will be x86-pc-linux-gnu. On a 64-bit system it will
be x86\_64-pc-linux-gnu.

2. The name of the platform's dynamic linker:

often reffered to to as the dynamic loader (not to be confused with the standard
linker ld that is part of binutils).

The dynamic linker provided by Glibc finds and loads the shared libraries needed
by a program to run, and then runs it.

The name of the dynamic linker for a 32-bit Intel machine will be ld-linux.so.2
(ld-linux-x86-64.so.2 for 64-bit systems.)

A sure-way to determine the name of the dynamic linker:
```
$ readelf -l <name of binary> | grep interpreter
```

3. Use the --with-sysroot option when building the cross linker and cross
compiler to tell them where to find the needed host files. This ensures that
none of the other programs built in Chapter 6 can link to libraries on the build
machine. Only two stages are mandatory, and one more for tests:

| **Stage** | **Build** | **Host** | **Target** | **Action** |
| --- | --- | --- | --- | --- |
| 1 | pc | pc | lfs | build cross compiler cc1 using cc-pc on pc |
| 2 | pc | lfs | lfs | build compiler cc-lfs using cc1 on pc |
| 3 | lfs | lfs | lfs | rebuild and test cc-lfs using itself on pc |

In the above table, "on pc" means the commands are run on a machine using
already installed distribution. "On lfs" means the commands are run in a
chrooted environment.

4. More About Cross-Compiling
The C language is not just a compiler, but also defines a standard library, e.g.
glibc.

The standard C library must be compiled for the lfs machine, that is using the
cross compiler cc1. But the compiler itself uses an internal library
implementing complex instructions not available in the assembler instruction
set. This internal library is named libgcc, and must be linked to the glibc
library to be fully functional.

Furthermore, the standard library for C++ (libstdc++) also needs been linked to
glibc.

The solution to this chicken and egg problem is to first build a degraded cc1
based on libgbcc, lacking some functionalities such as threads and exception
handling, then build glibc using this degraded compiler (glibc itself is not
degraded), the build libstdc++.

Conclusion: cc1 is unable to build a fully functional libstdc++, but this is the
only compiler available for building the C/C++ libraries during stage 2.

The compiler built during stage 2, cc-lfs, would be able to build those
libraries, but:
* the build system of GCC does not know that it is usable on pc, and
* using it on pc would be at risk of linking to the pc libraries, since cc-lfs
is a native compiler.

So we have to build libstdc++ later, in chroot.

### Other procedural details
The cross-compiler will be installed in a separate $LFS/tools directory, since
it will not be part of the final system.

Binutils is installed first because the *configure* runs both GCC and Glibc
perform various features tests on the assembler and linker to enable or disable.

Binutils installs its assembler and linker in two locations, $LFS/tools/bin and
$LFS/tools/$LFS\_TGT/bin. The tools in one location are hard linked to the
other.

An important facet of the linker is its library search order. Detailed
information can be obtained from:

The next package installed is GCC.

```bash
$ $LFS_TGT-ld --verbos | grep SEARCH
```

will illustrate the current search paths and their order.

```bash
$ $LFS_TGT-gcc dummy.c -Wl,--verbose 2>&1 | grep succeeded
```

will show all the files successfully opened druing linking.

To find out which standard linker *gcc* will use, run:

```bash
$ $LFS_TGT-gcc --print-prog-name=ld
```

```bash
$ gcc -v dummy.c
```

will show detailed information about the processor, compilation, and assembly
stages, including gcc's included search paths and their order.

Next installed are sanitized Linux API headers. These allow the standard C
library (Glibc) to interface with features that the Linux kernel will provide.

The next package installed is Glibc.

The standard C++ library is compiled next.

At the end of Chapter 6 the native lfs compiler is installed.

## General Complation Instructions
To re-emphaise the build process:
1. Place all the sources and patches in a directory that will be accessible from
the chroot environment such as */mnt/lfs/sources*.
2. Change to the sources directory.
3. For each package:
	* Using the tar program, extract the package to be tuilt. In Chapter 5 and
	  Chapter 6, ensure you are the lfs user when extracting the package.
	* Change to the directory created when the package was extracted.
	* Follow the book's instructions for building the package.
	* Change back to the sources directory.
	* Delete the extracted source directory unless instructed otherwise.
