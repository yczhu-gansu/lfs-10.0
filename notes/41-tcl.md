# Section 8.4 Tcl

The Tcl package contains the Tool Command Language, a robust general-purpose
scripting language. The Expect package is written in the Tcl language.

The various "sed" instructions after the "make" command removes references to
the build directory from the configuration files and replaces them with the
install directory. This is not mandatory for the remainder of LFS, but may be
needed in case a package built later uses Tcl.

## Contents of Tcl
Installed programs:
* tclsh (link to tclsh8.6), A link to tclsh8.6
* tclsh8.6, The Tcl command shell

Installed library:
* libtcl8.6.so, The Tcl library
* libtclstub8.6.a, The Tcl Stub library
