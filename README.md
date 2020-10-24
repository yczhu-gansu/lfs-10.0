# lfs-10.0
build lfs-10.0 on debian buster live

## Section 2.2 Host System Requirements
1. reconfigure dash:
```bash
	$ sudo sudo dpkg-reconfigure dash
```
2. install bison:
```bash
	$ sudo apt install bison
```
3. install gawk:
```bash
	$ sudo apt install gawk
```

## Section 2.4 Creating a New Partition
1. A root LFS partition (not to be confused with the /root directory) of 20 GB
   is a good compromise for most systems. My 50 GB
2. Generally the recommended size of the swap partition is about twice the
   amount of the phycial RAM, howere this is rarely needed. My 4 GB
3. If the boot disk has been partitioned with a GUID Partition Table (GPT),
   then a small, typically 1 MB, partition must be created if it does not
   already exist.
   This partition is not formated, but must be available for GRUB to use during
   installation of the boot loader.
   This partition will normally be labeled 'BIOS Boot' if using fdisk or have
   a code of EF02 if using gdisk.
4. The Grub Bios must be on the drive that the BIOS uses to boot the system.
   This is not necessarily the same drive where the LFS root partition is
   located. Disks on a system may use different partition table types. The
   requirement for this partition depends only on the partition table type of
   the boot disk.
5. Convenience Partitions:
   /boot, use this partition to store kernels and other information. To
   minimize potential boot problems with large disks, make this the first
   physical partition on your first disk drive. A partition size of 200 MB is
   quite adequate.
   /home, Share your home directory and user customization across multiple
   distributions or LFS builds. The size is generally fairly large and
   depends on available disk space.
   /opt, this directory is most useful for BLFS where multiple installations of
   large packages Gnome or KDE can be installed without embedding the files in
   the /usr hierarchy. If used, 5 to 10 GB is generally adequate.

```bash
   Finally, my partitions:
   /boot	sdb1	200 BM
   /		sdb2	50 GB
   /opt		sdb3	10 GB
			sdb4	extended
   swap		sdb5	4 GB		Will be used when LFS booted
   /home	sdb6	residuary GB
```
My partition type is "Linux"

## Section 2.6 Setting The $LFS Variable
1. Modified /root/.bashrc with "export LFS=/mnt/lfs"

## Section 2.7 Mounting the New Partition
1. Modified /etc/fstab with following:
```bash
   /dev/sdb2       /mnt/lfs        ext4	defaults        1       1
   /dev/sdb1       /mnt/lfs/boot   ext4	defaults        1       1
   /dev/sdb3       /mnt/lfs/opt    ext4	defaults        1       1
   /dev/sdb6       /mnt/lfs/homt   ext4	defaults        1       1
```
