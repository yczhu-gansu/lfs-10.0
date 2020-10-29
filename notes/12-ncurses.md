# Section 6.3 Ncurses

The Ncurses package contains libraries for terminal-independent handling of
character screens.

## Configuration Arguments
```bash
--with-manpage-format=normal
```
Prevents Ncurses installing compressed manual pages, which may happen if the
host distribution itself has compressed manual pages.
```bash
--without-ada
```
Ensures that Ncurses does not build support for the Ada compiler which may be
present on the host but will not be available once we enter the chroot
environment.
```bash
--enable-widec
```
Causes wide-character libraries (e.g., libncursesw.so.6.2) to be built instead
of normal ones (e.g., libncurses.so.6.2). These wide-character libraries are
usable in both multitype and traditional 8-bit locales, while normal libraries
work properly only in 8-bit locales. Wide-character and normal libraries are
source-compatible, but not binary-compatible.
```bash
--without-normal
```
This switch disables building and installing most static libraries.
