# Section 8.14 Readline

The Readline package is a set of libraries that offers command-line editing and
history capabilities.

## Configure Arguments
```bash
--with-curses
```
Tells Readline that it can find the termcap library functions in the curses
library, rather than a separate termcap library. It allows generating a correct
*readline.pc* file

The meaning of make option:
```bash
SHLIB_LIBS="-lncursesw"
```
Forces Readline to link against the *libncursesw* library.

## Contents of Readline
Installed libraries:
* libhistory.so, Provides a consitent user interface for recalling lines of
  history
* libreadline.so, Provides a set of commands for manipulating text entered in an
  interactive session

Installed directories:
* /usr/include/readline
* /usr/share/doc/readline-8.0
