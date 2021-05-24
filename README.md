The develope "tr4bl3" (http://4pda.ru/forum/index.php?showuser=1177645).
-------------------
Example write in spi-flash 16MB for orangepi-zero.
----
https://github.com/melsem/openwrt-19.07.7-spi/blob/master/make-menuconfig.png
1. Download the usual firmware image for MMС: https://downloads.openwrt.org/releases/19.07.7/targets/sunxi/cortexa7/openwrt-19.07.7-sunxi-cortexa7-sun8i-h2-plus-orangepi-zero-ext4-sdcard.img.gz

2. Record it on MMС.

3. On the MMC flash drive, in the recorded firmware image, in the /boot folder, delete the dtb file.

4. Download the dtb file to /boot folder:  (https://github.com/melsem/openwrt-19.07.7-spi/raw/master/sun8i-h2-plus-orangepi-zero-dtb)
And rename it to dtb.

5. Insert this MMC flash drive into orangepi and apply power.

6. And on orangepi do it:
 * Download the bootloader file to /tmp: (https://github.com/melsem/openwrt-19.07.7-spi/raw/master/sun8i-h2-plus_orangepi-zero-boot.bin)
 * Download the dtb file to /tmp:  (https://github.com/melsem/openwrt-19.07.7-spi/raw/master/sun8i-h2-plus-orangepi-zero-dtb)
 * Download the firmware file to /tmp: (https://github.com/melsem/openwrt-19.07.7-spi/raw/master/sun8i-h2-plus-orangepi-zero-squashfs-sysupgrade.bin)
 * and run the commands:
```
cd /tmp
mtd -e uboot write sun8i-h2-plus_orangepi-zero-boot.bin uboot
mtd -e dtb write sun8i-h2-plus-orangepi-zero-dtb dtb
mtd -e firmware write sun8i-h2-plus-orangepi-zero-squashfs-sysupgrade.bin firmware
```
* Wait for each command to complete and turn off the power.
* Remove the MMC flash drive and turn on the power.
* And the orangepi will boot from the SPI flash drive ..

7. Edit basic boot configuration: 
http://192.168.10.1/boot
```
on/off wifi, audio, i2c, usb2-3, irc, gpio-keys-user, rotary encoder.
```
8. Set checkmarks, click save.
And then click Apply. Orange Pi reboots.

But in order for the Wi-Fi to work, you need to give the "reboot" command again.
Or turn the power off and on.

And then, as always, tune in to Luci. 192.168.10.1

```
[    0.422624] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    0.444590] 1c28000.serial: ttyS0 at MMIO 0x1c28000 (irq = 42, base_baud = 1500000) is a U6_16550A
[    1.046026] console [ttyS0] enabled
[    1.054254] loop: module loaded
[    1.059496] m25p80 spi0.0: found w25q128, expected mx25l1606e
[    1.069941] random: fast init done
[    1.075995] m25p80 spi0.0: w25q128 (16384 Kbytes)
[    1.080735] 3 fixed-partitions partitions found on MTD device spi0.0
[    1.087109] Creating 3 MTD partitions on "spi0.0":
[    1.091920] 0x000000000000-0x000000080000 : "uboot"
[    1.097540] 0x000000080000-0x000000090000 : "dtb"
[    1.102842] 0x000000090000-0x000001000000 : "firmware"
[    1.108866] 2 uimage-fw partitions found on MTD device firmware
[    1.114799] Creating 2 MTD partitions on "firmware":
[    1.119793] 0x000000000000-0x0000002a21c8 : "kernel"
[    1.125439] 0x0000002a21c8-0x000000f70000 : "rootfs"
[    1.131001] mtd: device 4 (rootfs) set to be root filesystem
[    1.136825] 1 squashfs-split partitions found on MTD device rootfs
[    1.143015] 0x000000c90000-0x000000f70000 : "rootfs_data"
[    1.149795] libphy: Fixed MDIO Bus: probed
[    1.154339] dwmac-sun8i 1c30000.ethernet: PTP uses main clock

```

===================================================================

_______                     ________        __
 |       |.-----.-----.-----.|  |  |  |.----.|  |_
 |   -   ||  _  |  -__|     ||  |  |  ||   _||   _|
 |_______||   __|_____|__|__||________||__|  |____|
          |__| W I R E L E S S   F R E E D O M
 -----------------------------------------------------

This is the buildsystem for the OpenWrt Linux distribution.

To build your own firmware you need a Linux, BSD or MacOSX system (case
sensitive filesystem required). Cygwin is unsupported because of the lack
of a case sensitive file system.

You need gcc, binutils, bzip2, flex, python, perl, make, find, grep, diff,
unzip, gawk, getopt, subversion, libz-dev and libc headers installed.

1. Run "./scripts/feeds update -a" to obtain all the latest package definitions
defined in feeds.conf / feeds.conf.default

2. Run "./scripts/feeds install -a" to install symlinks for all obtained
packages into package/feeds/

3. Run "make menuconfig" to select your preferred configuration for the
toolchain, target system & firmware packages.

4. Run "make" to build your firmware. This will download all sources, build
the cross-compile toolchain and then cross-compile the Linux kernel & all
chosen applications for your target system.

Sunshine!
	Your OpenWrt Community
	http://www.openwrt.org


