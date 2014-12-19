BBB PREEMPT RT patch script
===========================
This script will install a Debian image at your SD card with the Linux preempt rt kernel

How it works?
-------------
You only have to run ```sudo ./build-patch-deploy.sh /dev/sdb``` changing /dev/sdb with the desired device

Workflow
--------
The build-patch-deploy script will:

1. Download linux kernel 3.12 and debian image (requeriments.sh)
2. Apply OSADL patches (enabling PREEMPT RT) at Linux Source (osadl-patch.sh)
3. Compile Linux Kernel (compile-kernel.sh)
4. Copy Debian 7.5 image to your SD card (transfer.sh)
5. Copy the patched kernel to your SD card (transfer.sh)


TransferToSD-only process
-------------------------
If you already downloaded the Debian Image and have compiled the kernel, probably because you already ran the build-patch-deploy, you just need to run ```./transfer.sh /dev/sdb```, changing /dev/sdb with the desired device.

Re-download patches
-------------------
If you want to re-download the OSADL patches you can run ```./osadl-downloads.sh```.

Problems with connection sharing
--------------------------------
If you are sharing the connection with BBB using the USB port, and it is not working, try to run this on BBB:

```
/sbin/route add default gw 192.168.7.1;
echo "nameserver 8.8.8.8" >> /etc/resolv.conf;
```

And this on your Ubuntu (or Debian based) host:

```
sudo iptables -A POSTROUTING -t nat -j MASQUERADE;
sudo echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null;
```

If you don't want to re-run both scripts after reboot, add it to ~/.bashrc