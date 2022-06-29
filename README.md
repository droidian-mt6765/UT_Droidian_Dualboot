# UT_Droidian_Dualboot
These set of desktop files and scripts let you dual boot Droidian and Ubuntu Touch

This is a fork of my repository for miatoll but unlike that repository it's done with OrangeFox recovery.

Here is a quick rundown of how to make them work.

First off this guide assumes that you have a working Ubuntu Touch setup and a working Droidian setup and it will continue from there.

# Installing dependencies
Now open up your a shell and run the following commands to install needed dependencies:

sudo apt update

sudo apt install git aria2 build-essential sudo unzip wget xz-utils fastboot adb -y

Alright now we need to clone device repository and build it with our modifications.

# Cloning the repository and building
git clone https://gitlab.com/OrangeFox/misc/scripts

cd scripts

sudo bash setup/android_build_env.sh

sudo bash setup/install_android_sdk.sh

mkdir ~/OrangeFox_sync

cd ~/OrangeFox_sync

git clone https://gitlab.com/OrangeFox/sync.git

cd ~/OrangeFox_sync/sync/

./orangefox_sync.sh --branch 11.0 --path ~/fox_11.0

cd ~/fox_11.0

git clone https://gitlab.com/OrangeFox/device/garden device/xiaomi/garden

So up until this point we cloned the OrangeFox repository now we must add our own changes to the repository:

cd device/xiaomi/garden/recovery/root/

Now add init.recovery.mt6765.rc and init.recovery.mt6762.rc from this git repository to this directory.
After that also put boot_switch.sh inside of system/bin.
And now we can continue with the rest of the build

cd ~/fox_11.0

source build/envsetup.sh && export ALLOW_MISSING_DEPENDENCIES=true && export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1 && export LC_ALL="C"

lunch twrp_garden-eng && mka recoveryimage

# Flashing
After it is done building do:

cd out/target/product/garden/

Now plug your device into your computer and boot into Fastboot mode and run the following:

fastboot flash recovery OrangeFox-xxxxxxxxx.img (adjust this file name to the file in this directory)

fastboot reboot recovery

Download latest Droidian and Ubuntu Touch boot image file and rename them to 

boot_ut.img for Ubuntu Touch and boot_droidian.img for Droidian.

Open the terminal once again and move into the directory that the boot image files are located in then plug your device in while inside UBports recovery and run:

adb shell mount /data && adb push boot_ut.img /data && adb push boot_droidian.img /data

Now boot into system.

# Installing desktop files
To install desktop icons to each of the OSes run this script in the terminal of that OS:

bash <(wget -qO - https://bardia.tech/desktopfile-install)

After installing you can switch between the OSes by pressing on the icon of that OS.

When you try to switch your OS it will boot into recovery. After it has booted into recovery unline my recovery for miatoll this one requires a bit of user interaction.
Open the terminal and run "boot_switch.sh". Now if you reboot it should boot into the correct OS.

There is also a precompiled version of recovery available in this repository which can be flashed in fastboot.
Keep in mind that it might be outdated.

Keep in mind to keep the files in /userdata/ updated (boot_ut.img and boot_droidian.img)

For UT updates new kernel (if the kernel is updated at all) can be found at UBports Gitlab.

For Droidian when doing apt upgrade new kernel is found at /boot (if kernel gets updated), It can be renamed to boot_droidian and placed in /userdata.

The reason I used OrangeFox and not UBports recovery was because at the time of writing UBports recovery does not work on garden (angelica, dandelion).

I'm not responsible for bricked devices, dead SD cards, thermonuclear war, or you getting fired because the alarm app failed.
Please do some research if you have any concerns about features included in the products you find here before flashing it!
YOU are choosing to make these modifications, and if you point the finger at me for messing up your device, I will laugh at you.
