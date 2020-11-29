# 9.8 Creating the /etc/inputrc File

The *inputrc* file is the configuration file for the readline library, which
provides editing capabilities while the user is entering a line from the
terminal. It works by translating keyboard inputs into specific actions.
Readline is used by bash and most other shells as well as many other
applications.

Most people do not need user-specific functionality so the command below creates
a global */etc/inputrc* used by everyone who logs in. If you latter decide you
need to override the defaults on a per user basis, you can create a *.inputrc*
file in the user's home directory with the modified mappings.

For more information on how to edit the *inputrc* file, see **info bash** under
the *Readline Init File* section. **info readline** is also a good source of
information.
