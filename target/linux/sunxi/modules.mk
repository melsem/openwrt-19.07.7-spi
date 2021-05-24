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
	CONFIG_IR_SUNXI=m \
	CONFIG_RC_CORE=m \
	CONFIG_RC_DECODERS=y \
	CONFIG_RC_DEVICES=y \
	CONFIG_RC_MAP=m \
	CONFIG_IR_LIRC_CODEC=m \
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
	CONFIG_IR_RCMM_DECODER=n \
	CONFIG_IR_IMON_RAW=m \
	CONFIG_IR_SPI=m \
	CONFIG_IR_PWM_TX=m \
	CONFIG_IR_SERIAL=m \
	CONFIG_IR_SERIAL_TRANSMITTER=y \
	CONFIG_IR_SIR=m \
	CONFIG_RC_XBOX_DVD=n \
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
	$(LINUX_DIR)/drivers/media/rc/pwm-ir-tx.ko \
	$(LINUX_DIR)/drivers/media/rc/serial_ir.ko \
	$(LINUX_DIR)/drivers/media/rc/sir_ir.ko \
	$(LINUX_DIR)/drivers/media/rc/rc-core.ko \
	$(LINUX_DIR)/drivers/media/rc/sunxi-cir.ko
#	$(LINUX_DIR)/drivers/media/rc/keymaps/*.ko \
#	$(LINUX_DIR)/drivers/media/rc/rc-core.ko \
#	$(LINUX_DIR)/drivers/media/rc/lirc_dev.ko
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

define KernelPackage/sound-soc-sunxi
  TITLE:=AllWinner built-in SoC sound support
  KCONFIG:=CONFIG_SND_SUN4I_CODEC
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun4i-codec.ko
  AUTOLOAD:=$(call AutoLoad,65,sun4i-codec)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sunxi/description
  Kernel support for AllWinner built-in SoC audio sun4i-codec
endef

$(eval $(call KernelPackage,sound-soc-sunxi))

define KernelPackage/sound-soc-sunxi-spdif
  TITLE:=Allwinner A10 SPDIF Support
  KCONFIG:=CONFIG_SND_SUN4I_SPDIF
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun4i-spdif.ko
  AUTOLOAD:=$(call AutoLoad,65,sun4i-spdif)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-spdif
  $(call AddDepends/sound)
endef

define KernelPackage/sound-soc-sunxi-spdif/description
  Kernel support for Allwinner A10 SPDIF Support
endef

$(eval $(call KernelPackage,sound-soc-sunxi-spdif))


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


define KernelPackage/sun8i-adda-pr-regmap
  TITLE:=AllWinner SoC sound sun4i-spdif
  KCONFIG:=CONFIG_SND_SUN8I_ADDA_PR_REGMAP
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun8i-adda-pr-regmap.ko
  AUTOLOAD:=$(call AutoLoad,67,sun8i-adda-pr-regmap)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core
  $(call AddDepends/sound)
endef

define KernelPackage/sun8i-adda-pr-regmap/description
  Kernel support for AllWinner built-in SoC audio sun8i-adda-pr-regmap
endef

$(eval $(call KernelPackage,sun8i-adda-pr-regmap))


define KernelPackage/sound-soc-sun8i-codec-analog
  TITLE:=AllWinner SoC sound sun8i-codec-analog
  KCONFIG:=CONFIG_SND_SUN8I_CODEC_ANALOG
  FILES:=$(LINUX_DIR)/sound/soc/sunxi/sun8i-codec-analog.ko
  AUTOLOAD:=$(call AutoLoad,67,sun8i-codec-analog)
  DEPENDS:=@TARGET_sunxi +kmod-sound-soc-core +kmod-sun8i-adda-pr-regmap
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

## thermal


define KernelPackage/thermal-generic-adc
  SUBMENU:=Sunxi Thermal
  TITLE:=Generic GENERIC_ADC_THERMAL driver
  DEPENDS:=@TARGET_sunxi
  KCONFIG:=CONFIG_GENERIC_ADC_THERMAL=m
  FILES:=$(LINUX_DIR)/drivers/thermal/thermal-generic-adc.ko
  AUTOLOAD:=$(call AutoProbe,thermal-generic-adc)
endef

$(eval $(call KernelPackage,thermal-generic-adc))
