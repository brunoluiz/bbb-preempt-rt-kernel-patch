#!/bin/sh

echo "[SD] Init"

if [ ! -z $1 ] 
then 
    :
else
    echo "[MAIN] You need to specify a device! Example: /dev/sdb"
    exit 1
fi

echo "[SD] Transfering Debian img to device"
sudo dd if=bone-debian-7.5-2014-05-14-2gb.img of="$1" bs=1M
sync

echo "[SD] Transfering Linux PREEMPT RT Kernel to boot/"
mkdir boot
sudo mount "$1"1 boot
cp -f linux-3.12.31-rt45/arch/arm/boot/zImage boot/           # Replacing zImage
sudo rm -rf boot/dtbs/*                                       # Removing the old dtbs
cp -rf linux-3.12.31-rt45/arch/arm/boot/dts/*.dtb boot/dtbs   # Copying new dtbs
cp -rf linux-3.12.31-rt45/arch/arm/boot/dts/*.dts boot/dtbs   # Copying new dtbs
sudo umount boot
rm -rf boot

echo "[SD] Transfering Linux Modules to rootfs/"
mkdir rootfs
sudo mount "$1"2 rootfs
sudo rm -rf rootfs/lib/modules
cp -rf linux_modules/* rootfs/
sudo umount rootfs
rm -rf rootfs

echo "[SD] Finished!"

echo "#####################################################################"