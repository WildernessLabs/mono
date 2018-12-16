
NUTTX_TOOLCHAIN_DIR=

##
# Parameters:
#  $(1): target
#  $(2): dir
#  $(3): subdir (optional)
#  $(4): stamp (optional, default to $(1))
define NuttxProvisioningTemplate

$$(NUTTX_TOOLCHAIN_DIR)/$(2)/.stamp-nuttx-$(1):
	echo "Download and unzip nuttx here"
	touch $$@

.PHONY: provision-nuttx
provision-nuttx: $$(NUTTX_TOOLCHAIN_DIR)/$(2)/.stamp-nuttx-$(1)
endef

ifeq ($(UNAME),Darwin)
$(eval $(call NuttxProvisioningTemplate,nuttx-darwin-x86_64))
else
ifeq ($(UNAME),Linux)
$(eval $(call NuttxProvisioningTemplate,nuttx-linux-x86_64))
endif
endif

##
# Parameters:
#  $(1): target
#  $(2): arch
#  $(3): abi_name
#  $(4): host_triple
#
# Flags:
#  nuttx-$(1)_CFLAGS
#  nuttx-$(1)_CXXFLAGS
#  nuttx-$(1)_LDFLAGS
define NuttxTargetTemplate

_nuttx-$(1)_AR=
_nuttx-$(1)_AS=
_nuttx-$(1)_CC=
_nuttx-$(1)_CXX=
_nuttx-$(1)_CPP=
_nuttx-$(1)_CXXCPP=
_nuttx-$(1)_DLLTOOL=
_nuttx-$(1)_LD=
_nuttx-$(1)_OBJDUMP=
_nuttx-$(1)_RANLIB=
_nuttx-$(1)_STRIP=

_nuttx-$(1)_AC_VARS= \
	FILL_IN_HERE

_nuttx-$(1)_CFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_CXXFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_CPPFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_CXXCPPFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_LDFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_CONFIGURE_FLAGS= \
	FILL_IN_HERE

.stamp-nuttx-$(1)-toolchain: | $$(if $$(IGNORE_PROVISION_NUTTX),,provision-nuttx)
	echo "Make your standalone toolchain here, do architecture specific steps here"
	touch $$@

$$(eval $$(call RuntimeTemplate,nuttx,$(1),$(4)))

endef

## nuttx-armeabi-v7a

# Something like this
# nuttx-armeabi-v7a_CFLAGS=-D__POSIX_VISIBLE=201002 -DSK_RELEASE -DNDEBUG -UDEBUG -fpic -march=armv7-a -mtune=cortex-a8 -mfpu=vfp -mfloat-abi=softfp
# nuttx-armeabi-v7a_CXXFLAGS=-D__POSIX_VISIBLE=201002 -DSK_RELEASE -DNDEBUG -UDEBUG -fpic -march=armv7-a -mtune=cortex-a8 -mfpu=vfp -mfloat-abi=softfp
# nuttx-armeabi-v7a_LDFLAGS=-Wl,--fix-cortex-a8
# $(eval $(call NuttxTargetTemplate,armeabi-v7a,arm,arm-linux-androideabi,armv5-linux-androideabi))

##
# Parameters
#  $(1): target
#
# Flags:
#  nuttx-$(1)_CFLAGS
#  nuttx-$(1)_CXXFLAGS
define NuttxHostTemplate

_nuttx-$(1)_AR=ar
_nuttx-$(1)_AS=as
_nuttx-$(1)_CC=cc
_nuttx-$(1)_CXX=c++
_nuttx-$(1)_CXXCPP=cpp
_nuttx-$(1)_LD=ld
_nuttx-$(1)_RANLIB=ranlib
_nuttx-$(1)_STRIP=strip

_nuttx-$(1)_CFLAGS= \
	$$(if $$(filter $$(UNAME),Darwin),-mmacosx-version-min=10.9)

_nuttx-$(1)_CONFIGURE_FLAGS= \
	--disable-boehm \
	--disable-iconv \
	--disable-mono-debugger \
	--disable-nls \
	--disable-mcs-build \
	--enable-dynamic-btls \
	--enable-maintainer-mode \
	--enable-monodroid \
	--with-mcs-docs=no \
	--without-ikvm-native \
	--disable-crash-reporting

.stamp-nuttx-$(1)-toolchain:
	touch $$@

$$(eval $$(call RuntimeTemplate,nuttx,$(1)))

endef

$(eval $(call NuttxHostTemplate,host-$(UNAME)))

##
# Parameters
#  $(1): target
#  $(2): host arch
#  $(3): target arch
#  $(4): device target (armeabi-v7a, arm64-v8a, x86 or x86_64)
#  $(5): llvm (llvm32, llvm64, llvmwin32 or llvmwin64)
define NuttxCrossTemplate
_nuttx-$(1)_AR=ar
_nuttx-$(1)_AS=as
_nuttx-$(1)_CC=$$(or $$(nuttx-$(1)_CC),cc)
_nuttx-$(1)_CXX=$$(or $$(nuttx-$(1)_CXX),c++)
_nuttx-$(1)_CXXCPP=cpp
_nuttx-$(1)_LD=ld
_nuttx-$(1)_RANLIB=ranlib
_nuttx-$(1)_STRIP=strip

_nuttx-$(1)_CFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_CXXFLAGS= \
	FILL_IN_HERE

_nuttx-$(1)_CONFIGURE_FLAGS= \
	FILL_IN_HERE

$$(eval $$(call CrossRuntimeTemplate,

endef

$(eval $(call NuttxCrossTemplate,

