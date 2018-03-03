################################################################################
#
# xutil_imake
#
################################################################################

XUTIL_IMAKE_VERSION = 1.0.7
XUTIL_IMAKE_SOURCE = imake-$(XUTIL_IMAKE_VERSION).tar.bz2
XUTIL_IMAKE_SITE = http://xorg.freedesktop.org/releases/individual/util
XUTIL_IMAKE_LICENSE = MIT
XUTIL_IMAKE_LICENSE_FILES = COPYING

XUTIL_IMAKE_DEPENDENCIES = xproto_xproto
HOST_XUTIL_IMAKE_DEPENDENCIES = host-xproto_xproto

$(eval $(autotools-package))
$(eval $(host-autotools-package))
