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
