PRODUCT_VERSION_MAJOR = 13
PRODUCT_VERSION_MINOR = 0

# Increase CR Version with each major release.
BAIKALOS_VERSION := 13.0
BAIKALOS_VERSION_MAJOR = 13
BAIKALOS_VERSION_MINOR = 0

# Internal version
LINEAGE_VERSION := BaikalOS-$(BAIKALOS_VERSION_MAJOR)-$(LINEAGE_BUILD)-DEV-$(shell date +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := BaikalOS-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR)-$(LINEAGE_BUILD)-v$(BAIKALOS_VERSION)
