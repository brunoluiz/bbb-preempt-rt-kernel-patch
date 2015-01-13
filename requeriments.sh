#!/bin/bash

source vars.sh

echo "[MAIN] Checking dependencies..."

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
  exit 0
fi

mkdir downloads
cd downloads

if [ ! -f  "./linux-3.12.31.tar.xz" ]; then
  echo "[MAIN] Downloading Linux..."
  wget "$linux_webdir"/"$linux_ver".tar.xz
fi
tar -Jxvf "$linux_ver".tar.xz
mv $linux_ver ../$linuxpath

if [ ! -f  $debian_file ]; then
  echo "[MAIN] Downloading Debian image"
  wget "$debian_webdir"/"$debian_file".xz
  echo "[MAIN] Extracting Debian image"
  xz -d "$debian_file".xz
fi

cd ..

echo "#####################################################################"
