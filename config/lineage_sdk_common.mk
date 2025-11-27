# Permissions for lineage sdk services
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/org.baikalos.globalactions.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.globalactions.xml \
    vendor/lineage/config/permissions/org.baikalos.hardware.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.hardware.xml \
    vendor/lineage/config/permissions/org.baikalos.health.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.health.xml \
    vendor/lineage/config/permissions/org.baikalos.livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.livedisplay.xml \
    vendor/lineage/config/permissions/org.baikalos.profiles.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.profiles.xml \
    vendor/lineage/config/permissions/org.baikalos.settings.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.settings.xml \
    vendor/lineage/config/permissions/org.baikalos.trust.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.baikalos.trust.xml

# Lineage Platform Library
PRODUCT_PACKAGES += \
    org.lineageos.platform-res \
    org.lineageos.platform

# AOSP has no support of loading framework resources from /system_ext
# so the SDK has to stay in /system for now
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/framework/org.lineageos.platform-res.apk \
    system/framework/org.lineageos.platform.jar \
    system/framework/org.mineageos.platform-res.apk \
    system/framework/org.mineageos.platform.jar

# Allow-list odex and vdex when OVERRIDE_DISABLE_DEXOPT_ALL isn't set.
# OVERRIDE_DISABLE_DEXOPT_ALL is usually set to true for eng builds. We allow-list the below mainly for user and userdebug builds.
# Refer build/target/product/runtime_libart.mk.
ifneq ($(OVERRIDE_DISABLE_DEXOPT_ALL),true)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/framework/oat/%/org.mineageos.platform.odex \
    system/framework/oat/%/org.mineageos.platform.vdex
endif

