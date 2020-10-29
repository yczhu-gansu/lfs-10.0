# Section 5.2 Binutils-2.35 - Pass 1

Both Glibc and GCC perform various tests on the available linker and assembler
to determine which of their own features to enable.
```
--prefix=$LFS/tools
```
This tells the configure script to prepare to install the binutils programs in
the $LFS/tools directory.
```
--with-sysroot=$LFS
For cross compilation, this tells the build system to look in $LFS for the
target system libraries as needed.
```
--target=$LFS\_TGT
```
Because the machine description in the LFS\_TGT variable is slightly different
than the value returned by the *config.guess* script, this switch will tell the
*configure* script to adjust binutils's build system for building a cross
linker.
```
--disable-nls
```
This disables internationalization as i18n is not needed for the temporary
tools.
```
--disable-werror
```
This prevents the build from stopping in the event that there are warnings from
the host's compiler.
