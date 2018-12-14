################################################################################
#
# clewarecontrol
#
################################################################################

CLEWARECONTROL_SOURCE =

define CLEWARECONTROL_EXTRACT_CMDS
	cp -r package/clewarecontrol/src/* $(@D)
endef

define CLEWARECONTROL_BUILD_CMDS
	$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)
endef

define CLEWARECONTROL_INSTALL_TARGET_CMDS
	cp $(@D)/clewarecontrol $(TARGET_DIR)/usr/bin/clewarecontrol
        mkdir -p $(TARGET_DIR)/usr/share/clewarecontrol_server
        cp -pr $(@D)/webserver/* $(TARGET_DIR)/usr/share/clewarecontrol_server/
	cp package/clewarecontrol/S60traffic $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
