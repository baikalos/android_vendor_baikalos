TARGET_INSTALL_FDROID := true
TARGET_INSTALL_HMS := true

# Required packages
PRODUCT_PACKAGES += \
    adb_root

#ifeq ($(WITH_SU),true)
#PRODUCT_PACKAGES += \
#    su
#endif

# JamesDSP
#PRODUCT_PACKAGES += \
#    libjamesdsp \
#    JamesDSPManager

# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/lineage/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then \
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi; \
  fi; \
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

ifeq ($(TARGET_BOOTANIMATION_HALF_RES),true)
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bootanimation/halfres/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif
endif

# baikalos OTA
#ifneq ($(BAIKALOS_BUILD_TYPE),DEV)
#    PRODUCT_PACKAGES +=  \
#       BaikalDelta
#endif

# baikalos su
PRODUCT_PACKAGES += \
    baikal_su


ifeq ($(TARGET_INSTALL_FDROID),true)
PRODUCT_PACKAGES += \
    F-Droid \
    F-DroidPrivilegedExtension \
    privapp-permissions-fdroid.privileged.xml

endif

ifeq ($(TARGET_INSTALL_HMS),true)
PRODUCT_PACKAGES += \
    HMS_Core \
    AppGallery \
    hms_core_whitelist.xml \
    privapp-permissions-hms_core.xml \
    default_permissions_com.huawei.hms.xml \
    default_permissions_com.huawei.appmarket.xml
endif
