################################################################################
#
# ninja
#
################################################################################

NINJA_VERSION = v1.8.2
NINJA_SITE = $(call github,ninja-build,ninja,$(NINJA_VERSION))
NINJA_LICENSE = Apache-2.0
NINJA_LICENSE_FILES = COPYING

HOST_NINJA_DEPENDENCIES = host-python3

define HOST_NINJA_BUILD_CMDS
	(cd $(@D); python3 configure.py --bootstrap)
endef

define HOST_NINJA_INSTALL_CMDS
	$(INSTALL) -m 0755 -D $(@D)/ninja $(HOST_DIR)/bin/ninja
endef

$(eval $(host-generic-package))
