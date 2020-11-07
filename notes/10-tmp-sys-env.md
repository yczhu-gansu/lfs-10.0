# Chapter 4 Final Preparations

Prepare for building the temporary system.

## Section 4.2 Creating a limited directory layout in LFS filesystem
Create a limited directory hierarchy so that programs compiled in Chapter 6 may
be installed in their final location. This is needed so that those temporary
programs be overwritten when building then in Chapter 8.

The required directory layout:
```bash
$LFS/{bin,sbin,lib,lib64,etc,usr,var}
```
Programs in Chapter 6 will be compiled with a cross-compiler

In order to separate this cross-compiler from the other programs, it will be
installed in a special directory.
```bash
$LFS/tools
```

## Section 4.3 Adding the LFS user
The packages in the next two chapters are built as an unprivileged user.

To set up a clean working environment, create a new user called *lfs* as a
member of a new group (also named *lfs*) and use this user during the
installation process.
```bash
# groupadd lfs
# useradd -s /bin/bash -g lfs -m -k /dev/null lfs
```
The meaning of the command line options:
* -s /bin/bash, makes *bash* the default shell for user *lfs*.
* -g lfs, adds user *lfs* to group *lfs*.
* -m, creates a home directory for *lfs*.
* -k /dev/null, Prevents possible copying of files from a skeleton directory
  (default is /etc/skel) by changing the input location to the special null
  device.

Grant *lfs* full access to all directories under *$LFS* by making *lfs* the
directory owner:
```bash
chown -v lfs $LFS/{bin,sbin,lib,lib64,etc,usr,var,sources,tools}
```
```bash
su - lfs
```
The "-" instructs su to start a login shell as opposed to a non-login shell. The
difference between these two types of shells can be found in detail in bash(1)
and **info bash**.

## Section 4.4 Setting Up the Environment
Set up a good working environment by creating two new startup files for the
**bash** shell.
### .bash\_profile
```bash
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
```
When logged on as user *lfs*, the initial shell is usually a login shell which
reads the */etc/profile* of the host (probably containing some settings and
environment variables) and then .bash\_profile.

The **exec env -i .../bin/bash** command in the .bash\_profile file replaces the
running shell with a new one with a completely empty environment, execpt for the
HOME, TERM, and PS1 variables.

### .bashrc
The new instance of the shell is a *non-login* shell, which does not read, and
execute, the contents of */etc/profile* or *.bash\_profile* files, but rather
reads, and executes, the *.bashrc* file instead.
```bash
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
export LFS LC_ALL LFS_TGT PATH
```
The meaning of the settings in .bashrc:
* set +h, turns off bash's hash function. bash uses hash table to remember the
  full path of executable files to avoid searching the PATH time and again to
  find the same executalbe. However, the new tools should be used as soon as
  they are installed. By switching off the hash function, the shell will always
  search the PATH when a program is to be run. As such, the shell will find the
  newly compiled tools in *$LFS/tools* as soon as they are available.
* umask 022, Setting the user file-creation mask (umask) to 022 ensures that
  newly created files and directories only writable by their owner, but are
  readable and executable by anyone (assuming default modes are used by the
  *open(2)* system call, new files will end up with permission mode 644 and
  directories with mode 755).
* LFS=/mnt/lfs, The *LFS* variable should be set to the chosen mount point.
* LC\_ALL=POSIX, The *LC\_ALL* variable controls the localization of certain
  programs, making their messages follow the conventions of a specificed
  country. Setting LC\_ALL to "POSIX" or "C" (the two are equivalent) ensures
  that everything will work as expected in the chroot environment.
* LFS\_TGT=$(uname -m)-lfs-linux-gnu, The LFS\_TGT variable sets a non-default,
  but compatible machine description for use when building our cross compiler
  and linker when cross compiling our temporary toolchain.
* PATH=/usr/bin, Many modern Linux distributions have merged /bin and /usr/bin.
  When this is the case, the standard *PATH* variable needs just to be set
  */usr/bin* for the Chapter 6 environment. When this is not the case, the
  following line adds */bin* to the path.
* if [ ! -L /bin ]; then PATH=/bin:$PATH; fi, If */bin* is not a symbolic link,
  then it has to be added to the PATH variable.
* PATH=$LFS/tools/bin:$PATH, By putting the *$LFS/tools/bin* ahead of the
  standard PATH, the cross-compiler installed at beginning of Chapter 5 is
  picked up by the shell immediately after its installation. This, combined with
  turning off hashing, limits the risk that the compiler from the host be used
  instead of the cross-compiler.
* export LFS LC\_ALL LFS\_TGT PATH, While the above commands have set some
  variables, in order to make them visible within any sub-shells, we export
  them.
>Several commercial distributions add a non-documented instantiation of
>*/etc/bash.bashrc* to the initialization of *bash*. This file has the potential
>to modify the *lfs* user's environment in ways that can affect the building of
>critical LFS packages. To make sure *lfs* user's environment is clean, check
>for the presence of */etc/bash.bashrc* and, if present, move it out of the way.
>
>After use of *lfs* user is finished at the beginning of Chapter 7, you can
>restore /etc/bash.bashrc (if desired).

Finally, to have the environment fully prepared for building the temporary
tools, source the just-created user profile:
```bash
source ~/.bash_profile
```

## Section 4.5 About SBUs
SBU = Standard Build Unit

The first package to be compiled from this book is binutils in Chapter 5. The
time it takes to compile this package is what will be referred to as the SBU.

For many modern systems with multiple processors (or cores) the compilation time
for a package can be reduced by performing a "parallel make" by either setting
an environment variable or telling the *make* program how many processors are
available.
```bash
export MAKEFLAGS='-j4'
```
or just building with:
```bash
make -j4
```

Check CPUs and Processors information:
```bash
cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c	# CPU model
cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l	# CPU num
cat /proc/cpuinfo | grep "cpu cores" | uniq		# Cores num for each CPU
cat /proc/cpuinfo | grep "processor" | wc -l	# Logcial CPU num
```
