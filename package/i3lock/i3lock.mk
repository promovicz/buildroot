################################################################################
#
# i3lock
#
################################################################################

I3LOCK_VERSION = 2.10
I3LOCK_SOURCE = i3lock-$(I3LOCK_VERSION).tar.bz2
I3LOCK_SITE = https://i3wm.org/i3lock
I3LOCK_LICENSE = BSD-3-Clause
I3LOCK_LICENSE_FILES = LICENSE

I3LOCK_DEPENDENCIES += cairo
I3LOCK_DEPENDENCIES += libev
I3LOCK_DEPENDENCIES += libxcb
I3LOCK_DEPENDENCIES += libxkbcommon
I3LOCK_DEPENDENCIES += xcb-util
I3LOCK_DEPENDENCIES += xcb-util-image

define I3LOCK_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(I3LOCK_MAKE_OPTS) all -C $(@D)
endef

define I3LOCK_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(I3LOCK_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install -C $(@D)
endef

$(eval $(generic-package))
