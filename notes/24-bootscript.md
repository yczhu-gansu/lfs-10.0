# 9.6 System V Bootscript Usage and Configuration

## 9.6.1 How Do the System V Bootscript Work?

Linux uses a special booting facility named SysVinit that is based on a concept
of run-levels. It can be quiet different from one system to another. LFS has its
own way of doing things, but it respects generally accepted standards.

SysVinit (which will be refered to as "init" from now on) works using a
run-level scheme (see init(3) for more details)

## 9.6.2 Configuring SysVinit

During the kernel initialization, the first program that is run is either
specified on the command line or, by default **init**. This program reads the
initialization file */etc/inittab*.

An explanation of this initialization file is in the man page for *inittab*. For
LFS, the key command that is run is *rc*. The initialization file in LFS will
instruct *rc* to run all the scripts starting with an S in the */etc/rc.d/rs?.d*
directory where the question mark parameters is specified by the initdefault
value.

As a convenience, the *rc* scripts reads a library of functions in
*/lib/lsb/init-functions*. This library also reads an optional configuration
file, */etc/sysconfig/rc.site*

### 9.6.2.1 Changing Run Levels

Changing run-levels is done with **init <runlevel>**, where *<runlevel>* is the
target run-level.
```bash
init 6	# Alias for the reboot command
init 0	# alias for the halt command
```
There are a number of directories under */etc/rc.d* that look like *rc?.d*
(where ? is the number of the run-level) and *rcsysinit.d*, all containing a
number of symbolic links. Some begin wit a K, the other begin with an S, and all
of them have two numbers following the initial letter.

## 9.6.3 Udev Bootscripts

The */etc/rc.d/init.d/udev* initscript start **udev**, triggers any "coldplug"
devices that have already been created by the kernel and wait for any rules to
complete. The script also unsets the uevent handler from the default of
*/sbin/hotplug*. This is done because the kernel no longer needs to call out to
an externel binary.

## 9.6.4 Configuring the System Clock

The **setclock** script reads the time from the hardware clock, also known as
the BIOS or the Complementary Metal Oxide Semiconductor (CMOS) clock. If the
hardware clock is set to UTC, this script will convert the hardware clock's time
to the local time using the */etc/localtime* file (which tells the **hwclock**
program which timezone to use).

Find out the set of hardware clock:
```bash
hwclock --localtime --show
```
This will display what the current time is according to the hardware clock.

## 9.6.5 Configuring the Linux Console

How to configure the **console** bootscript that sets up:
1. the keyboard map, 
2. console font,
3. kernel log level.

If non-ASCII characters (e.g., the copyright sign, the British pound sign and
Euro symbol) will not be used and the keyboard is a U.S. one, much of this
section can be skipped. Without the configuration file, (or equivalent setting
in rc.site), the **console** bootscript will do nothing.

The **console** script reads the */etc/sysconfig/console* file for configuration
information. Decide which keymap and screen font will be used. Various
language-specific HOWTOs can also help wiht this, see
[CLICK THE LINK](https://tldp.org/HOWTO/HOWTO-INDEX/other-lang.html)
If still in doubt, look in the */usr/share/keymap* and */usr/share/consolefonts*
directories for valid keymaps and screen fonts. Read *loadkeys(1)* and
*setfont(8)* manual pages to determine the correct arguments for these programs.

The */etc/sysconfig/console* file should contain lines of the form:
```bash
VARIABLE="value"
```
The following variables are recognized:
1. LOGLEVEL, specifies the log level for kernel messages sent to the console set
   by dmesg -n. Valid levels are from "1" (no messages) to "8". The default
   level is 7.
2. KEYMAP, specifies the arguments for the **loadkeys** program, typically, the
   name of keymap to load, e.g., "it". If this variable is not set, the
   bootscript will not run the **loadkeys** program, and the devault keymap will
   be used. Note that a few keymaps have multiple versions with the same name
   (cz and its varients in qwerty/ and qwertz/, es in olpc/ and qwerty/, and trf
   in fgGIod/ and qwerty/). In these cases, the parent directory should also be
   specified (e.g. qwerty/es) to ensure the proper keymap is loaded.
3. KEYMAP\_CORRECTIONS, (rarely used) specifies the arguments for the second
   call to the **loadkeys** program. This is useful if the stock keymaps is not
   completely satisfactory and a small adjustment has to be made. E.g., to
   include Euro sign into a keymap that normally doesn't have it, set this
   variable to "euro2".
4. FONT, specifies the arguments for the **segfont** program. Typically, this
   includes the font name, "-m", and the name of the application character map
   to load. In the UTF-8 mode, the kernel uses the application character map for
   conversion of composed 8-bit key codes in the keymap to UTF-8, and thus, the
   argument of the "-m" parameter shou be set to the encoding of the composed
   key codes in the keymap.
5. UNICODE, set this variable to "1", "yes" or "true" in order to put the
   console into UTF-8 mode. This is useful in UTF-8 based locales and harmful
   otherwise.
6. LEGACY\_CHARSET, For many keyboard layout, there is no stock Unicode keymap
   in the Kbd package. The **console** bootscript will convert an available
   keymap to UTF-8 on the fly if this variable is set to the encoding of the
   available non-UTF-8 map.

>The */etc/sysconfig/console* file only controls the Linux text console
>localization. It has nothing to do with setting the proper keyboard layout and
>terminal fonts in the X Window system, with such sessions, or with a serial
>console.

## 9.6.6 Creating Files at Boot

At times, it is desired to create files at boot time. For instance, the
*/tmp/ICE-unix* directory is often needed. This can be done by creating an entry
in the */etc/sysconfig/createfiles* configuration script. The format of this
file is embedded in the comments of the default configuration file.

## 9.6.7 Configuring the sysklogd Script

The *sysklogd* script invokes the **syslogd** program as a part of System V
initialization. The *-m 0* option turns off the periodic timestamp mark that
**syslogd** writes to the log files every 20 miniutes by default. If you want to
turn on this periodic timestamp mark, edit */etc/sysconfig/rc.site* and define
the variable SYSKLOGD\_PARMS to the desired value.

See **man syslogd** for more options.

## 9.6.8 The rc.site File

The optional */etc/sysconfig/rc.site* file contains settings that are
automatically set for each System V boot script. It can alternatively set the
values specified in the *hostname, console*, and *clock* file in the
*/etc/sysconfig/* directory. If the associated variables are present in both
these separate files and *rc.site*, the values in the script specific files have
precedence.

*rc.site* also contains parameters that can customize other aspects of the boot
process. Setting the IPROMPT variable will enable selective running of
bootscripts. Other options are described in the file comments.

### 9.6.8.1 Customizing the Boot and Shutdown Scripts

Tweak the LFS boot scricpts in the rc.site file to imporve speed even more and
to adjust messages according to your preferences. To do this, adjust the
settings in the */etc/sysconfig/rc.site* file above.
1. During the boot script *udev*, there is a call to **udev settle** that
   requires some time to complete. This time may or may not be required
   depending on devices present in the system. If you only have simple
   partitions and a single ethernet card, the boot process will probably not
   need to wait for this command. To skip this, set the variable
   OMIT\_UDEV\_SETTLE=y.
2. The boot script *udev_retry* also runs **udev settle** by default. This
   command is only needed by default if the */var* directory is separately
   mounted. This is because the clock needs the file */var/lib/hwclock/adtime*.
   Other customizations may also need to wait for udev to complete, but in man
   installations it is not needed. Skip the command by setting the variable
   OMIT\_UDEV\_RETRY\_SETTLE=y.
3. By default, the file system checks are silent. This can appear to be a delay
   during the bootup process. To turn on the **fsck** output, set the variable
   VERBOSE\_FSCK=y.
4. When rebooting, you man want to skip the filesystem check, **fsck**,
   completely. To do this, either create the file /etc/fastboot or reboot the
   system with the command /sbin/shutdown -f -r now. On the other hand, you can
   force all file systems to be checked by creating /forcefsck or runing
   shutdown with the -F parameter instead of -f. Setting the variable FASTBOOT=y
   will disable fsck during the boot process until it is removed. This is not
   recommended on a permanent basis.
5. Normally, all files in the /tmp directory are deleted at boot time. Depending
   on the number of files or directories present, this can cause a noticable
   delay in the reboot process. To skip removing these files set the variable
   SKIPTMPCLEAN=y.
6. During shutdown, the **init** program sends a TERM signal to each program it
   has started (e.g., agetty), waits for a set time (default 3 seconds), and
   sends each process a KILL signal and waits again. This process is repeated in
   the **sendsignals** script for any processes that are not shut down by their
   own scripts. The delay for **init** can be set by passing a parameter. For
   example to remove the delay in **init**, pass the -t0 parameter when shutting
   down or rebooting (e.g., /sbin/shutdown -t0 -r now). The delay for the
   **sendsignals** script can be skipped by setting the parameter.
