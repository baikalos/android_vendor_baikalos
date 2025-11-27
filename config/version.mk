PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 2

# Increase CR Version with each major release.
CR_VERSION := 16.2
BAIKAL_VERSION := 16.2

# Internal version
#LINEAGE_VERSION := crDroidAndroid-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(shell date +%Y%m%d)-$(LINEAGE_BUILD)-v$(CR_VERSION)
LINEAGE_VERSION := BaikalOS-$(PRODUCT_VERSION_MAJOR)-$(LINEAGE_BUILD)-DEV-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := v$(BAIKAL_VERSION)-$(shell date +%Y%m%d)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.baikalos.build.version=$(BAIKAL_VERSION) \
    ro.baikalos.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.baikalos.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)
