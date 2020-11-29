# LFS-10.0

Learning Linux From Scratch

Build LFS-10.0 on Debian Buster ([Installed with
LiveCD](https://mirrors.tuna.tsinghua.edu.cn/debian-cd/10.6.0-live/amd64/iso-hybrid/debian-live-10.6.0-amd64-mate.iso))

## 0. Getting Started

0. [Motivation](./notes/00-motivation.md)
1. [Some Basic Knowledge](./notes/01-basic-knowledge.md)
2. [Rationale for Packages in the Book](./notes/02-package-rational.md)
3. [How to Build an LFS System](./notes/03-how-to-build-lfs.md)
4. [Resources](./notes/04-resources.md)

## 1. Preparation for the Build

1. [Host System Requirement](./notes/05-host-system-require.md)
2. [Building LFS in Stages](./notes/06-stages.md)
2. [Creating a New Partitions](./notes/07-partitions.md)
3. [Set up Working Environment](./notes/08-setup-work-env.md)
4. [Packages and Patches](./notes/09-packages.md)
5. [Temporary System Environment](./notes/10-tmp-sys-env.md)

## 2. Building the LFS Cross Toolchain and Temporary Tools

1. [Important Preliminary Material](./notes/11-preliminary.md)
2. [Compiling a Cross-Toolchain](./notes/12-cpil-cross-toolchain.md)
3. [Cross Compiling Temporary Tools](./notes/13-cross-cpil-tmp-tools.md)
4. [Enter Chroot](./notes/14-enter-chroot.md)
5. [Creating Directories and Essential Files](./notes/15-dirs-files.md)
6. [Additional Temporary Tools](./notes/16-addi-tools.md)
7. [Cleaning up and Saving the Temporary System](./notes/17-clean-save-temp-sys.md)

## 3. Building the LFS system

1. [Preparation](./notes/18-build-lfs-sys.md)
2. [Basic System Software](./notes/19-basic-soft.md)

## 4. System Configuration

1. [Introduction](./notes/20-intr-sys-boot.md)
2. [Device and Module Handling](./notes/21-device-module.md)
3. [Managing Devices](./notes/22-manage-device.md)
4. [Network Configuration](./notes/23-network-config.md)
5. [System V Bootscript Usage and Configuration](./notes/24-bootscript.md)
6. [The Bash Shell Startup Files](./notes/25-shell-startup.md)
7. [Creating the /etc/inputrc File](./notes/26-etc-inputrc.md)
8. [Creating the /etc/shells File](./notes/27-etc-shells.md)

## 5. Making the LFS System Bootable

1. [Boot LFS](./notes/28-boot-lfs.md)
2. [GRUB](./notes/29-grub.md)

## Questions

1. Are there any difference between "configure --prefix=/usr/" and "configure
   --prefix=/usr"?
2. Describe cross-compiler?
3. Bash hash?
4. Describe GRUB?
