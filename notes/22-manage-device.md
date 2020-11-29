# 9.4 Managing Devices

## 9.4.1 Network Devices

Udev, by default, names network devices according to Fireware/BIOS data or
physical characteristics like the bus, slot, or MAC address. The purpose of this
naming convention is to ensure that network devices are named consistently and
not based on the time the network card was discovered.

In the new naming scheme, typical network device names would then be something
like enp5s0 or wlp3s0. If this naming scheme convention is not desired, the
traditional naming scheme or a custom scheme can be implemented.

### 9.4.1.1 Disabling Persisdent Naming on the Kernel Command Line

The traditional name scheme using eth0, eth1, etc can be restored by adding
**net.ifnames=0** on the kernel command line. This is most appropriate for those
systems that have only one ethernet device of the same type. Laptops often have
multiple ethernet connections that are named eth0 and wlan0 and are also
candidates for this method. The command line is passed in the GRUB configuration
file.

### 9.4.1.2 Creating Custom Udev Rules

The naming scheme can be customized by creating custom udev rules. A script has
been included that generates the initial rules. Generate these rules by running:
```bash
bash /lib/udev/init-net-rules.sh
```
Now, inspect the */etc/udev/rules.d/70-persistent-net.rules* file, to find out
which name was assigned to which network device:
```bash
cat /etc/udev/rules.d/70-persistent-net.rules
```
This file begins with a comment block followed by two lines for each NIC. The
first line for each NIC is a commented description showing its hardware IDs
(e.g. its PCI vendor and device IDs, if it's a PCI card), along with its driver
in parentheses, if the driver can be found. Neither the hardware ID nor the
driver is used to determine which name to given an interface; this information
is only for reference. The second line is the udev rule that matches this NIC
and actually assigns it a name.

All udev rules are made up of several keys, separated by commas and optional
whitespace. This rule's keys and explanation of each of them are as follows:
1. SUBSYSTEM=="net", this tells udev to ignore devices that are not network
   cards.
2. ACTION=="add", this tells udev to ignore this rule for a uevent that isn't an
   add ("remove" and "change" uevents also happen, bu don't need to rename
   network interfaces).
3. DRIVERS=="?\*", This exists so that udev will ignore VLAN or bridge
   sub-interfaces (because these sub-interfaces do not have drivers). These
   sub-interfaces are skipped because the name that would be assigned would
   collide with their parent devices.
4. ATTR{address}, The value of this key is the NIC's MAC address.
5. ATTR{type}=="1", This ensures the rule only matches the primary interface in
   the case of certain wireless drivers which create multiple virtual
   interfaces. The secondary interfaces are skipped for the same reason that
   VLAN and bridge sub-interfaces are skipped: there would be a name collision
   otherwise.
6. NAME, the value of this key is the name that udev will assign to this
   interface.

## 9.4.2 CD-ROM symlinks

Some software that you may want to install later (e.g., various media player)
expect the */dev/cdrome* and */dev/dvd* symlinks to exist, and to point to an
CD-ROM or DVD-ROM device. Also, it may convenient to put references to those
symlinks into */etc/fstab*.

Udev comes with a script that will generate rules files to create these symlinks
for you, depending on the capabilities of each device, but you need to decide
which of two modes of operation you wish to have the script use.
1. The script can operate in "by-path" mode (used by default for USB and
   FireWire devices), where the rules it creates depend on the physcial path to
   the CD or DVD devide.
2. it can operate in "by-id" mode (default for IDE and SCSI devices), where the
   rules it creates depend on identification strings stored on the CD or DVD
   device itself.

If you wish to see the values the udev scripts will use, then for the
appropriate CD-ROM device, find the corresponding directory under /sys (e.g.,
this can be /sys/block/hdd) and run a command similar to the following:
```bash
udevadm test /sys/block/hdd
```
