# 9.9 Creating the /etc/shells File

The *shells* file contains a list of login shells on the system. Applications
use this file to determine whether a shell is valid. For each shell a single
line should be present, consisting of the shell's path relative to the root
directory structure (/).

For example, this file is consulted by **chsh** to determine whether an
unprivileged user may change the login shell for her own account. If the command
name is not listed, the user will be denied the ability to change shells.

It is a requirement for applications such as GDM which does note populate the
face browser if it can't fine */etc/shells*, or FTP daemons which traditionally
disallow access to users with shells not included in this file.
