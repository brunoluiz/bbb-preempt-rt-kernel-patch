#!/bin/sh

echo "[OSADL] Downloading patches..."
mkdir patches
cd patches
wget https://www.osadl.org/monitoring/patches/r7s8/series
for i in `cat series`
do
  wget https://www.osadl.org/monitoring/patches/r7s8/$i
done
cd ..

echo "[OSADL] Downloading .config file..."
mkdir config
wget https://www.osadl.org/monitoring/configs/r7s8.config.gz --no-check-certificate -O config/r7s8.config.gz

echo "[OSADL] Downloading AM335x firmware file..."
mkdir firmware
wget http://arago-project.org/git/projects/?p=am33x-cm3.git\;a=blob_plain\;f=bin/am335x-pm-firmware.bin\;hb=HEAD -O firmware/am335x-pm-firmware.bin