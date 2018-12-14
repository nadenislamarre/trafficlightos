################################################################################
#
# busybox_initramfs
#
################################################################################

TRAFFICLIGHT_INITRAMFS_VERSION = 1.24.2
TRAFFICLIGHT_INITRAMFS_SITE = http://www.busybox.net/downloads
TRAFFICLIGHT_INITRAMFS_SOURCE = busybox-$(TRAFFICLIGHT_INITRAMFS_VERSION).tar.bz2
TRAFFICLIGHT_INITRAMFS_LICENSE = GPLv2
TRAFFICLIGHT_INITRAMFS_LICENSE_FILES = LICENSE

TRAFFICLIGHT_INITRAMFS_CFLAGS = $(TARGET_CFLAGS)
TRAFFICLIGHT_INITRAMFS_LDFLAGS = $(TARGET_LDFLAGS)

TRAFFICLIGHT_INITRAMFS_KCONFIG_FILE = "package/trafficlight-initramfs/busybox.config"

INITRAMFS_DIR=$(BINARIES_DIR)/initramfs

# Allows the build system to tweak CFLAGS
TRAFFICLIGHT_INITRAMFS_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	CFLAGS="$(TRAFFICLIGHT_INITRAMFS_CFLAGS)"
TRAFFICLIGHT_INITRAMFS_MAKE_OPTS = \
	CC="$(TARGET_CC)" \
	ARCH=$(KERNEL_ARCH) \
	PREFIX="$(INITRAMFS_DIR)" \
	EXTRA_LDFLAGS="$(TRAFFICLIGHT_INITRAMFS_LDFLAGS)" \
	CROSS_COMPILE="$(TARGET_CROSS)" \
	CONFIG_PREFIX="$(INITRAMFS_DIR)" \
	SKIP_STRIP=y

TRAFFICLIGHT_INITRAMFS_KCONFIG_OPTS = $(TRAFFICLIGHT_INITRAMFS_MAKE_OPTS)

define TRAFFICLIGHT_INITRAMFS_BUILD_CMDS
	$(TRAFFICLIGHT_INITRAMFS_MAKE_ENV) $(MAKE) $(TRAFFICLIGHT_INITRAMFS_MAKE_OPTS) -C $(@D)
endef

define TRAFFICLIGHT_INITRAMFS_INSTALL_TARGET_CMDS
	mkdir -p $(INITRAMFS_DIR)
	cp package/trafficlight-initramfs/init $(INITRAMFS_DIR)/init
	$(TRAFFICLIGHT_INITRAMFS_MAKE_ENV) $(MAKE) $(TRAFFICLIGHT_INITRAMFS_MAKE_OPTS) -C $(@D) install
	(cd $(INITRAMFS_DIR) && find . | cpio -H newc -o | gzip -9 > $(BINARIES_DIR)/initrd.gz)
endef

$(eval $(kconfig-package))