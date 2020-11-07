# Chapter 3. Packages and Patches

## 3.1 Introduction
*$LFS/sources* can be used both as the place to store the tarballs and patches
and as a working directory.

Make this directory writable and sticky. "Sticky" means that even if multiple
users have write permission on a directory, only the owner of a file can delete
the file within a sticky directory.
```bash
mkdir -pv $LFS/sources
chmod -v a+wt $LFS/sources
```
To download all of the packages and patches by using
[wget-list](../resources/wget-list) as an input to the *wget* command:
```bash
wget --input-file=wget-list --continue --directory=$LFS/sources
```

File [md5sum](../resources/md5sums) can be used to verify that all the correct
packages are available before proceeding. Place the file in *$LFS/sources* and
run:
```bash
pushd $LFS/sources
md5sum -c md5sums
popd
```
