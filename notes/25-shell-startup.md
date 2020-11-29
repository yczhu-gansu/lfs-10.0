# 9.7 The Bash Shell Startup File

The shell program */bin/bash* uses a collection of startup files to help create
an environment to run in. Each file has a specific use and may affect login and
interactive environments differently.

The files in the */etc* directory provide global settings. If an equivalent file
exists in the home directory, it may override the global settings.

An interactive login shell is started after a successful login, using
*/bin/login*, by reading the */etc/passwd* file.

An interactive non-login shell is started at the command-line (e.g.,
[prompt]$/bin/bash). 

An non-interactive shell is usually present when a shell script is running. It
is non-interactive because it is processing a script and not waiting for user
input between commands.

For more information, see **info bash** under the *Bash Start Files and
Interactive Shells* section.

The files in */etc/profile* and *~/.bash_profile* are read when the shell is
invoked as an interactive login shell.

The base */etc/profile* below sets some environment variables necessary for
native language support. Setting them properly results in:
1. The output of programs translated into the native language;
2. Correct classification of characters into letters, digits, and other classes.
   This is necessary for bash to properly accept non-ASCII characters in command
   lines in non-English locales;
3. The correct alphabetical sorting order for the country;
4. Appropriate default paper size;
5. Correct formatting of monetary, time, and date values;

Replace *<ll>* below with the two-letter code for the desired language (e.g.,
"en") and *<CC>* with the two-letter code for the appropriate country (e.g.,
"GB"). *<charmap>* should be replaced with the canonical charmap for your chosen
locale. Optional modifiers such as "@euro" may also be present.

The list of locales supported by Glibc can be obtained by:
```bash
locale -a
```
Charmaps can have a number of aliases, e.g., "ISO-8859-1" is also referred to as
"iso-8859-1" and "iso88591". Some applications cannot handle the various
synonyms correctly, so it is safest in most cases to choose the canonical name
for a particular locale.

To determine the canonical name, run the following command, where *<local name>*
is the output given by locale -a for your preferred locale.
```bash
LC_ALL=<locale name> locale charmap
```
It is important that the locale found using the heuristic above is tested prior
to it being added to the Bash startup files:
```bash
LC_ALL=<locale name> locale language	# Language name
LC_ALL=<locale name> locale charmap		# Character encoding used by the locale
LC_ALL=<locale name> locale	int_curr_symbol		# Locale currency
LC_ALL=<locale name> locale int_prefix	# The prefix to dial before the
							# telephone number in order to get into the country.
```
Once the proper locale settings have been determined, create the */etc/profile*
file.
