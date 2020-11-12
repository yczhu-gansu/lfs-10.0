# Introduction and Package management

## Chapter 8 Installing Basic System Software
### 8.1 Introduction
In this chapter, we start constructing the LFS system in earnest.

We have opted to provide the full installation instructions for every package.

The key to learning what makes a Linux system work is to know what each package
is used for and why you (or the system) may need it.

First-time builders of LFS are encouraged to build without custom optimizations.

#### 8.1.1 About libraries
Ingeneral, LFS editors discourage building and installing static libraries. The
original purpose for most static libraries has been made obsolete in a modern
Linux syste.

In the procedures in this chapter, we remove or disable installation of most
static libraries. Usually this is done by passing a *--disable-static* option to
**configure**.

In a few cases, especially glibc and gcc, the use of static libraries is
essential to the general package building process.

### 8.2 Package Management
A package manager allows tracking the installation of files making it easy to
remove and upgrade packages. As well as the binary and library files, a package
manager will handle the installation configuration files.

This section will not talk about nor recommend any particular package manager.

#### 8.2.1 Upgrade Issues
Generally the instructions in the LFS and BLFS book can be used to upgrade to
the newer versions. Here are some points that you should be aware of when
upgrading packages, especially on a running system.
* If Glibc needs to be upgraded to a newer version (e.g. from glibc-2.31 to
  glibc-2.32), it is safer to rebuild LFS. Though you man be able to rebuild all
  the packages in their dependency order, we do not recommend it.
* If a package containing a shared library is updated, and if the name of the
  library changes, then any the packages dynamically linked to the library need
  to be recompiled in order to link against the newer library. (Note that there
  is no correlation between the package version and the name of the library.)

#### 8.2.2 Package Management Techniques
The following are some common package management techniques.

Do some research on the various techniques, particularly the drawbacks of the
particular scheme.

##### 8.2.2.1 It is All in My Head!
1. You know the package intimately, and know what files are installed by each package.
2. You plan on rebuilding the entire system when a package is changed.

#### 8.2.2.2 Install in Separate Directories

### 8.2.3 Deploying LFS on Multiple Systems
There are no files that depend on the position of files on a disk system.

Cloning an LFS build to another computer with the same architecture as the base
system is as simple as using **tar** on the LFS partition that contains the root
directory (about 250 MB uncompressed for a base LFS build).

From that point, a few configuration files will have to be changed.
Configuration files that may need to be updated include:
* /etc/hosts
* /ets/fstab
* /etc/passwd
* /etc/group
* /etc/shadow
* /etc/ld.so.conf
* /etc/sysconfig/rc.site
* /etc/sysconfig/network
* /etc/sysconfig/ifconfig.eth0

A custom kernel may need to be built for the new system depending on differences
in system hardware and the original kernel configuration.

Finally the new system has to be made bootable via Section 10.4
