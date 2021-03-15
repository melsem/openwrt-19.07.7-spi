#
# Copyright (C) 2013-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.

define KernelPackage/rtc-sunxi
    SUBMENU:=$(OTHER_MENU)
    TITLE:=Sunxi SoC built-in RTC support
    DEPENDS:=@TARGET_sunxi
    $(call AddDepends/rtc)
    KCONFIG:= \
	CONFIG_RTC_DRV_SUNXI \
	CONFIG_RTC_CLASS=y
    FILES:=$(LINUX_DIR)/drivers/rtc/rtc-sunxi.ko
    AUTOLOAD:=$(call AutoLoad,50,rtc-sunxi)
endef

define KernelPackage/rtc-sunxi/description
 Support for the AllWinner sunXi SoC's onboard RTC
endef

$(eval $(call KernelPackage,rtc-sunxi))

define KernelPackage/sunxi-ir
    SUBMENU:=$(OTHER_MENU)
    TITLE:=Sunxi SoC built-in IR support (A20)
    DEPENDS:=@TARGET_sunxi +kmod-input-core +v4l-utils +triggerhappy
    $(call AddDepends/rtc)
    KCONFIG:= \
	CONFIG_MEDIA_SUPPORT=y \
	CONFIG_MEDIA_RC_SUPPORT=y \
	CONFIG_RC_DEVICES=y \
	CONFIG_IR_SUNXI \
	CONFIG_RC_DECODERS=y \
	CONFIG_RC_CORE=m \
	CONFIG_RC_MAP=m \
	CONFIG_LIRC=y \
	CONFIG_BPF_LIRC_MODE2=y \
	CONFIG_IR_NEC_DECODER=m \
	CONFIG_IR_RC5_DECODER=m \
	CONFIG_IR_RC6_DECODER=m \
	CONFIG_IR_JVC_DECODER=m \
	CONFIG_IR_SONY_DECODER=m \
	CONFIG_IR_SANYO_DECODER=m \
	CONFIG_IR_SHARP_DECODER=m \
	CONFIG_IR_MCE_KBD_DECODER=m \
	CONFIG_IR_XMP_DECODER=m \
	CONFIG_IR_IMON_DECODER=m \
	CONFIG_IR_IMON_RAW=m \
	CONFIG_IR_SPI=m \
	CONFIG_IR_PWM_TX=m \
	CONFIG_IR_SERIAL=m \
	CONFIG_IR_SERIAL_TRANSMITTER=y \
	CONFIG_IR_SIR=m \
	CONFIG_IR_GPIO_TX=m
    FILES:= \
	$(LINUX_DIR)/drivers/media/rc/gpio-ir-tx.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-jvc-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-mce_kbd-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-nec-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-rc5-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-rc6-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-sanyo-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-sharp-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-sony-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-spi.ko \
	$(LINUX_DIR)/drivers/media/rc/ir-xmp-decoder.ko \
	$(LINUX_DIR)/drivers/media/rc/lirc_dev.ko \
	$(LINUX_DIR)/drivers/media/rc/pwm-ir-tx.ko \
	$(LINUX_DIR)/drivers/media/rc/rc-core.ko \
	$(LINUX_DIR)/drivers/media/rc/serial_ir.ko \
	$(LINUX_DIR)/drivers/media/rc/sir_ir.ko \
	$(LINUX_DIR)/drivers/media/rc/sunxi-cir.ko \
	$(LINUX_DIR)/drivers/media/rc/keymaps/*.ko
    AUTOLOAD:=$(call AutoLoad,80,sunxi-cir ir-nec-decoder)
endef

define KernelPackage/sunxi-ir/description
 Support for the AllWinner sunXi SoC's onboard IR (A20)
endef

$(eval $(call KernelPackage,sunxi-ir))

define KernelPackage/ata-sunxi
    TITLE:=AllWinner sunXi AHCI SATA support
    SUBMENU:=$(BLOCK_MENU)
    DEPENDS:=@TARGET_sunxi +kmod-ata-ahci-platform +kmod-scsi-core
    KCONFIG:=CONFIG_AHCI_SUNXI
    FILES:=$(LINUX_DIR)/drivers/ata/ahci_sunxi.ko
    AUTOLOAD:=$(call AutoLoad,41,ahci_sunxi,1)
endef

define KernelPackage/ata-sunxi/description
 SATA support for the AllWinner sunXi SoC's onboard AHCI SATA
endef

$(eval $(call KernelPackage,ata-sunxi))

define KernelPackage/sun4i-emac
  SUBMENU:=$(NETWORK_DEVICES_MENU)
  TITLE:=AllWinner EMAC Ethernet support
  DEPENDS:=@TARGET_sunxi +kmod-of-mdio +kmod-libphy
  KCONFIG:=CONFIG_SUN4I_EMAC
  FILES:=$(LINUX_DIR)/drivers/net/ethernet/allwinner/sun4i-emac.ko
  AUTOLOAD:=$(call AutoProbe,sun4i-emac)
endef

$(eval $(call KernelPackage,sun4i-emac))


define KernelPackage/sound-soc-sun4i-codec
  TITLE:=AllWinner built-in SoC sound support sun4i-codec
  KCONFIG:=CONFIG_SND_SUN4I_CODEC
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun4i-codec.ko
  AUTOLOAD:=$(call AutoLoad,63,sun4i-codec)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sun4i-codec/description
  Kernel support for AllWinner built-in SoC audio sun4i-codec
endef

$(eval $(call KernelPackage,sound-soc-sun4i-codec))


define KernelPackage/sound-soc-sun8i-codec
  TITLE:=AllWinner SoC sound sun8i-codec
  KCONFIG:=CONFIG_SND_SUN8I_CODEC
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun8i-codec.ko
  AUTOLOAD:=$(call AutoLoad,65,sun8i-codec)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sun8i-codec/description
  Kernel support for AllWinner built-in SoC audio sun8i-codec
endef

$(eval $(call KernelPackage,sound-soc-sun8i-codec))


define KernelPackage/sound-soc-sun8i-codec-analog
  TITLE:=AllWinner SoC sound sun8i-codec-analog
  KCONFIG:=CONFIG_SND_SUN8I_CODEC_ANALOG
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun8i-codec-analog.ko
  AUTOLOAD:=$(call AutoLoad,67,sun8i-codec-analog)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sun8i-codec-analog/description
  Kernel support for AllWinner built-in SoC audio sun8i-codec-analog
endef

$(eval $(call KernelPackage,sound-soc-sun8i-codec-analog))


define KernelPackage/sound-soc-sun4i-i2s
  TITLE:=AllWinner SoC sound sun4i-i2s
  KCONFIG:=CONFIG_SND_SUN4I_I2S
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun4i-i2s.ko
  AUTOLOAD:=$(call AutoLoad,67,sun4i-i2s)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sun4i-i2s/description
  Kernel support for AllWinner built-in SoC audio sun4i-i2s
endef

$(eval $(call KernelPackage,sound-soc-sun4i-i2s))


define KernelPackage/sound-soc-sun4i-spdif
  TITLE:=AllWinner SoC sound sun4i-spdif
  KCONFIG:=CONFIG_SND_SUN4I_SPDIF
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun4i-spdif.ko
  AUTOLOAD:=$(call AutoLoad,67,sun4i-spdif)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sun4i-spdif/description
  Kernel support for AllWinner built-in SoC audio sun4i-spdif
endef

$(eval $(call KernelPackage,sound-soc-sun4i-spdif))

###################################################################
define KernelPackage/thermal-sunxi
  SUBMENU:=Sunxi Thermal
  TITLE:=Generic Thermal sysfs driver
  DEPENDS:=@TARGET_sunxi +kmod-hwmon-core
  KCONFIG:= \
	CONFIG_THERMAL=m \
	CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=n \
	CONFIG_THERMAL_GOV_USER_SPACE=n \
	CONFIG_THERMAL_EMULATION=n
  FILES:= \
	$(LINUX_DIR)/drivers/thermal/thermal_sys.ko
  AUTOLOAD:=$(call AutoProbe,thermal_sys)
endef

define KernelPackage/thermal/description
 Generic Thermal Sysfs driver offers a generic mechanism for thermal
 management. Usually it's made up of one or more thermal zone and cooling
 device.
endef

$(eval $(call KernelPackage,thermal-sunxi))


define KernelPackage/sun4i-gpadc-iio
  SUBMENU:=Sunxi Thermal
  TITLE:=Generic sun4i-gpadc-iio driver
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi
  KCONFIG:=CONFIG_SUN4I_GPADC=y \
	CONFIG_MFD_SUN4I_GPADC=n
  FILES:= \
	$(LINUX_DIR)/drivers/iio/adc/sun4i-gpadc-iio.ko
  AUTOLOAD:=$(call AutoProbe,sun4i-gpadc-iio)
endef

$(eval $(call KernelPackage,sun4i-gpadc-iio))


define KernelPackage/sun8i_ths
  SUBMENU:=Sunxi Thermal
  TITLE:=Generic SUN8I_THS driver
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi
  KCONFIG:=CONFIG_SUN8I_THS=m
  FILES:=$(LINUX_DIR)/drivers/thermal/sun8i_ths.ko
  AUTOLOAD:=$(call AutoProbe,sun8i_ths)
endef

define KernelPackage/thermal/description
 Generic SUN8I_THS driver offers a generic mechanism for thermal
 management. Usually it's made up of one or more thermal zone and cooling
 device.
endef

$(eval $(call KernelPackage,sun8i_ths))


define KernelPackage/sun50i_h6_ths
  SUBMENU:=Sunxi Thermal
  TITLE:=Generic SUN50I_H6_THS driver
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi
  KCONFIG:=CONFIG_SUN50I_H6_THS=m
  FILES:=$(LINUX_DIR)/drivers/thermal/sun50i_h6_ths.ko
  AUTOLOAD:=$(call AutoProbe,sun50i_h6_ths)
endef

define KernelPackage/thermal/description
 Generic SUN50I_H6_THS driver offers a generic mechanism for thermal
 management. Usually it's made up of one or more thermal zone and cooling
 device.
endef

$(eval $(call KernelPackage,sun50i_h6_ths))


define KernelPackage/thermal-generic-adc
  SUBMENU:=Sunxi Thermal
  TITLE:=Generic GENERIC_ADC_THERMAL driver
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi
  KCONFIG:=CONFIG_GENERIC_ADC_THERMAL=m
  FILES:=$(LINUX_DIR)/drivers/thermal/thermal-generic-adc.ko
  AUTOLOAD:=$(call AutoProbe,thermal-generic-adc)
endef

$(eval $(call KernelPackage,thermal-generic-adc))


define KernelPackage/arm_big_little
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic arm_big_little driver
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi
  KCONFIG:=CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
  FILES:=$(LINUX_DIR)/drivers/cpufreq/arm_big_little.ko
  AUTOLOAD:=$(call AutoProbe,arm_big_little)
endef

$(eval $(call KernelPackage,arm_big_little))


define KernelPackage/arm_big_little_dt
  SUBMENU:=$(OTHER_MENU)
  TITLE:=This enables the Generic CPUfreq driver for ARM big.LITTLE platforms.
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi +kmod-arm_big_little
  KCONFIG:=CONFIG_ARM_DT_BL_CPUFREQ=y
  FILES:=$(LINUX_DIR)/drivers/cpufreq/arm_big_little_dt.ko
  AUTOLOAD:=$(call AutoProbe,arm_big_little_dt)
endef

$(eval $(call KernelPackage,arm_big_little_dt))


define KernelPackage/cpufreq-dt
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic cpufreq-dt driver
  DEPENDS:=@TARGET_sunxi +kmod-thermal-sunxi
  KCONFIG:=CONFIG_CPUFREQ_DT_PLATDEV=y
  FILES:=$(LINUX_DIR)/drivers/cpufreq/cpufreq-dt.ko
  AUTOLOAD:=$(call AutoProbe,cpufreq-dt)
endef

$(eval $(call KernelPackage,cpufreq-dt))
###################################################################

define KernelPackage/sunxi-i2c
  SUBMENU:=I2C support
  TITLE:=Generic sunxi-i2c driver
  DEPENDS:=@TARGET_sunxi +kmod-i2c-core
  KCONFIG:=CONFIG_I2C_SUN6I_P2WI=m \
	CONFIG_I2C_MV64XXX=m
  FILES:= \
	$(LINUX_DIR)/drivers/i2c/busses/i2c-mv64xxx.ko
  AUTOLOAD:=$(call AutoProbe,i2c-mv64xxx)
endef

define KernelPackage/sunxi-i2c/description
 If you say yes to this option, support will be included for the
 I2C interface from Allwinner Technology sunxi platform.
 
 This driver can also be built as a module. If so, the module
 will be called i2c-sun6i-p2wi, i2c-mv64xxx.
endef

$(eval $(call KernelPackage,sunxi-i2c))

######### wireless drivers #########################
#define KernelPackage/rtl8189es
#  SUBMENU:=$(WIRELESS_MENU) Test-rtl8189es
#  TITLE:=RTL8189es test wifi-drivers support
#  KCONFIG:=CONFIG_RTL8189ES \
#	CONFIG_WLAN_VENDOR_REALTEK=y
#  FILES:=$(LINUX_DIR)/drivers/net/wireless/realtek/rtl8189es/8189es.ko
#  DEPENDS:=@TARGET_sunxi +kmod-usb-core +kmod-usb-net +@DRIVER_11N_SUPPORT +@DRIVER_11AC_SUPPORT
##  AUTOLOAD:=$(call AutoProbe,rtl8189es)
#  AUTOLOAD:=$(call AutoLoad,50,8189es)
#endef
#
#$(eval $(call KernelPackage,rtl8189es))
#####################################################


define KernelPackage/pwm-sun4i
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic pwm-sun4i driver
  DEPENDS:=@TARGET_sunxi
  KCONFIG:= \
	CONFIG_PWM=y \
	CONFIG_PWM_SYSFS=y \
	CONFIG_PWM_SUN4I=m
  FILES:=$(LINUX_DIR)/drivers/pwm/pwm-sun4i.ko
  AUTOLOAD:=$(call AutoProbe,pwm-sun4i)
endef

$(eval $(call KernelPackage,pwm-sun4i))


define KernelPackage/pwm-regulator
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic pwm-regulator driver
  DEPENDS:=@TARGET_sunxi
  KCONFIG:= \
	CONFIG_REGULATOR_PWM=m
  FILES:=$(LINUX_DIR)/drivers/regulator/pwm-regulator.ko
  AUTOLOAD:=$(call AutoProbe,pwm-regulator)
endef

$(eval $(call KernelPackage,pwm-regulator))


define KernelPackage/clk-pwm
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic clk-pwm driver
  DEPENDS:=@TARGET_sunxi
  KCONFIG:= \
	CONFIG_COMMON_CLK_PWM=m
  FILES:=$(LINUX_DIR)/drivers/clk/clk-pwm.ko
  AUTOLOAD:=$(call AutoProbe,clk-pwm)
endef

$(eval $(call KernelPackage,clk-pwm))


define KernelPackage/rotary_encoder
  SUBMENU:=$(OTHER_MENU)
  TITLE:=Generic rotary_encoder driver
  DEPENDS:=@TARGET_sunxi +kmod-input-gpio-keys +triggerhappy
  KCONFIG:= \
	CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
  FILES:=$(LINUX_DIR)/drivers/input/misc/rotary_encoder.ko
  AUTOLOAD:=$(call AutoProbe,rotary_encoder)
endef

$(eval $(call KernelPackage,rotary_encoder))
