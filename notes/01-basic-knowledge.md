# Some Basic Knowledge

## LFS Target Architectures
The primary target architectures of LFS are the AMD/Intel x86 (32-bit) and
x86\_64 (64-bit) CPUs.

The instructions in this book are also known to work, with some modifications,
with the Power PC and ARM CPUs. To build a system that utilizes one of these
CUPs, the main prerequisite, is an existing Linux system targets the
architecture that you have.

A 32-bit distribution can be installed and used as a host system on a 64-bit
AMD/Intel computer.

For building LFS, the gain of building on a 64-bit system compared to a 32-bit
system is minimal. On the same hardware, the 64-bit build is only 3% faster and
is 22% larger than the 32-bit build. If you plan to use LFS as a LAMP (Linux,
Apache, MySQL, PHP) server, or
a firewall, a 32-bit CPU may be largely sufficient. On the other hand, several
packages in BLFS now need more than 4GB of RAM to be built and/or to run, so
that if you plan to use LFS as a desktop, the LFS authors recommend building on
a 64-bit system.

Building a "multi-lib" systems requires compiling many applications twice, once
for a 32-bit system and once for a 64-bit system. Some LFS/BLFS editors maintain
a fork of
[LFS for multilib](http://www.linuxfromscratch.org/~thomas/multilib/index.html),
this is an advanced topic.

## Prerequisites
It requires a certain level of existing knowledge of Unix system administration
in order to resolve problems and correctly execute the commands listed.

* [Software-Building-HOWTO](https://tldp.org/HOWTO/Software-Building-HOWTO.html)
  This is a comprehensive guide to building and installing "generic" Unix software
  packages under Linux. Although it was written some time ago, it still provides a
  good summary of the basic techniques needed to build and install software.
* [Beginner's Guide to Installing from Source](http://moi.vonos.net/linux/beginners-installing-from-source/)
  This guide provides a good summary of basic skills and techniques needed to
  build software from source code.

## LFS and Standards
The structure of LFS follows Linux standards as closely as possible. The primary
standards are:
* [POSIX.1-2008](http://pubs.opengroup.org/onlinepubs/9699919799/)
* [FHS Version 3.0](http://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
* [LSB Version 5.0](http://refspecs.linuxfoundation.org/lsb.shtml)

The LSB has four separate standards:
1. Core
1. Desktop
1. Runtime Languages
1. Imaging

In addition to generic requirements there are also architecture specific
requirements. There are also two areas for trial use:
1. Gtk3
1. Graphics

LFS attempts to conform to the architectures discussed in the previous section.

### Packages supplied by LFS needed to satifsy the LSB Requirements
* LSB Core: Bash, Bc, Binutils, Coreutils, Diffutils, File, Findutils, Gawk,
  Grep, Gzip, M4, Man-DB, Ncurses, Procps, Psmic, Sed, Shadow, Tar, Util-linux,
  Zlib
* LSB Desktop: None
* LSB Runtime Languages: Perl
* LSB Imaging: None
* LSB Gtk3 and LSB Graphics (Trial Use): None

### Packages supplied by BLFS needed to satisfy the LSB Requirements
* LSB Core: At, Batch (a part of At), Cpio, Ed, Fcrontab, LSB-Tools, NSPR, NSS,
  PAM, Pax, Sendmail (or Postfix on Exim), time
* LSB Desktop: Alsa, ATK, Cairo, Desktop-file-utils, Freetype, Fontconfig,
  Gdk-pixbuf, Glib2, GTK+2, Icon-naming-utils, Libjpeg-turo, Lipng, Libtiff,
  Libxml2, MesaLib, Pango, Xdg-utils, Xorg
* LSB Runtime Languages: Python, Libxml2, Libxlt
* LSB Imaging: CUPS, Cups-filters, Ghostscript, SANE
* LSB Gtk3 and LSB Graphics (Trial Use): GTK+3

### Packages not supplied by LFS or BLFS needed to satifsy the LSB Requirements
* LSB Core: None
* LSB Desktop: Qt4 (but Qt5 is provided)
* LSB Runtime Languages: None
* LSB Imaging: None
* LSB Gtk3 and LSB Graphics (Trial Use): None
