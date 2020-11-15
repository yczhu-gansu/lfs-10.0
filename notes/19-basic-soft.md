# Basic System Software

## Section 8.3 Man-pages
The Man-package contains over 2,200 man pages.

Installed various man pages.

Describe C programming language functions, import device files, and significant
configuration files.
### Installed files
various man pages, Describe C programming language functions, important device
files, and significant configuration files.

## Section 8.4 Tcl
The Tcl package contains the Tool Command Language, a robust general-purpose
scripting language. The Expect package is written in the Tcl language.

The various "sed" instructions after the "make" command removes references to
the build directory from the configuration files and replaces them with the
install directory. This is not mandatory for the remainder of LFS, but may be
needed in case a package built later uses Tcl.

### Installed programs:
* tclsh (link to tclsh8.6), A link to tclsh8.6
* tclsh8.6, The Tcl command shell

### Installed library:
* libtcl8.6.so, The Tcl library
* libtclstub8.6.a, The Tcl Stub library

## Section 8.5 Expect
The Expect package contains tools for automating, via scripted dialogues,
interactive applications such as:
* telnet
* ftp
* passwd
* fsck
* rlogin
* tip
Expect is also useful for testing these same applications as well as easing all
sorts of tasks that are prohibitively difficult with anything else.

The DejaGnu framework is written in Expect.

### The meaning of the configure options
```bash
--with-tcl=/usr/lib
```
This parameter is needed to tell configure where the tclConfig.sh script is
located.
```bash
--with-tclinclude=/usr/include
```
This explicitly tells Expect where to find Tcl's internal headers.
## Installed program:
* expect, Communicates with other interactive programs according to a script
## Installed library:
* libexpect-5.45.so, Contains functions that allow Expect to be used as a Tcl
  extension or to be used directly from C or C++ (without Tcl).

## Section 8.6 DejaGNU
The DejaGNU package contains a framework for running test suites on GNU tools.
It is written in expect, which itself uses Tcl (Tool Command Language).
### Installed program
* runtest, A wrapper script that locates the proper expect shell and then runs
  DejaGNU.

## Section 8.7 Iana-Etc
The Iana-Etc package provides data for network services and protocols.
### Installed files:
* /etc/protocols, Describes the various DARPA Internet protocols that are
  available from the TCP/IP subsystem.
* /etc/services, Provides a mapping between friendly textual names for internet
  services, and their underlying assigned port numbers and protocol types.

## Section 8.8 Glibc
The Glibc package contains the main C library. This library provides the basic
routines for:
* allocating memory,
* searching directories,
* opening and closing files,
* reading and writing files,
* string handling,
* pattern matching,
* arithmetic,
* ...
### The meaning of the configure options
```bash
--disable-werror
```
Disables the -Werror option passed to GCC. This is necessary for running the
test suite.
```bash
--enable-kernel=3.2
```
Tells the build system that this glibc may be used with kernels as old as 3.2.
This means generating workarounds in case a system call introduced in a later
version cannot be used.
```bash
--enable-stack-protector=strong
```
Increases system security by adding extra code to check for buffer overflows,
such as stack smashing attacks.
```bash
--with-headers=/usr/include
```
Tells the build system where to find the kernel API headers.
```bash
libc_cv_slibdir=/lib
```
This variable sets the correct library for all systems. We do not want lib64 to
be used.
### Locales
The locales can make the system respond in a different language. None of the
locales are required, but if some of them missing, the test suits of the future
packages would skip important testcases.

Individual locales can be installed using the *localedef* program.

Typed instructions will install the minimum set of locals necessary for the
optimal coverage of tests.

Alternatively, install all locals listed in the *glibc-2.32/localdata/SUPPORTED*
file (it includes every local listed above and many more) at once with the
following time-consuming command:
```bash
make localdata/install-locales
```
### Configuring Glibc
#### Adding nsswitch.conf
The /etc/nsswitch.conf file needs to be created because the Glibc defaults do
not work well in a networked environment.

#### Adding time zone data
```bash
tar -xf ../../tzdata2020a.tar.gz
```

### The meaning of the zic commands:
```bash
zic -L /dev/null ...
```
This creates posix time zone without any leap seconds. It is convential to put
these in both *zoneinfo* and *zoneinfo/posix*. It is necessary to put the POSIX
time zones in *zoneinfo*, otherwise various test-suites will report errors. On
an embedded system, where space is tight and you do not intend to ever update
the time zones, you could save 1.9 MB by not using the *posix* directory, but
some applications or test-suites might produce some failures.
```bash
zic -L leapseconds ...
```
This creates right time zones, includeing leap seconds. On an embedded system,
where space is tight and you do not intend to ever update the time zones, or
care about the correct time, you could save 1.9 Mb by ommiting the *right*
directory.
```bash
zic ... -p ...
```
This creates the *posixrules* file. We use New York because POSIX requires the
daylight savings time rules to be in accordance with US rules.
### Configuring the Dynamic Loader
By default, the dynamic loader (/lib/ld-linux.so.2) searches through */lib* and
*/usr/lib* for dynamic libraries that are needed by programs as they are run.

Howerer, if there are libraries in directories other than */lib* and */usr/lib*,
these need to be added to the */etc/ld.so.conf* file in order for dynamic loader
to find them.

Two directories that are commonly known to contain additional libraries are
*/usr/local/lib* and */opt/lib*, so add those directories to the dynamic
loader's search path.

### Installed programs:
* catchsegv, Can bu used to creat a stack trace when a program terminates with
  segmentation fault
* gencat, Generates message catalogues
* getconf, Displays the system configuration values for file system specific
  variables
* getent, Gets entries from an administrative database
* iconv, Performs character set conversion
* iconvconfig, Creates fastloading iconv module configuration files
* ldconfig, Configures the dynamic linker runtime bindings
* ldd, Reports which shared libraries are required by each given program or
  shared library
* lddlibc4, Assists ldd with object files
* locale, Prints various information about the current locale
* localedef, Compiles local specifications
* makedb, Creats a simple database from textual input
* mtrace, Reads and interprets a memory trace file and displays a summary in
  human-readable format
* nscd, A daemon that provides a cache for the most common name service requests
* pcprofiledump, Dump infomation generated by PC profiling
* pldd, Lists dynamic shared objects used by running processes
* sln, A statically linked ln program
* sotruss, Traces shared library procedure calls of a specified command
* sprof, Reads and displays shared object profiling data
* tzselect, Asks the user about the location of the system and reports the
  corresponding time zone description
* xtrace, Traces the execution of a program by printing the currently executed
  function
* zdump, The time zone dumper
* zic, The time zone compiler

### Installed libraries:
* ld-2.32.so, The helper program for shared library executables
* libBrokenLocale, Used internally by Glibc as a gross hack to get broken
  programs (e.g., some Motif applications) running. See comments in
  *glibc-2.32/locale/broken\_cur\_max.c* for more information.
* libSegFault, The segmentation fault signal handler, used by catchsegv
* libanl, An asynchronous name look up library
* libc, The main C library
* libcrypt, The cryptography library
* libdl, The dynamic link interface library
* libg, Dummy library containing no functions. Previously was a runtime library
  for g++
* libm, The mathmatical library
* libmcheck, Turns on memory allocation checking when linked to
* libmemusage, Used by memusage to help collect information about the memory
  usage of a program
* libnsl, The network service library
* libnss, The Name Service Switch libraries, containing functions for resolving
  host names, users names, group names, aliases, services, protocols, etc
* libpcprofile, Can be preloaded to PC profile an executable
* libpthread, The POSIX threads library
* libresolv, Contains functions for creating, sending, and interpreting packets
  to the Internet domain name servers
* librt, Contains functions providing most of the interfaces specified by the
  POSIX.1b Realtime Extension
* libthread\_db, Contains functions useful for building debuggers for
  multi-thread programs
* libutil, Contains code for "standard" functions used in many different Unix
  utilities

## Section 8.9 Zlib
The Zlib package contains compression and decompression routines used by some
programs.

### Installed libraries:
* libz.{a,so}, Contains compression and decompression functions used by some
  programs.

## Section 8.10 Bzip2
The Bzip2 package contains programs for compressing and decompressing files.
Compressing text files with bzip2 yields a much better compression percentage
than with the traditional gzip.

### Installed programs:
* bunzip2 (link to bzip2), Decompresses bzipped files
* bzcat (link to bzip2), Decompresses to standard output
* bzcmp (link to bzipdiff), Runs cmp on bzipped files
* bzdiff, Runs diff on bzipped files
* bzegrep (link to bzgrep), Runs egrep on bzipped files
* bzfgrep (link to bzgrep), Runs fgrep on bzipped files
* bzgrep, Runs grep on bzipped files
* bzip2, Compresses files using the Burrows-Wheeler block sorting text
  compression algorithm with Huffman coding; the compression rate is better than
  achieved by more conventional compressors using "Lempel-Ziv" algorithms, like
  gzip
* bzip2recover, Tries to recover data from damaged bzipped files
* bzless (link to bzmore), Runs less on bzipped files
* bzmore, Runs more on bzipped files

### Installed libraries:
* libbz2.{a,so}, The library implementing lossless, block-sorting data compression,
  using the Burrows-Wheeler algorithm

### Installed direcroty:
* /usr/share/doc/bzip2-1.0.8

## Section 8.11 Xz
The Xz package contains programs for compressing and decompressing files.

It provides capabilities for the lzma and the newer xz compression formats.

Compression text filew with xz yields a better compression percentage than with
traditional gzip or bzip2 commands.

### Installed programs:
* lzcat, Decompresses to standard output
* lzcmp, Runs *cmp* on LZMA compressed files
* lzdiff, Runs *diff* on LZMA compressed files
* lzegrep, Runs *egrep* on LZMA compressed files
* lzfgrep, Runs *fgrep* on LZMA compressed files
* lzgrep, Runs *grep* on LZMA compressed files
* lzless, Runs *less* on LZMA compressed files
* lzma, Compresses or decompresses files using the LZMA format
* lzmadec, A small and fast decoder for LZMA compressed files
* lzmainfo, Shows information stored in the LZMA compressed file header
* lzmore, Runs more on LZMA compressed file header
* unlzma, Decompresses files using the LZMA format
* unxz, Decompresses files using the XZ format
* xz, Compresses or decompresses files using the XZ format
* xzcat, Decompresses to standard output
* xzcmp, Runs *cmp* on XZ compressed files
* xzdec, A small and fast decoder for XZ compressed files
* xzdiff, Runs *diff* on XZ compressed files
* xzegrep, Runs *egrep* on XZ compressed files
* xzfgrep, Runs *fgrep* on XZ compressed files
* xzgrep, Runs *grep* on XZ compressed files
* xzless, Runs *less* on XZ compressed files
* xzmore, Runs *more* on XZ compressed files

### Installed libraries:
* liblzma, The library implementing lossess, block-sorting data compression,
  using the Lempel-Ziv-Markov chain algorithm

### Installed directories:
* /usr/include/lzma
* /usr/share/doc/xz-5.2.5

## Section 8.12 Zstd
Zstandard is a real-time compression algorithm, providing high compression
ratios. It offers a very wide range of compression / speed trade-offs, while
being backed by a very fast decoder.

### Installed programs:
* zstd, Compresses or decompresses files using the ZSTD format
* zstdgrep, Runs *grep* on ZSTD compressed files
* zstdless, Runs *less* on ZSTD compressed files

### Installed library:
* libzstd, The library implementing lossless data compression, using the ZSTD
  algorithm.

## Section 5.39 File
The File package contains a utility for determining the type of a given file or
files.

### Installed programs:
* file, Tries to classify each given file; it does this by performing several
  tests -- file system tests, magic number tests, and language tests

### Installed library:
* libmagic, Contains routines for magic number recognition, used by the file
  program

## Section 8.14 Readline
The Readline package is a set of libraries that offers command-line editing and
history capabilities.

### The meaning of the configure options
```bash
--with-curses
```
Tells Readline that it can find the termcap library functions in the curses
library, rather than a separate termcap library. It allows generating a correct
*readline.pc* file

### The meaning of make option:
```bash
SHLIB_LIBS="-lncursesw"
```
Forces Readline to link against the *libncursesw* library.

### Installed libraries:
* libhistory.so, Provides a consitent user interface for recalling lines of
  history
* libreadline.so, Provides a set of commands for manipulating text entered in an
  interactive session

### Installed directories:
* /usr/include/readline
* /usr/share/doc/readline-8.0

## Section 8.15 M4
The M4 package contains a macro processor.

### Installed program:
* m4, Copies the given files while expanding the macros that they contain. These
  macros are either built-in or user-defined and can take any number of
  arguments. Besides performing macro expansion, m4 has built-in functions for
  including named files, running Unix commands, performing integer arithmetic,
  manuipulating text, recursioni, etc. The m4 program can be used either as a
  front-end to a compiler or as a macro processor in its own right.

## Section 8.16 Bc
The Bc package contains an arbitrary precision numeric processing language.

### The meaning of the configure options
```bash
CC=gcc CFLAGS="-std=c99" ./configure.sh -G -O3
```
These parameters specify the compiler and the C standard to use.
```bash
-O3
```
Specify the optimization to use.
```bash
-G
```
Omit parts of the test suite that won't work without a GNU bc present.

### Installed programs:
* bc, A command line calculator
* dc, A reserve-polish command line calculator

## Section 8.17 Flex
The Flex package contains a utility for generating programs that recognize
patterns in text.

### Installed programs:
* flex, A tool for generating programs that recognize patterns in text; it
  allows for the versatility to specify the rules for pattern-finding,
  eradicating the need to develop a specialized program
* flex++ (link to flex), An extension of flex, is used for generating C++ code
  and classes. It is a symbolic link to flex
* lex (link to flex), A symbolic that runs flex in lex emulation mode

### Installed libraries:
* libfl.so, The flex library

### Installed directory:
* /usr/share/doc/flex-2.6.4

## Section 8.18 Binutils
The Binutils package contains a linker, an assembler, and other tools for
handling object files.

### The meaning of the configure options
```bash
--enable-gold
```
Build the gold linker and install it as ld.gold (along side the default linker).
```bash
--enable-ld=default
```
Build the original bfd linker and install it as both ld (the default linker) and
ld.bfd.
```bash
--enable-plugins
```
Enables plugin support for the linker.
```bash
--enable-64-bit-bfd
```
Enables 64-bit support (on hosts with narrower word sizes). May not be needed on
64-bit systems, but does no harm.
```bash
--with-system-zlib
```
Use the installed zlib library rather than building the included version.

### The meaning of the make parameter:
```bash
tooldir=/usr
```
Normally, the tooldir (the directory where the executables will ultimately be
located) is set to *$(exec_prefix)/$(target_alias)*. For example, x86\_64
machines would expand that to */usr/x86_64-unknown-linux-gnu*. Because this is a
custom system, this target-specific directory in */usr* is not required.

*$(exec_prefix)/$(target_alias)* would be used if the system was used to
cross-compile (for example, compiling a package on an Intel machine that
genetates code that can be executed on PowerPC machines).

### Installed programs:
* addr2line, Translates program addresses to file names and file numbers; given
  an address and the name of an executable, it uses the debugging information in
  the executable to determine which source file and line number are associated
  with the address
* ar, Creates, modifies, and extracts from archives
* as, An assembler that assembles the output of gcc into object files
* c++filt, Used by the linker to de-manage C++ and Java symbols and to keep
  overloaded functions from clashing
* dwp, The DWARF packaging utility
* elfedit, Updates the ELF header of ELF files
* gprof, Displays call graph profile data
* ld, A linker that combines a number of object and archive files into a string
  file, relocating their data and tying up symbol references
* ld.gold, A cut down version of ld that only supports the elf object file
  format
* ld.bfd, Hard link to ld
* nm, Lists the symbols occuring in a given object file

### Installed libraries:
* libbfd.{a,so}, The Binary File Descriptor library
* libctf.{a,so}, The Compat ANSI-C Type Format debugging support library
* libctf-nobfd.{a,so}, A libctf variant which does not use libbfd functionality
* libopcodes.{a,so}, A library for dealing with opcodes -- the "readable text"
  versions of instructions for the processor; it is used for building utilities
  like *objdump*

### Installed directory:
* /usr/lib/ldscripts

## 8.19 GMP
The GMP package contains math libraries. These have useful functions for
arbitrary precision arithmetic.

### The meaning of the new configure options
```bash
--enable-cxx
```
Enables C++ support
```bash
--docdir=/usr/share/doc/gmp-6.2.0
```
Specifies the correct place for the documentation.

### Use tee and awk
```bash
make check 2>&1 | tee gmp-check-log
awk '/# PASS:/{total += 3}; END {print total}' gmp-check-log
```

### Installed Libraries
1. libgmp.so, Contains precision math functions
2. libgmpxx.so, Contains C++ precision math functions.

### Installed directory
1. /usr/share/doc/gmp-6.2.0

## 8.20 MPFR
The MPFR package contains functions for multiple precision math.

### Installed Libraries
1. libmpfr.so, Contains multiple-precision math functions.

### Installed Directory
1. /usr/share/doc/mpfr-4.1.0

## 8.21 MPC
The MPC package contains a library for the arithmetic of complex numbers with
arbitrarily high precision and correct rounding of the result.

### Installed Libraries
1. libmpc.so, Contains complex math functions.

### Installed Directory
1. /usr/share/doc/mpc-1.1.0

## 8.22 Attr
The attr package contains utilities to administer the extended attributes on
filesystem objects.

### Installed programs
1. attr, Extends attributes on filesystem objects
2. getfattr, Gets the extended attributes of filesystem objects
3. setfattr, Sets the extended attributes of filesystem objects

### Installed Libraries
1. libattr.so, Contains the library functions for manipulating extended
attributes

### Installed Directories
1. /usr/include/attr
2. /usr/share/doc/attr-2.4.48

## 8.23 Acl
The acl package contains utilities to administer Access Control List, which are
used to define more fine-grained discretionary access rights for files and
directories.

### Installed programs
1. chacl, Changes the access control list of a file or directory
2. getfacl, Gets the access control lists
3. setfacl, Sets the access control lists

### Installed Librariy
1. libacl.so, Contains the library functions for manipulating Access Control
   Lists

### Installed directories
1. /usr/include/acl
2. /usr/share/doc/acl-2.2.53

## 8.24 Libcap
The libcap package implements the user-space interfaces to the POSIX 1003.1e
capabilities available in Linux kernels. These capabilities are a partitioning
of the all powerful root privilege into a set of distinct privileges.

### The meaning of the make option:
```bash
make lib=lib
```
Sets the library directory to /lib rather than /lib64 on x86\_64. It has no
effect on x86.

### Installed Programs
1. capsh, A shell wrapper to explore and constrain capability support
2. getcap, Examines file capabilities
3. getpcaps, Displays the capabilities on the queired process(es)
4. setcap, Sets file capabilities

### Installed Libraries
1. libcap.so, Contains the library functions for manipulating POSIX 1003.1e
   capabilities
2. libpsx.a, Contains functions to support POSIX semantics for syscalls
   associated with the pthread library

## 8.25 Shadow
The shadow package contains programs for handling passwords in a secure way.

### find usage
```bash
find man/ -name Makefile.in -exec sec -i 's/groups\.1 / /' {} \;
```
### The meaning of the configure option:
```bash
touch /usr/bin/passwd
```
The file /usr/bin/passwd needs to exist because its location is hardcoded in
some programs, and default location if it does not exist is not right.
```bash
--with-group-name-max-length=32
```
The maximum user name is 32 characters. Make the maximum group name the same.

### Configuring Shadow
This package contains utilities to add,
1. modify, and delete users and groups;
2. set and change their passwords;
3. and perform other adminstratrative tasks.

For a full explanation of what password shadowing means, see the *doc/HOWTO*
file within the unpacked source tree.

If using Shadown support, programs which need to verify passwords (display
managers, FTP programs, pop3 daemons, etc) must be Shadow-complaint. That is,
they need to be able to work with shadowed passwords.

To enable shadowed password;

To enable shadowed group password;

Shadow's stock configuration for the **useradd** utility:
1. Create the user and a group of the same name as the uer.
2. The default parameters are stored in the /etc/default/useradd file.

### Installed programs:
1. chage, Change the maximum number of days between obligatory password
   changes.
2. chfn, Change a user's full name and other information
3. chgpasswd, Update group passwords in batch mode
4. chsh, Change a user's default login shell
5. expiry, Checks and enforces the current password expiration policy
6. faillog, Examine the log of login failures, to set a maximum number of
   failures before an account is blocked, or to reset the failure count.
7. gpasswd, Add and delete members and administrators to groups
8. groupadd, Creates a group with the given name
9. groupdel, Deletes the group with the given name
10. groupmems, Allows a user to administer his/her own group membership list
    without the requirement of super user privileges
11. groupmod, Modify the given group's name or GID
12. grpck, Verifies the integrity of the group files /etc/group and /etc/gshadow
13. grpunconv, Updates /etc/group from /etc/gshadow and then deletes the latter
14. lastlog, Reports the most recent login of all users or a given user
15. login, Is used by the stream to let users sign on
16. logoutd, Is a daemon used to enforece restrictions on log-on time and ports
17. newgidmap, Is used to set the gid mapping of a user namespace
18. newgrp, Is used to change the current GID during a login session
19. newuidmap, Is used to set the uid mapping of a user namespace
20. newusers, Is used to create or update an entire series of user accounts
21. nologin, Displays a message that an account is not available; it is designed
    to be used as the default shell for accounts that have been disabled.
22. passwd, Is used to change the passwd for a user or group account
23. pwck, Verifies the integrity of the password file /etc/passwd and
    /etc/shadow
24. pwconv, Creates or updates the shadow password file from the normal password
    file.
25. pwunconv, Updates /etc/passwd from /etc/shadow and then deletes the later.
26. Executes a given command while the user's GID is set to that of the givn
    group.
27. su, Run a shell with suitable user and group IDs.
28. useradd, Creates a new user with the given name, or updates the default
    new-user information.
29. userdel, Deletes the given user account
30. usermod, Is used to modify the given user's login name, User Identification
    (UID), shell, initial group, home directory, etc.
31. vigr, Edits the /etc/group or /etc/shadow files.
32. vipw, Edits the /etc/group or /etc/shadow files.

## 8.26 GCC
The GCC package contains the GNU Compiler Collection, which includes the C and
C++ compilers.

### The meaning of the new configure options
```bash
LD=ld
```
Makes the configure script use the ld installed by the binutils earlier in this
chapter, rather than the cross-built version which would otherwise be used.
```bash
--with-system-zlib
```
Tells GCC to link to the system installed copy of the zlib library, rather than
its own internal copy.

### grep usage
```bash
grep -A7  Summ
```
-A NUM, --after-context=NUM: Print NUM lines of trailing context after matching
lines. Places a line containing a group separator (--) between contiguous groups
of matches. With the -o or --only-matching option, this has no effect and a
warning is given.

### Installed Programs
1. c++, g++, cc (link to gcc), gcc
2. cpp, The C preprocessor; it is used by the compiler to expand the #include,
   \#defiine, and similar statements in the source files
