#!/bin/bash

echo "[TRANSFER] Init"

if [ ! -z $1 ] 
then 
    :
else
    echo "[TRANSFER] You need to specify a device! Example: /dev/sdb"
    exit 1
fi

boot_partition="$1"1
root_partition="$1"2

echo "[TRANSFER] Unmounting all /dev/sdb partitions"
sudo umount $boot_partition
sudo umount $root_partition

echo "[TRANSFER] Transfering Linux PREEMPT RT Kernel to boot/"
mkdir boot
sudo mount $boot_partition boot

sudo cp -rfv linux-3.12.31-rt45/arch/arm/boot/zImage boot/          # Replacing zImage
sudo rm -rf boot/dtbs/*                                        # Removing the old dtbs
sudo cp -rfv linux-3.12.31-rt45/arch/arm/boot/dts/*.dtb boot/dtbs   # Copying new dtbs
sudo cp -rfv linux-3.12.31-rt45/arch/arm/boot/dts/*.dts boot/dtbs   # Copying new dtbs

sudo umount $boot_partition
rm -rf boot

echo "[TRANSFER] Transfering Linux Modules to rootfs/"
mkdir rootfs
sudo e2fsck -fyc $root_partition   # Necessary because sometimes it throws the message "No space left on device"
sudo mount $root_partition rootfs

sudo rm -rf rootfs/lib/modules
sudo cp -rfv linux_modules/* rootfs/

sudo umount $root_partition
rm -rf rootfs


echo "[TRANSFER] Finished!"
echo "#####################################################################"
