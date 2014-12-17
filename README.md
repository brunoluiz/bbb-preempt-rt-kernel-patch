Beagle Bone Black PREEMPT RT patch
==================================

This script will:
1) Download linux kernel 3.12
2) Apply OSADL patches (enabling PREEMPT RT) at Linux Source
3) Compile Linux Kernel
4) Copy Debian 7.5 image to your SD card
5) Copy the patched linux to your SD card

You only have to run ```./build.sh /dev/sdb``` changing /dev/sdb with the desired device