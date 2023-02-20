LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := libjamesDSPImpulseToolbox
LOCAL_SRC_FILES := cpthread.c interpolation.c JdspImpResToolbox.c
LOCAL_STATIC_LIBRARIES = libsamplerate
LOCAL_CPPFLAGS += -ffunction-sections -fdata-sections -Ofast -ftree-vectorize -DNDEBUG
LOCAL_CFLAGS += -ffunction-sections -fdata-sections -Ofast -ftree-vectorize -DNDEBUG
LOCAL_LDFLAGS += -Wl,--gc-sections,--exclude-libs,ALL
LOCAL_HEADER_LIBRARIES := jni_headers
include $(BUILD_SHARED_LIBRARY)