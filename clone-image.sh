#!/bin/bash

echo "[CLONE] Init"

if [ ! -z $1 ] 
then 
    :
else
    echo "[MAIN] You need to specify a device! Example: /dev/sdb"
    exit 1
fi

echo "[CLONE] Cloning Debian img to device"
sudo dd if=bone-debian-7.5-2014-05-14-2gb.img of="$1" bs=1M conv=noerror,sync
sync
sleep 30

echo "[CLONE] Cloned!"
echo "#####################################################################"
