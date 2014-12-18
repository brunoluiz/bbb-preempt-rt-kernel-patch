#!/bin/sh

linuxpath="linux-3.12.31-rt45"
device=$1

echo "\n"
echo "Starting process... Go and make some coffee now"
echo "[MAIN] device=$device"
echo "[MAIN] linuxpath=$linuxpath"
echo "\n"

./requeriments.sh

./osald-patch.sh

./compile-kernel.sh $linuxpath

./transfer.sh $device

echo "Just boot now!"