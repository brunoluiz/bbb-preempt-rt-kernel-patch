#!/bin/sh

if [ ! -z $1 ] 
then 
    echo "The choosen device was $1"
else
    echo "You need to specify a device! Example: /dev/sdb"
    exit 1
fi

echo "\n"
echo "Starting process... Go and make some coffee now"
echo "\n"
echo "#####################################################################"
echo "[OSADL] Init"
echo "[OSADL] Checking dependencies..."
notfound=""
for i in wget tar quilt gunzip xz
do
  if ! which $i >/dev/null 2>&1
  then
    notfound="$notfound $i"
  fi
done
if test "$notfound"
then
  if which yum >/dev/null 2>&1
  then
    /bin/echo -en 1>&2 "Please run\n  yum install"
  elif which apt-get >/dev/null 2>&1
  then
    /bin/echo -en 1>&2 "Please run\n  apt-get install"
  else
    /bin/echo -en 1>&2 "Please install\n "
  fi
  echo 1>&2 "$notfound"
  echo 1>&2 before executing this script.
  exit 1
fi

echo "[OSADL] Downloading Linux-3.12.31..."
wget http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.31.tar.xz
tar -Jxvf linux-3.12.31.tar.xz
mv linux-3.12.31 linux-3.12.31-rt45

echo "[OSADL] Unzip .config..."
cd config
gunzip r7s8.config.gz

echo "[OSADL] Copying .config to linux folder..."
cp r7s8.config ../linux-3.12.31-rt45/.config
cd ..

echo "[OSADL] Copying AM335x firmware file to linux folder..."
cp firmware/ linux-3.12.31-rt45 

echo "[OSADL] Copying patches files to linux folder..."
cp patches/  linux-3.12.31-rt45

echo "[OSADL] Patching Linux source"
cd linux-3.12.31-rt45
quilt push -a

echo "[OSADL] End"

# echo "#####################################################################"

# echo "[MAKE] Compiling..."
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j5
# echo "[MAKE] Compiling modules..."
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j5 modules
# echo "[MAKE] Compiling uImage and dtbs..."
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOADADDR=0x80008000 -j5 uImage dtbs
# echo "[MAKE] Modules Install"
# mkdir ../linux_modules
# make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- LOADADDR=0x80008000 -j5 INSTALL_MOD_PATH=../linux_modules modules_install
# echo "[MAKE] Linux Kernel Ready!"

# cd ..
# echo "#####################################################################"

# echo "[SD] Downloading Debian 7.5 image"
# wget http://debian.beagleboard.org/images/bone-debian-7.5-2014-05-14-2gb.img.xz
# echo "[SD] Extracting Debian image"
# xz -d bone-debian-7.5-2014-05-14-2gb.img.xz
# echo "[SD] Transfering img to device"
# sudo dd if=bone-debian-7.5-2014-05-14-2gb.img of="$1" bs=4M

# echo "[SD] Transfering Linux PREEMPT RT Kernel to boot/"
# mkdir boot
# sudo mount "$1"1 boot
# cp -f linux-3.12.31-rt45/arch/arm/boot/zImage boot/           # Replacing zImage
# rm -rf boot/dtbs/*                                            # Removing the old dtbs
# cp -rf linux-3.12.31-rt45/arch/arm/boot/dts/*.dtb boot/dtbs   # Copying new dtbs
# cp -rf linux-3.12.31-rt45/arch/arm/boot/dts/*.dts boot/dtbs   # Copying new dtbs
# sudo umount boot
# rm -rf boot

# echo "[SD] Transfering Linux Modules to rootfs/"
# mkdir rootfs
# sudo mount "$1"2 rootfs
# cp -rf linux_modules/* rootfs/
# sudo umount rootfs
# rm -rf rootfs

# echo "[SD] Finished!"
# echo "#####################################################################"

# echo "Just boot now!"