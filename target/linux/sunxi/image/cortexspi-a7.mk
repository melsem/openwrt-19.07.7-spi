#
ifeq ($(SUBTARGET),cortexspia7)

define Build/append-uboot
       dd if=$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot-with-spl.bin >> $@
endef

define Build/append-scr
       dd if=$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-boot.scr >> $@
endef

define Build/append-dtb
       dd if=$(DTS_DIR)/$(SUNXI_DTS).dtb >> $@
endef


define Device/sun8i-h2-plus-orangepi-zero
  DEVICE_TITLE:=Xunlong Orange Pi Zero
  FILESYSTEMS := squashfs
  IMAGES := sysupgrade.bin dtb fullflash.bin boot.bin # SCR.bin
  IMAGE_SIZE := 15808k
  BOOT_SIZE := 512k
  DTB_SIZE := 64k
  BLOCKSIZE := 4k
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata | check-size $$$$(IMAGE_SIZE)
  IMAGE/fullflash.bin := append-uboot | pad-to $$$$(BOOT_SIZE) | append-dtb | pad-to $$$$(DTB_SIZE) | \
			append-kernel | append-rootfs | pad-rootfs
  IMAGE/boot.bin := append-uboot | pad-to $$$$(BLOCKSIZE)
#  IMAGE/SCR.bin := append-scr | pad-to $$$$(BLOCKSIZE)
  IMAGE/dtb := append-dtb | pad-to $$$$(BLOCKSIZE)
  DEVICE_PACKAGES:=kmod-rtc-sunxi kmod-xradio \
	boot-config
  SUPPORTED_DEVICES:=xunlong,orangepi-zero
  SUNXI_DTS:=sun8i-h2-plus-orangepi-zero
endef

TARGET_DEVICES += sun8i-h2-plus-orangepi-zero


define Device/sun8i-h2-plus-orangepi-zero-lts
  DEVICE_TITLE:=Xunlong Orange Pi Zero LTS
  FILESYSTEMS := squashfs
  IMAGES := sysupgrade.bin dtb fullflash.bin boot.bin # SCR.bin
  FULLFLASH_SIZE := 16384K
  IMAGE_SIZE := 15808k
  BOOT_SIZE := 512k
  DTB_SIZE := 64k
  BLOCKSIZE := 4k
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata | check-size $$$$(IMAGE_SIZE)
  IMAGE/fullflash.bin := append-uboot | pad-to $$$$(BOOT_SIZE) | append-dtb | pad-to $$$$(DTB_SIZE) | \
			append-kernel | append-rootfs | pad-rootfs
  IMAGE/boot.bin := append-uboot | pad-to $$$$(BLOCKSIZE)
#  IMAGE/SCR.bin := append-scr | pad-to $$$$(BLOCKSIZE)
  IMAGE/dtb := append-dtb | pad-to $$$$(BLOCKSIZE)
  DEVICE_PACKAGES:=kmod-rtc-sunxi kmod-xradio \
	boot-config
  SUPPORTED_DEVICES:=xunlong,orangepi-zero-lts
  SUNXI_DTS:=sun8i-h2-plus-orangepi-zero-lts
endef

TARGET_DEVICES += sun8i-h2-plus-orangepi-zero-lts


define Device/sun8i-h2-plus-orangepi-r1
  DEVICE_TITLE:=Xunlong Orange Pi R1
  FILESYSTEMS := squashfs
  IMAGES := sysupgrade.bin dtb fullflash.bin boot.bin # SCR.bin
  IMAGE_SIZE := 15808k
  BOOT_SIZE := 512k
  DTB_SIZE := 64k
  BLOCKSIZE := 4k
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata | check-size $$$$(IMAGE_SIZE)
  IMAGE/fullflash.bin := append-uboot | pad-to $$$$(BOOT_SIZE) | append-dtb | pad-to $$$$(DTB_SIZE) | \
			append-kernel | append-rootfs | pad-rootfs
  IMAGE/boot.bin := append-uboot | pad-to $$$$(BLOCKSIZE)
#  IMAGE/SCR.bin := append-scr | pad-to $$$$(BLOCKSIZE)
  IMAGE/dtb := append-dtb | pad-to $$$$(BLOCKSIZE)
  DEVICE_PACKAGES:=kmod-rtc-sunxi kmod-usb-net kmod-usb-net-rtl8152 kmod-rtl8189es \
	boot-config
  SUPPORTED_DEVICES:=xunlong,orangepi-r1
  SUNXI_DTS:=sun8i-h2-plus-orangepi-r1
endef

TARGET_DEVICES += sun8i-h2-plus-orangepi-r1

endif
