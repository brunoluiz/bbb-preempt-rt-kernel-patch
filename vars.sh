#!/bin/bash


# If your script don't have any declared 'linuxpath', then it will use the default string 'kernel'
if [ -z $linuxpath ]; then 
    linuxpath="kernel"
fi

arm_compiler="arm-linux-gnueabihf-"
debian_webdir="http://debian.beagleboard.org/images"
linux_webdir="http://www.kernel.org/pub/linux/kernel/v3.x"

linux_ver="linux-3.12.31"
debian_file="bone-debian-7.5-2014-05-14-2gb.img"
