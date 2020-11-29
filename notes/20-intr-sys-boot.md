# Booting a Linux System

## 9.1 Introduction

The process of booting a Linux system must:
1. mount both virtual and real file systems;
2. initialize devices;
3. active swap;
4. check file systems for integrity;
5. mount any swap partitions or files;
6. set the system clock;
7. bring up networking;
8. start any daemons required by the system
9. accomplish any other custom tasks needed by the user.

This process must be organized to ensure the tasks are performed in the correct
order but, the same time, be executed as fast as possible.

### 9.1.1 System V

System V is the classic boot process has been used since about 1983. It consists
of a small program, **init**, that
1. sets up basic programs such as login (via getty)
2. and runs a script. This script usually named **rc**, controls the execution
   of a set of additional scripts that perform the tasks required to initialize
   the system.

The *init* program is controled by the */etc/inittab* file and is organized into
run levels that can be run by the user:
* 0 - halt
* 1 - Single user mode
* 2 - Multiuser, without networking
* 3 - Full multiuser mode
* 4 - User definable
* 5 - Full multiuser mode with display manager
* 6 - reboot

The usual default run level is 3 or 5.

#### Advantages
* Established, well understood system.
* Easy to custome.

#### Disadvantage
1. May be slower to boot. A medium speed base LFS system takes 8 - 12 seconds
   where the boot time is measured from the first kernel message to the login
   prompt. Network connectivity is typically eastablished about 2 seconds after
   the login prompt.
2. Serial processing of boot tasks. A delay in any process such as a file system
   check, will delay the entire boot process.
3. Does not directly support advanced features like control groups (cgroups),
   and per-user fair share scheduling.
4. Adding scripts requires manual, static sequencing decisions.

## 9.2 LFS-Bootscripts-20200818

The LFS-Bootscripts package contains a set of scripts to start/stop the LFS
system at bootup/shutdown.

### Installed scripts:
1. checkfs, Checks the integrity of the file systems before they are mounted
   (with the exception of journal and network based file systems).
2. cleanfs, Removes file that should not be preserved between reboots, such as
   those in */var/run* and */var/lock*; it re-creates */var/run/utmp* and
   removes the possibly present */etc/nologin, /fastboot*, and */forcefsck*
   files.
3. console, Loads the correct keymap table for the desired keyboard layout; it
   also sets the screen font.
4. functions, Contains common functions, such error and status checking, that
   are used by  several bootscripts.
5. halt, Halts the system.
6. ifdown, Stops a network device.
7. ifup, Initializes a network device.
8. localhost, Sets up the system's hostname and local loopback device.
9. modules, Loads kernel modules listed in */etc/sysconfig/modules*, using
   arguments that are also given there.
10. mountfs, mounts all file systems, except ones that are marked noauto or are
    network based
11. mountvirtfs, Mounts virtual kernel file systems, such *proc*.
12. network, Sets up network interfaces, such as network cards, and sets up the
    default gateway (where applicable).
13. rc, the master run-level control script; it is responsible for running all
    the other bootscripts one-by-one, in a sequence determined by the name of the
    symbolic links being processed
14. reboot, Reboots the system.
15. sendsignals, Makes sure every process is terminated before the system
    reboots or halts
16. setclock, Resets the kernel clock to local time in case the hardware clock
    is not set to UTC time.
17. ipv4-static, Provides the functionality needed to assign static Internet
    Protocol address to a network interface.
18. swap, Enables and disables swap files and partitions.
19. sysctl, Loads system configuration values in */etc/sysctl.conf*, if that
    exists, into the running kernel.
20. sysklogd, Starts and stops the system and kernel log daemons.
21. template, A template to create custom bootscripts for other daemons.
22. udev, Prepares the /dev directory and starts Udev.
23. udev\_retry, Retries failed udev uevents, and copies generated rules files
    from */run/udev* to */etc/udev/rules.d/* if required.
