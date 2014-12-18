#!/bin/sh

echo "[OSADL] Init"

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

cd ..

echo "[OSADL] End"

echo "#####################################################################"