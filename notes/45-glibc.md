# Section 8.8 Glibc

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

## Configure Arguments
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

## Locales
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

## Configuring Glibc
### Adding nsswitch.conf
The /etc/nsswitch.conf file needs to be created because the Glibc defaults do
not work well in a networked environment.

### Adding time zone data
```bash
tar -xf ../../tzdata2020a.tar.gz
```

The meaning of the zic commands:
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

## Contents of Glibc
Installed programs:
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
