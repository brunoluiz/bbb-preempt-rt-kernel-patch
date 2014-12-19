#!/bin/sh

echo "[MAIN] Checking dependencies..."

if [ ! -z $1 ] 
then 
    :
else
    echo "[MAIN] You need to specify a device! Example: /dev/sdb"
    exit 1
fi

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

echo "[MAIN] Downloading Linux-3.12.31..."
wget http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.12.31.tar.xz
tar -Jxvf linux-3.12.31.tar.xz
mv linux-3.12.31 linux-3.12.31-rt45

echo "[MAIN] Downloading Debian 7.5 image"
wget http://debian.beagleboard.org/images/bone-debian-7.5-2014-05-14-2gb.img.xz
echo "[MAIN] Extracting Debian image"
xz -d bone-debian-7.5-2014-05-14-2gb.img.xz

echo "#####################################################################"