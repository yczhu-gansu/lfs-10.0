# Section 5.6 Libstdc++ from GCC

Libstdc++ is the standard C++ library. It is needed to compile the C++ code
(part of GCC is written in C++), but we had to defer its installation when we
built gcc-pass1 because it depends on glibc, which was not yet available in the
target directory.

# Configure Arguments
```bash
--host=...
```
Specifies the use the cross compiler we have just built instead of the one in
/usr/bin.
```bash
--disable-libstdcxx-pch
```
Prevents the installation of precompiled include files, which are not needed at
this stage.
```bash
--with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0
```
This is the location where the C++ compiler should search for the standard
include files. In a normal build, this information is automatically passed to
the libstdc++ configure options from the top level directory. In our case, this
information must be explicitly given.
