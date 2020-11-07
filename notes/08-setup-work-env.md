# Section 2.6 Setting The $LFS Variable
One way to ensure that the *LFS* variable is always set is to edit the
*.bash\_profile* file in both your personal home directory and in
*/root/.bash\_profile* and enter the export command.

The shell specified in the */etc/passwd* file for all users that need the *LFS*
variable needs to be bash to ensure that the */root/.bash\_profile* file is
incorporated as a part of the login process.

Another consideration is the method that is used to log into the host system. If
logging in through a graphical display manager, the user's *.bash\_profile* is
not normally used whan a virtual terminal is started. In this case, add the
export command to the *.bashrc* file for the user and root.

In addition, some distributions have instructions to not run the *.bashrc*
instructions in a non-interactive bash invocation. Be sure to add the export
command before the test for non-interactive use.

Modify /root/.bashrc, append following line:
```bash
"export LFS=/mnt/lfs"
```

# Section 2.7 Mount the New Partition
If using multiple partitions for LFS (e.g., one for / and another for /usr),
mount them using
```bash
mkdir -pv $LFS
mount -v -t ext4 /dev/<xxx> $LFS
mkdir -v $LFS/usr
mount -v -t ext4 /dev/<yyy> $LFS/usr
```
Ensure that this new partition is not mounted with permissions that are too
restrictive (such as the *nosuid* or *nodev* options).

Run the **mount** command without any parameters to see what options are set for
the mounted LFS partition. If *nosuid* and/or *nodev* are set, the partition
will need to be remounted.

Modify the host system's /etc/fstab to automatically remount it upon it boot.
```bash
   /dev/sdb2       /mnt/lfs        ext4	defaults        1       1
   /dev/sdb1       /mnt/lfs/boot   ext4	defaults        1       1
   /dev/sdb3       /mnt/lfs/opt    ext4	defaults        1       1
   /dev/sdb6       /mnt/lfs/home   ext4	defaults        1       1
```

If you are using a *swap* partition, ensure that it is enabled using the
**swapon** command:
```bash
/sbin/swapon -v /dev/<zzz>
```

Now that there is an established place to work.
