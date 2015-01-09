#!/bin/bash

linuxpath=$1

if [ ! -z $path ] 
then 
    :
else
    linuxpath="linux-3.12.31-rt45"
fi

echo "[OSADL] Init"

echo "[OSADL] Copying .config to linux folder..."
cp -rf config/r7s8.config $linuxpath/.config

echo "[OSADL] Copying AM335x firmware file to linux folder..."
cp -rf firmware/ $linuxpath

echo "[OSADL] Copying patches files to linux folder..."
cp -rf patches/  $linuxpath

echo "[OSADL] Patching Linux source"
cd $linuxpath
quilt push -a

cd ..

echo "[OSADL] End"

echo "#####################################################################"