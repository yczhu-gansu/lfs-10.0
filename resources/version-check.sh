#!/bin/bash
# Simple script to list version numbers of critical development tools

export LC_ALL=C # Overides the LANG environment variable and the values of any
				# other LC_* environment variables.
				# https://www.ibm.com/support/knowledgecenter/en/ssw_aix_71/globalization/locales.html

bash --version | head -n1 | cut -d" " -f2-4
MYSH=$(readlink -f /bin/sh)
echo "/bin/sh -> $MYSH"	# /bin/sh should be a symbolic or
						# hard link to bash
echo $MYSH | grep -q bash || echo "ERROR: /bin/sh does not point to bash"
unset MYSH

echo -n "Binutils: "; ld --version | head -n1 | cut -d" " -f3-
bison --version | head -n1
# /usr/bin/yacc should be a link to bison or small script that executes bison
if [ -h /usr/bin/yacc ]; then
	echo "/usr/bin/yacc -> `readlink -f /usr/bin/yacc`"
elif [ -x /usr/bin/yacc ]; then
	echo "yacc is `/usr/bin/yacc --version | head -n1`"
else
	echo "yacc not found"
fi

bzip2 --version 2>&1 < /dev/null | head -n1 | cut -d" " -f1,6-
echo -n "Coreutils: "; chown --version | head -n1 | cut -d")" -f2
diff --version | head -n1
find --version | head -n1
gawk --version | head -n1
# /usr/bin/awk should be a link to gawk
if [ -h /usr/bin/awk ]; then
	echo "/usr/bin/awk->`readlink -f /usr/bin/awk`";
elif [ -x /usr/bin/awk ]; then
	echo "awk is `/usr/bin/awk --version | head -n1`"
else
	echo "awk not found"
fi

gcc --version | head -n1
g++ --version | head -n1
ldd --version | head -n1 | cut -d" " -f2-	# glibc version
grep --version | head -n1
gzip --version | head -n1
cat /proc/version
m4 --version | head -n1
make --version | head -n1
patch --version | head -n1
echo Perl `perl -V:version`
python3 --version
sed --version | head -n1
tar --version | head -n1
makeinfo --version | head -n1	# texinfo version
xz --version | head -n1

echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c
if [ -x dummy ];then
	echo "g++ compilation OK"
else
	echo "g++ compilation failed"
fi
rm -f dummy dummy.c
