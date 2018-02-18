################################################################################
#
# Xen
#
################################################################################

XEN_VERSION = 4.12.2
XEN_INSTALL_STAGING = YES
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

# Disable -Werror everywhere
define XEN_DISABLE_WERROR
	( cd $(@D)/tools/firmware/etherboot ; make ipxe/src/arch/i386/Makefile )
	grep -Rl '\-Werror' $(@D) | xargs --no-run-if-empty -n 1 sed -i 's/-Werror//g'
endef
XEN_POST_CONFIGURE_HOOKS += XEN_DISABLE_WERROR

# Fix seabios build (bad references to ncurses)
define XEN_FIX_SEABIOS
	( cd $(@D)/tools/firmware ; make seabios-dir )
	cp $(@D)/xen/tools/kconfig/lxdialog/check-lxdialog.sh \
	   $(@D)/tools/firmware/seabios-dir-remote/scripts/kconfig/lxdialog/check-lxdialog.sh
endef
# Fix qemu build (wrong sdl-config, badly detects opengl)
define XEN_FIX_QEMU
	# Configure uses wrong sdl-config
	( cd $(@D)/tools ; make qemu-xen-traditional-dir-find )
	sed -i "s^\"sdl-config\"^\"$(STAGING_DIR)/usr/bin/sdl-config\"^" \
	   $(@D)/tools/qemu-xen-traditional/configure
	# Forcibly disable OpenGL
	sed -i "s^-lGL^-lGLDISABLED^" \
	   $(@D)/tools/qemu-xen-traditional/configure
	sed -i "s^-I/usr/include/GL^-I$(STAGING_DIR)/usr/include/GL^" \
	   $(@D)/tools/qemu-xen-traditional/configure
endef
# Fix python library build (uses wrong python)
define XEN_FIX_PYTHON
	# Makefile uses wrong python
	sed -i "s^\$$(PYTHON)^$(HOST_DIR)/bin/python2^" \
	   $(@D)/tools/python/Makefile
	# Removal of -Werror leaves empty string
    sed -i 's^, "" ^^' $(@D)/tools/python/setup.py
	sed -i 's^, "" ^^' $(@D)/tools/pygrub/setup.py
endef
XEN_POST_CONFIGURE_HOOKS += \
	XEN_FIX_SEABIOS \
	XEN_FIX_PYTHON

XEN_CONF_OPTS += \
	--disable-ocamltools \
	--with-initddir=/etc/init.d

XEN_CONF_ENV += PYTHON=$(HOST_DIR)/bin/python2
XEN_MAKE_ENV += PYTHON=$(HOST_DIR)/bin/python2

XEN_MAKE_ENV += \
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
XEN_DEPENDENCIES += libaio ncurses openssl util-linux xz yajl
ifeq ($(BR2_PACKAGE_ARGP_STANDALONE),y)
XEN_DEPENDENCIES += argp-standalone
endif
XEN_INSTALL_TARGET_OPTS += DESTDIR=$(TARGET_DIR) install-tools
XEN_INSTALL_STAGING_OPTS += DESTDIR=$(STAGING_DIR) install-tools
XEN_MAKE_OPTS += dist-tools
XEN_CONF_OPTS += --disable-qemu-traditional --with-system-qemu=/usr/bin/qemu-system-x86_64

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
