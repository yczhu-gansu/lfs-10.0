# Section 8.10 Bzip2

The Bzip2 package contains programs for compressing and decompressing files.
Compressing text files with bzip2 yields a much better compression percentage
than with the traditional gzip.

## Contents of Bzip2
Installed programs:
* bunzip2 (link to bzip2), Decompresses bzipped files
* bzcat (link to bzip2), Decompresses to standard output
* bzcmp (link to bzipdiff), Runs cmp on bzipped files
* bzdiff, Runs diff on bzipped files
* bzegrep (link to bzgrep), Runs egrep on bzipped files
* bzfgrep (link to bzgrep), Runs fgrep on bzipped files
* bzgrep, Runs grep on bzipped files
* bzip2, Compresses files using the Burrows-Wheeler block sorting text
  compression algorithm with Huffman coding; the compression rate is better than
  achieved by more conventional compressors using "Lempel-Ziv" algorithms, like
  gzip
* bzip2recover, Tries to recover data from damaged bzipped files
* bzless (link to bzmore), Runs less on bzipped files
* bzmore, Runs more on bzipped files

Installed libraries:
* libbz2.{a,so}, The library implementing lossless, block-sorting data compression,
  using the Burrows-Wheeler algorithm

Installed direcroty:
* /usr/share/doc/bzip2-1.0.8
