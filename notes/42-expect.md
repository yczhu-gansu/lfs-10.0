# Section 8.5 Expect

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

## Configure Arguments
```bash
--with-tcl=/usr/lib
```
This parameter is needed to tell configure where the tclConfig.sh script is
located.
```bash
--with-tclinclude=/usr/include
```
This explicitly tells Expect where to find Tcl's internal headers.

## Contents of Expect
Installed program:
* expect, Communicates with other interactive programs according to a script
Installed library:
* libexpect-5.45.so, Contains functions that allow Expect to be used as a Tcl
  extension or to be used directly from C or C++ (without Tcl).
