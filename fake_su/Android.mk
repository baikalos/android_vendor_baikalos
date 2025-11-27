LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := fake_su
LOCAL_MODULE_STEM := su
LOCAL_SRC_FILES := su.cpp
LOCAL_MODULE_CLASS := EXECUTABLES

# Full static link
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_STATIC_LIBRARIES := libc libm libdl
LOCAL_CXX_STL := libc++_static

# Define the absolute path in the system image
# This will put the binary exactly into /system/baikalos/bin/
LOCAL_MODULE_PATH := $(TARGET_OUT)/baikalos/bin

LOCAL_CFLAGS := -O2 -Wall -Werror -fPIE
LOCAL_LDFLAGS := -static

include $(BUILD_EXECUTABLE)
