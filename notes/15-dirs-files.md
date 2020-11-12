# Section 7.5 Creating Directories

## Full structure in the LFS file system
Create some root-level directories that are not in the limited set required in
the previous chapters.
```bash
boot, home, opt, mnt, srv
```

Create the required set of subdirectories below the root-level.
```bash
/etc/{opt,sysconfig}
/lib/firmware
/media/{floppy,cdrom}
/usr/{,local/}{bin,include,lib,sbin,src}
/usr/{,local/}share/{color,dict,doc,info,local,man}
/usr/{,local/}share/{misc,terminfo,zoneinfo}
/usr/{,local/}share/man/man{1..8}
/var/{cache,local,log,mail,opt,spool}
/var/lib/{color,misc,locate}

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
```
The directory tree is based on the
[Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/fhs.shtml)

## Section 7.6 Creating Essential Files and Symlinks

## /etc/mtab
Historically, Linux maintains a list of the mounted file systems in the file
/etc/mtab. Modern kernels maintain this list internally and exposes it to the
user via the /proc filesystem. To satisfy utilities that expect the presence of
/etc/mtab, create the following symbolic link:
```bash
ln -sv /proc/self/mounts /etc/mtab
```

## /etc/hosts
Create a basic */etc/hosts* file to be referenced in some test suits, and in one
of Perl's configuration files as well.

## /etc/passwd and /etc/group
In order for user root to be able to login and for the name "root" to be
recognized, there must be relevant entries in the */etc/passwd* and */etc/group*
files.

The created groups are not part of any standard - they are groups decided on in
part by the requirements of the Udev configuration in Chapter 9, and in part by
common convention employed by a number of existing Linux distributionis.

In addition, some test suits rely on specific users or groups.

The LSB only recommends that, besides the group root with a GID of 0, a group
bin with a GID of 1 be present.

All other group names and GIDs can be chosen freely by the system adminiatrator
since well-written programs do not depend on GID numbers, but rather use the
group's name.

## Start a new shell
Since the /etc/passwd and /etc/group files have been created, user name and
group name resolution will now work:
```bash
exec /bin/bash --login +h
```
The +h directive tells bash not to use its internal path hasing. Without this
directive, bash would remember the paths to binaries it has executed. To ensure
the use of the newly compiled binaries as soon as they are installed, the +h
directive will be used for the duration of this and the next chapter.

## log files
The login, agetty, and init programs (and others) use a number of log files to
record information such as who was logged into the system and when. However,
these programs will not write to the log files if they do not already exit.
Initialize the log files and give them proper permissions:
```bash
touch /var/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664 /var/log/lastlog
chmod -v 600 /var/log/btmp
```
The /var/log/wtmp file records all logins and logouts.

The /var/log/lastlog file records when each user last logged in.

The /var/log/faillog file records failed login attempts.

The /var/log/btmp file records the bad login attempts.
