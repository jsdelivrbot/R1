################################################################################
#
# gstreamer1
#
################################################################################

GSTREAMER1_VERSION = 1.10.0
GSTREAMER1_SOURCE = gstreamer-$(GSTREAMER1_VERSION).tar.xz
GSTREAMER1_SITE = https://gstreamer.freedesktop.org/src/gstreamer
GSTREAMER1_INSTALL_STAGING = YES
GSTREAMER1_LICENSE_FILES = COPYING
GSTREAMER1_LICENSE = LGPLv2+, LGPLv2.1+

# Checking if unaligned memory access works correctly cannot be done when cross
# compiling. For the following architectures there is no information available
# in the configure script.
ifeq ($(BR2_arc)$(BR2_xtensa)$(BR2_microblaze)$(BR2_nios2),y)
GSTREAMER1_CONF_ENV = as_cv_unaligned_access=no
endif
ifeq ($(BR2_aarch64),y)
GSTREAMER1_CONF_ENV = as_cv_unaligned_access=yes
endif

GSTREAMER1_CONF_OPTS = \
	--disable-examples \
	--disable-tests \
	--disable-failing-tests \
	--disable-valgrind \
	--disable-benchmarks \
	--disable-check \
	$(if $(BR2_PACKAGE_GSTREAMER1_TRACE),,--disable-trace) \
	$(if $(BR2_PACKAGE_GSTREAMER1_PARSE),,--disable-parse) \
	$(if $(BR2_PACKAGE_GSTREAMER1_GST_DEBUG),,--disable-gst-debug) \
	$(if $(BR2_PACKAGE_GSTREAMER1_PLUGIN_REGISTRY),,--disable-registry) \
	$(if $(BR2_PACKAGE_GSTREAMER1_INSTALL_TOOLS),,--disable-tools)

GSTREAMER1_DEPENDENCIES = \
	host-bison \
	host-flex \
	host-pkgconf \
	libglib2 \
	$(if $(BR2_PACKAGE_LIBUNWIND),libunwind)

$(eval $(autotools-package))
