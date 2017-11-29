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

KBD_INSTALL_TARGET_OPTS = MKINSTALLDIRS=$(@D)/config/mkinstalldirs DESTDIR=$(TARGET_DIR) install

$(eval $(autotools-package))
