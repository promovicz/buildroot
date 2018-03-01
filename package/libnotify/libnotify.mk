################################################################################
#
# libnotify
#
################################################################################

LIBNOTIFY_VERSION = 0.7.7
LIBNOTIFY_SOURCE = libnotify-$(LIBNOTIFY_VERSION).tar.xz
LIBNOTIFY_SITE = http://ftp.gnome.org/pub/GNOME/sources/libnotify/0.7
LIBNOTIFY_LICENSE = GPLv2+
LIBNOTIFY_LICENSE_FILES = COPYING

LIBNOTIFY_INSTALL_STAGING = YES

LIBNOTIFY_CONF_OPTS += --disable-tests

LIBNOTIFY_DEPENDENCIES += libglib2
LIBNOTIFY_DEPENDENCIES += gdk-pixbuf

$(eval $(autotools-package))
