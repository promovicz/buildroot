################################################################################
#
# systemd-xlogin
#
################################################################################

SYSTEMD_XLOGIN_VERSION = 8a8693ff98fb7ff1e5a7829f09379813f83d91ce
SYSTEMD_XLOGIN_SOURCE = systemd-xlogin-${SYSTEMD_XLOGIN_VERSION}.tar.gz
SYSTEMD_XLOGIN_SITE = $(call github,promovicz,xlogin,$(SYSTEMD_XLOGIN_VERSION))
SYSTEMD_XLOGIN_LICENSE = BSD-2-Clause

SYSTEMD_XLOGIN_DEPENDENCIES += bash

define SYSTEMD_XLOGIN_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) all
	$(TARGET_MAKE_ENV) $(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
