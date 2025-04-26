PRODUCT_VERSION_MAJOR = 15
PRODUCT_VERSION_MINOR = 2

# Increase CR Version with each major release.
BAIKAL_VERSION := 15.2

# Internal version
LINEAGE_VERSION := BaikalOS-$(PRODUCT_VERSION_MAJOR)-$(LINEAGE_BUILD)-DEV-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := BaikalOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)

# LineageOS version properties
PRODUCT_SYSTEM_PROPERTIES += \
    ro.baikalos.build.version=$(BAIKAL_VERSION) \
    ro.baikalos.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.baikalos.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)
