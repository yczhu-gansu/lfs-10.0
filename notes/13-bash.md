# Section 6.4

The Bash package contains the Bourne-Again SHell.

## Configure Arguments
```bash
--without-hash-malloc
```
Turns off the use of Bash's memory allocation (malloc) function which is know to
cause segmentation faults. By turning this option off, Bash will use the
*malloc* function from Glibc which are more stable.
