# 9.3 Overview of Device and Module Handling

Before we go into the details regarding how udev works, a brief history of
prefious methods of handling devices is in order.

Linux systems in general traditionally used a static device creation method,
whereby a great many device node were created under /dev (sometimes literally
thousands of nodes), regardless of whether the corresponding hardware devices
actually existed. This was typically done via **MAKEDEV** script, which contains
a number of calls to the *mknod* program with the relevant major and minor
device numbers for every possible device that might exist in the world.

Using the udev method, only those devices which are detected by the kernel get
device nodes created for them. Because these device nodes will be created each
time the system boots, they will be stored on a *devtmpfs* file system (a
virtual file system that resides entirely in system memory). Device nodes do not
require much space, so the memory that is used is negligible.

## 9.3.1 History

In February 2000, a new filesystem called *devfs* was merged into the 2.3.46
kernel and was made available during the 2.4 series of stable kernels. Although
it was present in the kernel source itself, this method of creating devices
dynamically never received overwhelming support from the core kernel developers.

The main problem with the approach adoapted by *devfs* was the way it handled
device detection, creation, and naming. Device node naming, was perhaps the most
critical. It is generally accepted that if device names are allowed to be
configurable then device naming policy should be up to a system administrator,
not imposed on them by any particular developer(s). The *devfs* file system also
suffered from race conditions that were inherent in its design and could not be
fixed without substantial revision on the kernel. Finally removed from the
kernel in June, 2006.

With the 2.6 series stable kernels, a new virtual filesystem called *sysfs* came
to be. The job of *sysfs* is to export a view of the system's hardware
configuration to userspace processes.

## 9.3.2 Udev Implementation

### 9.3.2.1 Sysfs

How *sysfs* knows about the devices present on a system and what device numbers
should be used for them?
* Drivers that have been compiled into the kernel directly register their
  objects with a *sysfs* (devtmpfs internally) as they are detected by the
  kernel.
* For deivers compiled as modules, this registration will happen when the
  module is loaded. Once the *sysfs* filesystem is mounted (on /sys), data
  which the drivers register with *sysfs* are available to userspace processes
  and to udevd for processing (including modifications to device nodes).

### 9.3.2.2 Device Node Creation

Device files are created by the kernel by the *devtmpfs* filesystem. Any driver
that wishes to register a device node will go through the *devtmpfs* (via the
driver core) to do it. When a *devtmpfs* instance is mounted on /dev, the device
node will initially be created with a fixed name, permissions, and owner.

A short time later, the kernel will send a uevent to **udevd**. Based on the
rules specified in the files within the */etc/udev/rules.d, /lib/udev/rules.d*,
and */run/udev/rules.d* directories, **udevd** will create additional symlinks
to the device node, or change its permissions, owner, or group, or modify the
internal **udevd** database entry (name) for the object.

The rules in these three directories are numbered and all three directories are
merged together. If **udevd** can't find a rules for the device it is creating,
it will leave the permissions and ownership at whatever *devtmpfs* used
initially.

### 9.3.2.3 Module Loading

Device drivers compiled as modules may have aliases built into them. Aliases are
visible in the output of the **modinfo** program and are usually related to the
bus-specific identifiers of devices supported by a module.

Example: the *snd-fm801* driver supports PCI devices with vendor ID 0x1319 and
device ID 0x0801, and has an alias of
"pci:v00001319d00000801sv\*sd\*bc04sc01i\*"

For most devices, the bus driver exports the alias of the driver that would
handle the device via *sysfs*.

Example: the */sys/buc/pci/devices/0000:00:0d.0/modalias* file might contain the
string "pci:v00001319d00000801sv00001319sd00001319bc04sc01i00".

The default rules provided wity udev will cause **udevd** to call out to
*/sbin/modprobe* with the contents of the MODALIAS uevent environment variable
(which should be the same as the contents of the modalias file in sysfs), thus
loading all modules whose aliases match this string after wildcard expansion.

In this example, this means that in addition to snd-fm801, the obsolete (and
unwanted) forte driver will be loaded if it is visible.

The kernel itself is also able to load modules for network protocols,
filesystems, and NLS support on demand.

### 9.3.2.4 Handling Hotpluggable/Dynamic Devices

When you plug in a device, such as Universal Serial Bus (USB) MP3 player, the
kernel recognizes that the device is connected and generates a uevent. This
uevent then handled by **udevd** as described above.

## 9.3.3 Problems with Loading Modules and Creating Devices

There are a few possible problems when it comes to automatically creating device
nodes.

### 9.3.3.1 A kernel module is not loaded automatically

Udev will only load a module if it has a bus-specific alias and the bus driver
properly exports the necessary aliases to sysfs. In other cases, one should
arrange module loading by other means. With Linux-5.8.3, udev is known to load
properly-written drivers for INPUT, IDE, USB, SCSI, SERIO, and FireWire devices.

To determine if the device driver you require has the necessary support for
udev, run **modinfo** with the module name as the argument. Now try locating the
device directory under /sys/bus and check whether there is a modalias file
there.

If *modalias* file exists in *sysfs*, the driver supports the device and can
talk to it directly, but doesn't have the alias, it is a bug in the driver. Load
the driver without the help from udev and expect the issue to be fixed later.

If there is no *modalias* file in the relevant directory under */sys/bus*, this
means that the kernel developers have not yet added modalias support to this bus
type.

Udev is not intended to load "wrapper" drivers such as snd-pcm-oss and
non-hardware drivers such as loop at all.

### 9.3.3.1 A kernel module is not loaded automatically, and udev is not intended to load it

If the "wrapper" module only ehances the functionality provided by some other
module (e.g., snd-pcm-oss ehances the functionality of snd-pcm by make the sound
cards available to OSS applications), configure **modprobe** to load the wrapper
after udev loads the wrapped module. To do this, add a "softdep" line to the
corresponding */etc/modprobe.d/<filename>.conf* file.
```bash
softdep snd-pcm post: snd-pcm-oss
```
Note that the "softdep" command also allow *pre:* dependencies, or a mixture of
both *pre:* and *post:* dependencies.

See the *modprobe.d(5)* manual page for more information on "softdep" syntax and
capabilities.

If the module in question is not a wrapper and is useful by iteslf, configure
the *modules* bootscript to load this module on system boot. To do this, add the
module name to the */etc/sysconfig/modules* file on a separate line.

### 9.3.3.3 Udev loads some unwanted module

Either don't build the module, or blacklist it in a
*/etc/modprobe.d/blacklist.conf* file as done with the forte module in the
example below:
```bash
blacklist forte
```
Blacklisted modules can still be loaded manually with the explicit **modprobe**
command.

### 9.3.3.4 Udev creates a device incorrectly, or makes a wrong symbolic

This usually happens if a rule unexpectedly matches a device. For example, a
poorly-written rule can match both a SCSI disk (as desired) and the
corresponding SCSI generic device (incorrectly) by vendor. Find the offendig
rule and make it more specific, with the help of the **udevadm info** command.

### 9.3.3.5 Udev rule works unreliably

This may be another mainfestation of the previous problem. If not, and your rule
uses *sysfs* attributes, it may be a kernel timing issue, to be fixed in later
kernels. For know, you can work around it by creating a rule that waits for the
used sysfds attribute and appending it to the
*/etc/udev/rules.d/10-wait_for_sysfs.rules* file (create this file if it does
not exist).

### 9.3.3.6 Udev does not create a device

Further text assumes that the driver is built statically into the kernel or
already loaded as a module, and that you have already checked that udev doesn't
create a misnamed device.

Udev has no information needed to create a device node if a kernel driver does
not exports its data to *sysfs*. This is most common with third party drivers
from outside the kernel tree. Create a static device node in */lib/udev/devices*
with the apporiate major/minor numbers (see the file device.txt inside the
kernel documentation or the documentation provided by the third party driver
vendor). The static device node will be copied to */dev* by **udev**.

### 9.3.3.7 Device naming order changes randomly after rebooting

This is due to the fact that udev, by design, handles uevents and loads modules
in parallel, and thus in an unpredictable order. This will never be "fixed". You
should not rely upon the kernel device names being stable. Instead, create your
own rules that make symlinks with stable names based on some stable attributes
of the device, such as a serial number or the output of various \*\_id utilities
installed by udev.

## 9.3.4 Useful Reading

* [A Userspace Implementation of devfs](../resources/Reprint-Kroah-Hartman-OLS2003.pdf)

* [The sysfs Filesystem](../resources/mochel.pdf)
