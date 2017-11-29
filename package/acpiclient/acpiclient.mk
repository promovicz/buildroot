################################################################################
#
# acpiclient
#
################################################################################

ACPICLIENT_VERSION = 1.7
ACPICLIENT_SOURCE = acpi-$(ACPICLIENT_VERSION).tar.gz
ACPICLIENT_SITE = http://downloads.sourceforge.net/project/acpiclient/acpiclient/$(ACPICLIENT_VERSION)
ACPICLIENT_LICENSE = GPLv2+
ACPICLIENT_LICENSE_FILES = COPYING

$(eval $(autotools-package))
