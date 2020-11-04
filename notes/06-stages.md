# Section 2.3 Building LFS in Stages
The issue is that certain procedures have to be re-accomplished after a reboot
if resuming LFS at different points.

## 2.3.1 Chapter 1-4
Accomplished on the host system. When restarting, be careful of the following:
* Procedures done as the root user after Section 2.4 need to have LFS
  environment variable set FOR THE ROOT UESR.

## 2.3.2 Chapter 5-6
* The /mnt/lfs partition must be mounted.
* These two chapters must be done as user *lfs*. An **su -lf** needs to be done
  before any task in these chapters. Failing to do that, you are at risk of
  installing  packages to the host, and potentially rendering it unusable.
* If there is any doubt about installing a package, ensure any previously
  expanded tarballs are removed, then re-extract the package files, and complete
  all instructions in that section.

## 2.3.3 Chapter 7-10
* The /mnt/lfs partition must be mounted.
* A few operations, from "Changing Ownership" to "Entering the Chroot
  environment" must be done as the root user, with the LFS environment variable
  set for the root user.
* When entering the chroot environment, the LFS environment variable must be set
  for root. The LFS variable is not used afterwards.
* The virtual file systems must be mounted. This can be done before or after
* entering chroot by changing to a host virtual terminal.
