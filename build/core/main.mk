# Include LineageOS versions
include $(TOPDIR)vendor/lineage/build/core/main_version.mk

ifeq ($(PRODUCT_OVERRIDE_INFO),true)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.stock_fingerprint=$(PRODUCT_OVERRIDE_FINGERPRINT) \
    ro.build.stock_sec_patch=$(PRODUCT_OVERRIDE_SECURITY_PATCH)

# Description needs special treatment because it contains spaces
PRIVATE_BUILD_DESC := $(PRODUCT_OVERRIDE_DESC)
endif
