# 9.5 General Network Configuration

## 9.5.1 Creating Network Interface Configuration Files

Which interfaces are brought up and down by the network script usually depends
on the files in /etc/sysconfig/. This directory should contain a file for each
interface to be configured, such as ifconfig.xyz, where "xyz" should describe
the network card. The interface name (e.g. eth0) is usually appropriate.

Inside this file are attributes to this interface, such as its IP address(es),
subnet masks, and so forth. It is necessary that the stem of the filename be
ifconfig.
>If the procedure in the previous section was not used, udev will assign network
>card interface names based on system physical characteristics such enp2s1. If
>you are not sure what your interface name is, you can always run **ip link** or
>**ls /sys/class/net** after you have booted your system.

Create a sample file for the eth0 device with a static IP address.

The interface can be manually started or stopped with the **ifup** and
**ifdown** commands.

For more information see the **ifup** man page.

## 9.5.2 Creating the /etc/resolv.conf file

The system will need some means of obtain Domain Name Service (DNS) name
resolution to resolve Internet domain names to IP addresses, and vice versa.
This is best achieved by placing the IP address of the DNS server, available
from the ISP or network administrator, into */etc/resolv.conf*.

The *domain* statement can be ommited or replaced with a *search* statement. See
the man page for *resolv.conf* for more details.

## 9.5.3 Configuring the system hostname

During the boot process, the file */etc/hostname* is used for establishing the
system's hostname.

Do not enter the Fully Qualified Domain Name (FQDN) here. That information is
put in the */etc/hosts* file.

## 9.5.4 Customizing the /etc/hosts file

Decide on the IP address, fully-qualified domain name (FQDN), and possible
aliases for use in the /etc/hosts file. The syntax is:
```bash
IP_address myhost.example.com aliases
```
Unless the computer is to be visible to the internet (i.e., there is a
registered domain and a valid block of assigned IP addresses - most users do not
have this), make sure that the IP address is in the private network IP address
range.

Even if not using a network card, a valid FQDN is still required. This is
necessary for certain programs to operate correctly.
