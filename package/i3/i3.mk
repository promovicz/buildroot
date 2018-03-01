################################################################################
#
# i3
#
################################################################################

I3_VERSION = 4.14.1
I3_SOURCE = i3-$(I3_VERSION).tar.bz2
I3_SITE = https://i3wm.org/downloads
I3_LICENSE = BSD-3-Clause
I3_LICENSE_FILES = LICENSE

I3_AUTORECONF = YES

I3_DEPENDENCIES += cairo
I3_DEPENDENCIES += libev
I3_DEPENDENCIES += libxcb
I3_DEPENDENCIES += libxkbcommon
I3_DEPENDENCIES += pango
I3_DEPENDENCIES += pcre
I3_DEPENDENCIES += startup-notification
I3_DEPENDENCIES += yajl
I3_DEPENDENCIES += xcb-util
I3_DEPENDENCIES += xcb-util-cursor
I3_DEPENDENCIES += xcb-util-keysyms
I3_DEPENDENCIES += xcb-util-wm
I3_DEPENDENCIES += xcb-util-xrm

$(eval $(autotools-package))
