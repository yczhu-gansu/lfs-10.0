# Section 7.14 Cleaning up and Saving the Temporary System

## libtool .la files
The libtool .la files are only useful when linking with static libraries. They
are unneeded, and potentially harmful, when using dynamic shared libraries,
specially when using non-autotools build systems. While still in chroot, remove
those files.

As soon as you begin installing packages in Chapter 8, the temporary tools will
be overwritten. So backup the temporary tools as described below.

The following steps are performed outside the chroot environment. The reason for
that is:
1. make sure that objects are not in use while they are manipulated;
2. get access to file system locations outside of the chroot environment to
store/read the backup archive which should not be placed within the $LFS
hierarchy for safety reasons.

## Leaving chroot environment
Leave the chroot environment and unmount the kernel virtual file systems. All of
the following instructions are executed by root.

## Striping
Unnecessary items can be removed. The executables and libraries built so far
contain a little over 90 MB of unneeded debugging symbols.

Strip off debugging symbols from binaries:
```bash
strip --strip-debug $LFS/usr/lib/*
strip --strip-unneeded $LFS/usr/{,s}bin/*
strip --strip-unneeded $LFS/tools/bin/*
```

## Backup
Now that the essential tools have been created, its time to think about a
backup.

Your temporary tools are in a good state and might be backed up for later reuse.

## Restore
In case some mistakes have been made and you need to start over.

Since the sources are located under $LFS, they are included in the backup
archive as well.

After checking that $LFS is set properly, restore the backup by executing the
following commands:
```bash
cd $LFS &&
rm -rf ./* &&
tar -xpf $HOME/lfs-tmp-tools-10.0.tar.xz
```

