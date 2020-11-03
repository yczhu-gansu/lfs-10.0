# Section 2.2 Host System Requirements

## Reconfigure Host System
0. Configure sudo permission, in order to used **sudo** in normal user. Add a
   line simulate the root line
```bash
	$ su - root
	# vidudo
```
1. Install openssh-server, in order to remote login.
```bash
	$ sudo apt install openssh-server
```
2. Reconfigure dash, required by the LFS book:
```bash
	$ sudo sudo dpkg-reconfigure dash
```
3. Install bison, required by the LFS book:
```bash
	$ sudo apt install bison
```
4. Install gawk, required by the LFS book:
```bash
	$ sudo apt install gawk
```
5. Install texinfo-4.7, required by the LFS book:
```bash
	$ sudo apt install texinfo
```

## Check Host System
To see whether the host system has all the appropriate versions, and the ability
to compile programs, run [This Script](../resources/version-check.sh)
