################################################################################
#
# dunst
#
################################################################################

DUNST_VERSION = 1.3.1
DUNST_SOURCE = v$(DUNST_VERSION).tar.gz
DUNST_SITE = https://github.com/dunst-project/dunst/archive
DUNST_LICENSE = BSD-3-Clause
DUNST_LICENSE_FILES = LICENSE

DUNST_MAKE_OPTS += PREFIX=/usr

DUNST_DEPENDENCIES += libglib2
DUNST_DEPENDENCIES += dbus
DUNST_DEPENDENCIES += gdk-pixbuf
DUNST_DEPENDENCIES += libnotify
DUNST_DEPENDENCIES += libxdg-basedir
DUNST_DEPENDENCIES += pango
DUNST_DEPENDENCIES += xlib_libXinerama
DUNST_DEPENDENCIES += xlib_libXrandr
DUNST_DEPENDENCIES += xlib_libXScrnSaver

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
DUNST_DEPENDENCIES += systemd
DUNST_MAKE_OPTS += SYSTEMD=1
endif

define DUNST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(DUNST_MAKE_OPTS) all -C $(@D)
endef

define DUNST_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(DUNST_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install -C $(@D)
endef

$(eval $(generic-package))
