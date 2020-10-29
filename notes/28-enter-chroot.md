# Section 7 Entering Chroot and Building Additional Temporary Tools

## Section 7.1 Introduction
How to build the last missing bits of the temporary system.
1. The tools needed by the build machinery of various packages.
2. Then three packages needed to tests.

For proper operation of the isolated environment, some communication with the
running kernel must be established. This is done through the so-called Virtual
Kernel File Systems, which must be mounted when entering the chroot environment.
You man want to check that they are mounted by issuing *findmnt*

## Section 7.3 Preparing Virtual Kernel File Systems
Various file systems exported by the kernel are used to communicate to and from
the kernel itself. These file systems are virtual in that no disk space is used
for them. The content of the file systems resides in memory.

When the kernel boots the system, it requires the presence of a few device
nodes, in particular the *console* and *null* devices. The device nodes must be
created on the hard disk so that they are available before the kernel populates
*/dev*, and additionally when Linux is started with *init=/bin/bash*

The recommended method of populating the */dev* directory with devices is to
mount a virtual filesystem (such as *tmpfs*) on the */dev* directory, and allow
the devices to be created dynamically on that virtual filesystem as they are
detected or accessed.

Device creation is generally done during the boot process by Udev. Since this
new system does not yet have Udev and has not yet been booted, it is necessary
to mount and populate */dev* manually. This is done by bind mounting the host
system's */dev* directory.

A bind mount is a special type of mount that allows you to create a mirror of a
directory or mount point to some other location.

## Entering the Chroot Environment
As user root, run the following command to enter the environment that is, at the
moment, populated with only temporary tools:
```bash
# chroot "$LFS" /usr/bin/env -i HOME=/root TERM="$TERM" \
	PS1='(lfs chroot) # \u:\w\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin \
	/bin/bash --login +h
```
The -i option given to the env command will clear all variables of the chroot
environment. After that, only the HOME, TERM, PS1, and PATH variables are set
again.

The *TERM=$TERM* construct will set the *TERM* variable inside chroot to the
same value as outside chroot. This variable is needed for programs like *vim*
and *less* to operate properly.

The Bash shell is told that $LFS is now the root(/) directory.

Notice that /tools/bin is not in the PATH. This means that cross toolchain will
no longer be used in the chroot environment.

The bash prompt will say *I have no name!*, this is normal because the
/etc/passwd file has not been created yet.

**If you leave this environment for any reason (rebooting for example), ensure
that virtual kernel filesystems are mounted as explained in
1. Section 7.3.2
2. Section 7.3.3
And enter chroot again before continuing with the installation.**
