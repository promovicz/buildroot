################################################################################
#
# simh
#
################################################################################

SIMH_VERSION = 014ad9607e341791f1f4eb1e04f183fe739888da
SIMH_SOURCE = simh-$(SIMH_VERSION).tar.gz
SIMH_SITE = $(call github,promovicz,simh,$(SIMH_VERSION))
SIMH_LICENSE = MIT

SIMH_DEPENDENCIES += pcre

SIMH_CONF_OPTS += -DEXECUTABLE_PREFIX=simh-

ifeq ($(BR2_PACKAGE_SIMH_GRAPHICS),y)
SIMH_CONF_OPTS += -DENABLE_GRAPHICS=YES
SIMH_DEPENDENCIES += sdl
else
SIMH_CONF_OPTS += -DENABLE_GRAPHICS=NO
endif

ifeq ($(BR2_PACKAGE_SIMH_NETWORK),y)
SIMH_CONF_OPTS += -DENABLE_NETWORK=YES
SIMH_DEPENDENCIES += vdeplug
else
SIMH_CONF_OPTS += -DENABLE_NETWORK=NO
endif

define SIMH_DELETE_LEGACY_MAKEFILE
	rm -f $(SIMH_SRCDIR)/makefile
endef
SIMH_PRE_CONFIGURE_HOOKS += SIMH_DELETE_LEGACY_MAKEFILE

$(eval $(cmake-package))
