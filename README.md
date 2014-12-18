BBB PREEMPT RT patch script
===========================

This script will install a Debian image at your SD card with the Linux preempt rt kernel

How it works?
-------------
You only have to run ```./build.sh /dev/sdb``` changing /dev/sdb with the desired device

Workflow
--------

This script will:

1. Download linux kernel 3.12 and debian image
2. Apply OSADL patches (enabling PREEMPT RT) at Linux Source
3. Compile Linux Kernel
4. Copy Debian 7.5 image to your SD card
5. Copy the patched kernel to your SD card


TransferToSD-only process
---------------------

If you already downloaded the Debian Image and have the compiled the kernel you just need to run ```./transfer.sh /dev/sdb```, changing /dev/sdb with the desired device

Re-download patches
-------------------

If you want to re-download the OSADL patches you can run ```./osadl-downloads.sh```.