#!/bin/sh

if grep -s '/data ' /proc/mounts; then
   true
else
   mount -t ext4 /dev/block/platform/bootdevice/by-name/userdata /data
fi

if [ -f /data/.BOOT_UT ]; then
   dd if=/data/boot_ut.img of=/dev/block/platform/bootdevice/by-name/boot
   rm /data/.BOOT_UT
elif [ -f /data/.BOOT_DROIDIAN ]; then
   dd if=/data/boot_droidian.img of=/dev/block/platform/bootdevice/by-name/boot
   rm /data/.BOOT_DROIDIAN
else
   true
fi
