# Section 6.12 Make

The Make package contains a program for controlling the generation of
executables and other non-source files of a package from source files.

## Configuration Arguments
```bash
--without-guile
```
Although we are cross-compiling, configure tries to use guile from the build
host if it finds it. This makes compilation fails, so this switch prevents using
it.
