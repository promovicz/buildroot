################################################################################
#
# fs-uae
#
################################################################################

FS_UAE_VERSION = v2.6.1
FS_UAE_SOURCE = fs-uae-$(FS_UAE_VERSION).tar.gz
FS_UAE_SITE = $(call github,FrodeSolheim,fs-uae,$(FS_UAE_VERSION))
FS_UAE_LICENSE = GPL-2.0
FS_UAE_AUTORECONF = YES

FS_UAE_DEPENDENCIES += sdl2
FS_UAE_DEPENDENCIES += libglew

$(eval $(autotools-package))
