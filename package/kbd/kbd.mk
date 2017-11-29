################################################################################
#
# kbd
#
################################################################################

KBD_VERSION = 2.0.4
KBD_SOURCE = kbd-$(KBD_VERSION).tar.xz
KBD_SITE = $(BR2_KERNEL_MIRROR)/linux/utils/kbd
KBD_CONF_OPTS = \
	--disable-vlock \
	--disable-tests
KBD_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-pkgconf \
	gzip
KBD_LICENSE = GPL-2.0+
KBD_LICENSE_FILES = COPYING

KBD_INSTALL_STAGING_OPTS = MKINSTALLDIRS=$(@D)/config/mkinstalldirs DESTDIR=$(STAGING_DIR) install
KBD_INSTALL_TARGET_OPTS = MKINSTALLDIRS=$(@D)/config/mkinstalldirs DESTDIR=$(TARGET_DIR) install

ifeq ($(BR2_PACKAGE_KBD_FONTS),y)
# Clean installed fonts
define KBD_CLEANUP_FONTS
	# Remove README files
	rm -f $(TARGET_DIR)/usr/share/consolefonts/README.*
endef
KBD_POST_INSTALL_TARGET_HOOKS += KBD_CLEANUP_FONTS
else
# Remove fonts
define KBD_REMOVE_FONTS
	rm -f $(TARGET_DIR)/usr/bin/setfont
	rm -rf $(TARGET_DIR)/usr/share/consolefonts
endef
KBD_POST_INSTALL_TARGET_HOOKS += KBD_REMOVE_FONTS
endif

# Remove obsolete components
define KBD_REMOVE_OBSOLETE
	rm -rf $(TARGET_DIR)/usr/share/consoletrans
	for bin in loadunimap mapscrn; do \
		rm -f $(TARGET_DIR)/usr/bin/$${bin} ; \
	done
endef
KBD_POST_INSTALL_TARGET_HOOKS += KBD_REMOVE_OBSOLETE

$(eval $(autotools-package))
