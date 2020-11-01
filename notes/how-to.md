# How to Build a LFS System

An existing Linux system (host) will be used as a starting point to provide
necessary programs, including:
* compiler;
* linker;
* shell
to build the new system.

You can use a LiveCD from a commercial distribution.

## Chapter 2
Describes how to create a new Linux native partition and file system. This is
the place where the new LFS system will be compiled and installed.

## Chapter 3
Explains which packages and patches need to be downloaded to build an LFS system
and how to store them on the new file system.

## Chapter 4
Discusses the set up of an appropriate working environment.In this chapter,
explains several important issues you need to be aware of before beginning to
work your way through Chapter 5 and beyond.

## Chapter 5
Explains the installation of the initial tool chain, (binutils, gcc, and glibc)
using cross compilation techniques to isolate the new tools from the host
system.

## Chapter 6
How to cross-compile basic utilities using the just built cross-toolchain.

## Chapter 7
Enter the "chroot" environment and uses the previously built tools to build the
additional tools needed to build and test the final system.

## Chapter 8
The full LFS system is built. Another advantage provided by the chroot
environment is that it allows you to continue using the host system while LFS is
being built.

## Chapter 9
To finish the installation, the basic system configuration is set up in this
chapter.

## Chapter 10
The kernel and boot loader are set up.

## Chapter 11
Contains information on continuing the LFS experience beyong this book

After the steps in this book have been implemented, the computer will be ready
to reboot into the new LFS system.
