# Section 2.4 Creating a New Partition
The Recommended approach to building an LFS system is to use an available empty
partition or, if you have enough unpartitioned space, to create one.

A minimal system requires a partition of around 10 gigabytes (GB) (Store all the
tarballs and compile the packages).

If the LFS system is intended to be the primary system, additional software will
probably be installed. A 30 GB partition is a reasonable size to provide for
growth.

Because there is not always enough Random Access Memory (RAM) available for
compilation, it is a good idea to use a small disk partition as *swap* space.
This is used by the kernel to store seldom-used data and leave more memory
available for active processes.

## The Root Partition
A root LFS partition (not to be confused with the /root directory) of 20 GB is a
good compromise for most systems. My 50 GB

## The Swap Partition
Generally the recommended size of the swap partition is about twice the amount
of the phycial RAM, howere this is rarely needed. My 4 GB

If you want to use the hibernation feature (suspend-to-disk) of Linux, it writes
out the contents of RAM to the swap partition before turning off the machine. In
this case the size of the swap partition should be at least as large as the
system's installed RAM.

## The Grup Bios Partition
If the boot disk has been partitioned with a GUID Partition Table (GPT), then a
small, typically 1 MB, partition must be created if it does not already exist.
This partition is not formated, but must be available for GRUB to use during
installation of the boot loader. This partition will normally be labeled 'BIOS
Boot' if using fdisk or have a code of EF02 if using gdisk.

The Grub Bios must be on the drive that the BIOS uses to boot the system.
This is not necessarily the same drive where the LFS root partition is located.
Disks on a system may use different partition table types. The requirement for
this partition depends only on the partition table type of the boot disk.

## Convenience Partitions:
There are several other partitions that are not required, but should be
considered when designing a disk layout.
1. /boot. Use this partition to store kernels and other information. To
   minimize potential boot problems with large disks, make this the first
   physical partition on your first disk drive. A partition size of 200 MB is
   quite adequate.
2. /home. Share your home directory and user customization across multiple
   distributions or LFS builds. The size is generally fairly large and
   depends on available disk space.
3. /opt, this directory is most useful for BLFS where multiple installations of
   large packages Gnome or KDE can be installed without embedding the files in
   the /usr hierarchy. If used, 5 to 10 GB is generally adequate.

Finally, my partitions (80 GB in total):
```bash
   /boot	sdb1	200 BM
   /		sdb2	50 GB
   /opt		sdb3	10 GB
			sdb4	extended
   swap		sdb5	4 GB		Will be used when LFS booted
   /home	sdb6	residuary GB
```
My partition type is "Linux"

# Section 2.5 Creating a File System on the Partition
**ext2** is suitable for small partitions that are updated infrequently such as
/root.

**ext3** is an upgrade to ext2 that includes a journal to help recover the
partition's status in the case of an unclean shutdown. It is commonly used as a
general purpose file system.

**ext4** Provides several new capabilities including nano-second timestamps,
creation and use of very large files (16 TB), and speed improvements.

1. To create an *ext4* file system on the LFS partition:
```bash
# mkfs -v -t ext4 /dev/<xxx>
```
2. If a new *swap* partition was created, it will need to be initialized with:
```bash
# mkswap /dev/<yyy>
```
