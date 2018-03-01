################################################################################
#
# libxdg-basedir
#
################################################################################

LIBXDG_BASEDIR_VERSION = 1.2.0
LIBXDG_BASEDIR_SOURCE = libxdg-basedir-$(LIBXDG_BASEDIR_VERSION).tar.gz
LIBXDG_BASEDIR_SITE = https://github.com/devnev/libxdg-basedir/archive
LIBXDG_BASEDIR_LICENSE = MIT
LIBXDG_BASEDIR_LICENSE_FILES = COPYING

LIBXDG_BASEDIR_AUTORECONF = YES
LIBXDG_BASEDIR_INSTALL_STAGING = YES

$(eval $(autotools-package))
