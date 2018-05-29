################################################################################
#
# xcb-util-xrm
#
################################################################################

XCB_UTIL_XRM_VERSION = 1.2
XCB_UTIL_XRM_SITE = https://github.com/Airblader/xcb-util-xrm/releases/download/v$(XCB_UTIL_XRM_VERSION)
XCB_UTIL_XRM_SOURCE = xcb-util-xrm-$(XCB_UTIL_XRM_VERSION).tar.bz2
XCB_UTIL_XRM_LICENSE = MIT
XCB_UTIL_XRM_LICENSE_FILES = COPYING
XCB_UTIL_XRM_INSTALL_STAGING = YES
XCB_UTIL_XRM_DEPENDENCIES = xcb-util

$(eval $(autotools-package))
