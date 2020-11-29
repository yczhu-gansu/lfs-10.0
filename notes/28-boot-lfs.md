# Making the LFS System Bootable

## 10.1 Introduction

This chapter discusses:
1. creating the */etc/fstab* file;
2. building a kernel for the new LFS system;
3. installing the GRUB boot loader so that the LFS system can be selected for
   bootint at startup.

## 10.2 Creating the /etc/fstab File

The */etc/fstab* file is used by some programs to determine where file systems
are to be mounted by default, in which order, and which must be checked (for
integrity errors) prior to mounting.

My */etc/fstab* file:
```bash
# Begin /etc/fstab

# file system    mount-point    type    options    dump    fsck order
 
UUID="1248e248-e2e3-43f3-a0eb-263cd3ac1a4b"    /    ext4    defaults    1    1
UUID="d67ab98a-a33c-48dd-97c0-8f29595bc39c"    /boot    ext4    defaults    1 1
UUID="36343b27-f29f-4843-b560-fd7b13439195"    /opt    ext4    defaults    1 1
UUID="f8ee49ad-493b-4ee2-9803-cd33fc623241"    /home    ext4    defaults    1 1
PARTUUID="18c3472b-05"    swap    swap    pri=1    0    0
proc    /proc    proc    nosuid,noexec,nodev    0    0
sysfs    /sys    sysfs    nosuid,noexec,nodev    0    0
devpts    /dev/pts    devpts    gid=5,mode=620    0    0
tmpfs    /run    tmpfs    defaults    0    0
devtmpfs    /dev    devtmpfs    mode=0755,nosuid    0    0

# End /etc/fstab
```
For details on the six fields in this file, see **man 5 fstab**.

## 10.3 Linux-5.8.3

The Linux package contains the Linux kernel.

Steps of building the kernel:
1. configuration;
2. compilation;
3. installation.
```bash
make mrproper
```
This ensures that the kernel tree is absolutely clean. The kernel team
recommends that this command be issued prior to each kernel compilation. Do not
rely on the source tree being clean after un-taring.
```bash
make menuconfig
```
This launches an ncurses menu-driven interface. For other (graphical)
interfaces, type **make help**.

### 10.3.2 Configuring Linux Module Load Order

Most of the time Linux modules are loaded automatically, but sometimes it needs
some specific direction. The program that loads modules, **modprobe** or
**insmod**, uses */etc/modprobe.d/usb.conf* for this purpose.

This file needs to be created so that if the USB drivers (ehci\_hcd, ohci\_hcd
and uhci\_hcd) have been built as modules, they will be loaded in the correct;
ehci\_hcd needs to be loaded prior to ohci\_hcd and uhci\_hcd in order to avoid
a warning being output at boottime.

### 10.3.3 Installed files
1. config-5.8.3, Contains all the configuration selections for the kernel;
2. vmlinuz-5.8.3-lfs-10.0, The engine of the Linux system. When turning on the
   computer, the kernel is the first part of the operating system that gets tree
   of files to the software and turns a single CPU into a multitask machine
   capable of running scores of programs seemingly at the same time;
3. System.map-5.8.3, A list of addresses and symbols; it maps the entry points
   and addresses of all the functions and data structures in the kernel

### 10.3.3 Installed directories
1. /lib/modules
2. /usr/share/doc/linux-5.8.3
