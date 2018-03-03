################################################################################
#
# xautolock
#
################################################################################

XAUTOLOCK_VERSION = 2.2
XAUTOLOCK_SOURCE = xautolock_$(XAUTOLOCK_VERSION).orig.tar.gz
XAUTOLOCK_SITE = http://http.debian.net/debian/pool/main/x/xautolock
XAUTOLOCK_LICENSE = GPLv2
XAUTOLOCK_LICENSE_FILES = LICENSE

XAUTOLOCK_DEPENDENCIES += host-xutil_imake
XAUTOLOCK_DEPENDENCIES += xlib_libX11
XAUTOLOCK_DEPENDENCIES += xlib_libXau
XAUTOLOCK_DEPENDENCIES += xlib_libXdmcp
XAUTOLOCK_DEPENDENCIES += xlib_libXext
XAUTOLOCK_DEPENDENCIES += xlib_libXScrnSaver

XAUTOLOCK_MAKE_OPTS += DEFINES="-DSYSV"

define XAUTOLOCK_BUILD_CMDS
	($(TARGET_MAKE_ENV) cd $(@D) && xmkmf)
	$(TARGET_MAKE_ENV) $(MAKE) $(XAUTOLOCK_MAKE_OPTS) -C $(@D)
endef

define XAUTOLOCK_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(XAUTOLOCK_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install -C $(@D)
endef

$(eval $(generic-package))
