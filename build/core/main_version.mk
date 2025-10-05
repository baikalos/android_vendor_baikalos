# Build fingerprint
ifneq ($(BUILD_FINGERPRINT),)
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
endif

# BaikalOS System Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.baikalos.build.version=$(LINEAGE_VERSION) \
    ro.baikalos.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.baikalos.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.baikalos.legal.url=https://baikalos.net/legal.php

#    ro.baikalos.modversion=$(BAIKALOS_VERSION) \


# LineageOS Platform SDK Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.baikalos.build.version.plat.sdk=$(LINEAGE_PLATFORM_SDK_VERSION)

# LineageOS Platform Internal Version
ADDITIONAL_SYSTEM_PROPERTIES += \
    ro.baikalos.build.version.plat.rev=$(LINEAGE_PLATFORM_REV)
