################################################################################
#
# tcc
#
################################################################################

TCC_VERSION = 0.9.27
TCC_SOURCE = tcc-$(TCC_VERSION).tar.bz2
TCC_SITE = http://download.savannah.gnu.org/releases/tinycc
TCC_LICENSE = LGPL
TCC_LICENSE_FILES = COPYING

TCC_CONF_OPTS += --cc=$(TARGET_CC) --ar=$(TARGET_AR)

$(eval $(autotools-package))
