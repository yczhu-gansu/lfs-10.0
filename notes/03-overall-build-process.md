# Three Stages of Build A Temperary Area:
1. Build a cross compiler and its associated libraries;
2. Use this cross toolchain to build several utilities in a way that isolates
   them from the host distribution;
3. Enter the chroot environment, which further imporves host isolation, and
   build the remaining tools needed to build the final system.

By using **chroot**,  the commands in the remaining chapters will be contained
within that environment, ensuring a free, trouble-free build of the target LFS
system.

