# 10.4 Using GRUB to Set Up the Boot Process

## 10.4.2 GRUB Naming Conventions

GRUB uses its own naming structure for drives and partitions in the form of
*(hdn, m)*, where n is the hard drive number and the m is the partition number.
1. The hard drive number starts from zero,
2. but the partition number starts from one for normal partitions
3. and five for extended partitions.

This is different from earlier versions where both numbers started from zero. In
contrast to Linux, GRUB does not consider CD-ROM drives to be hard drives.

## 10.4.2 Setting Up the Configuration

GRUB works by writing data to the first physical track of the hard disk. This
area is not part of any file system. The programs there access GRUB modules in
the boot partition. The default location is /boot/grub.

The location of the boot partition is the choice of the user that affects the
configuration. One recommendation is to have a separate small (suggested size is
200 MB) partition just for boot information. That way each build, whether LFS or
some commercial distro, can access the same boot files and access can be made
from any booted system.
