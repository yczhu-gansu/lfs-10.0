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
