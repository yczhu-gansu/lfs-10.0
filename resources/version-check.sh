#!/bin/bash
# Simple script to list version numbers of critical development tools

export LC_ALL=C # Overides the LANG environment variable and the values of any
				# other LC_* environment variables.

bash --version | head -n1 | cut -d" " -f2-4
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"
echo $MYSH | grep -q bash || echo "ERROR: /bin/sh does not point to bash"
unset MYSH

echo -n "Binutils: "; ld --version | head -n1 | cut -d" " -f3-
bison --version | head -n1

if [ -h /usr/bin/yacc ]; then
	echo "/usr/bin/yacc -> `readlink -f /usr/bin/yacc`"
elif [ -x /usr/bin/yacc ]; then
	echo "yacc is `/usr/bin/yacc --version | head -n1`"
else
	echo "yacc not found"
fi
