# Section 6.1 Introduction

This chapter 6 shows how to cross-compile basic utilities using the just built
cross-toolchain.

Those utilities are installed into their final location, but cannot be used yet.
Basic tasks still rely on the host's tools. Nevertheless, the installed
libraries are used when linking.

Using the utilities will be possible in next chapter after enter the "chroot"
environment. But all the packages built in the present chapter need to be built
before we do that. Therefore we cannot be independent of the host system yet.
