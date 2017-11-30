################################################################################
#
# Xen
#
################################################################################

XEN_VERSION = 4.12.2
XEN_SITE = https://downloads.xenproject.org/release/xen/$(XEN_VERSION)
XEN_PATCH = \
	https://xenbits.xenproject.org/xsa/xsa312.patch
XEN_LICENSE = GPL-2.0
XEN_LICENSE_FILES = COPYING
XEN_DEPENDENCIES = host-acpica host-python

# Calculate XEN_ARCH
ifeq ($(ARCH),aarch64)
XEN_ARCH = arm64
else ifeq ($(ARCH),arm)
XEN_ARCH = arm32
else
XEN_ARCH = $(ARCH)
endif

XEN_CONF_OPTS = \
	--disable-ocamltools \
	--with-initddir=/etc/init.d

XEN_CONF_ENV = PYTHON=$(HOST_DIR)/bin/python2
XEN_MAKE_ENV = \
	XEN_TARGET_ARCH=$(XEN_ARCH) \
	CROSS_COMPILE=$(TARGET_CROSS) \
	HOST_EXTRACFLAGS="-Wno-error" \
	XEN_HAS_CHECKPOLICY=n \
	$(TARGET_CONFIGURE_OPTS)

ifeq ($(BR2_PACKAGE_XEN_HYPERVISOR),y)
XEN_MAKE_OPTS += dist-xen
XEN_INSTALL_IMAGES = YES
define XEN_INSTALL_IMAGES_CMDS
	cp $(@D)/xen/xen $(BINARIES_DIR)
endef
else
XEN_CONF_OPTS += --disable-xen
endif

ifeq ($(BR2_PACKAGE_XEN_TOOLS),y)
XEN_DEPENDENCIES += dtc libaio libglib2 ncurses openssl pixman util-linux yajl
ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
XEN_DEPENDENCIES += argp-standalone
endif
XEN_INSTALL_TARGET_OPTS += DESTDIR=$(TARGET_DIR) install-tools
XEN_MAKE_OPTS += dist-tools
XEN_CONF_OPTS += --with-extra-qemuu-configure-args="--disable-sdl --disable-opengl"

define XEN_INSTALL_INIT_SYSV
	mv $(TARGET_DIR)/etc/init.d/xencommons $(TARGET_DIR)/etc/init.d/S50xencommons
	mv $(TARGET_DIR)/etc/init.d/xen-watchdog $(TARGET_DIR)/etc/init.d/S50xen-watchdog
	mv $(TARGET_DIR)/etc/init.d/xendomains $(TARGET_DIR)/etc/init.d/S60xendomains
endef

define XEN_INSTALL_INIT_SYSTEMD
	# Remove SysV scripts
	rm -f $(TARGET_DIR)/etc/init.d/xencommons
	rm -f $(TARGET_DIR)/etc/init.d/xendomains
	rm -f $(TARGET_DIR)/etc/init.d/xendriverdomain
	rm -f $(TARGET_DIR)/etc/init.d/xen-watchdog
	# Enable services
	mkdir -p $(TARGET_DIR)/etc/systemd/system/multi-user.target.wants
	for unit in xen-init-dom0 xen-watchdog xenstored xenconsoled xendriverdomain; do \
		ln -sf ../../../../usr/lib/systemd/system/$${unit}.service \
			$(TARGET_DIR)/etc/systemd/system/multi-user.target.wants/$${unit}.service ; \
	done
endef

else
XEN_INSTALL_TARGET = NO
XEN_CONF_OPTS += --disable-tools
endif

$(eval $(autotools-package))
