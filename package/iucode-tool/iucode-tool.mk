################################################################################
#
# iucode-tool
#
################################################################################

IUCODE_TOOL_VERSION = 2.2
IUCODE_TOOL_SOURCE = iucode-tool_$(IUCODE_TOOL_VERSION).tar.xz
IUCODE_TOOL_SITE = https://gitlab.com/iucode-tool/releases/raw/master
ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
IUCODE_TOOL_DEPENDENCIES = argp-standalone
endif
IUCODE_TOOL_LICENSE = GPL-2.0+
IUCODE_TOOL_LICENSE_FILES = COPYING

define IUCODE_TOOL_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/iucode-tool/S00iucode-tool \
		$(TARGET_DIR)/etc/init.d/S00iucode-tool
endef

define IUCODE_TOOL_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 package/iucode-tool/iucode-tool.service \
		$(TARGET_DIR)/usr/lib/systemd/system/iucode-tool.service
	mkdir -p $(TARGET_DIR)/etc/systemd/system/sysinit.target.wants
	ln -fs ../../../../usr/lib/systemd/system/iucode-tool.service \
		$(TARGET_DIR)/etc/systemd/system/sysinit.target.wants/iucode-tool.service
endef

$(eval $(autotools-package))
