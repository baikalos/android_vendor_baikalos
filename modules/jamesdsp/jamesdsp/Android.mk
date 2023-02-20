LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := libjamesdsp

LOCAL_PRELINK_MODULE := false

LOCAL_MODULE_RELATIVE_PATH := soundfx
LOCAL_VENDOR_MODULE := true

LOCAL_LDLIBS := -llog

LOCAL_SRC_FILES := \
	cpthread.c \
	jdsp/generalDSP/spectralInterpolatorFloat.c \
	jdsp/generalDSP/ArbFIRGen.c \
	jdsp/Effects/eel2/numericSys/codelet.c \
	jdsp/generalDSP/digitalFilters.c \
	jdsp/Effects/eel2/numericSys/FFTConvolver.c \
	jdsp/generalDSP/TwoStageFFTConvolver.c \
	jdsp/generalDSP/interpolation.c \
	jdsp/generalDSP/generalProg.c \
	jdsp/Effects/vdc.c \
	jdsp/Effects/vacuumTube.c \
	jdsp/Effects/stereoEnhancement.c \
	jdsp/Effects/reverb.c \
	jdsp/Effects/liveprogWrapper.c \
	jdsp/Effects/firEqualizer.c \
	jdsp/Effects/dynamic.c \
	jdsp/Effects/dbb.c \
	jdsp/Effects/convolver1D.c \
	jdsp/Effects/crossfeed.c \
	jdsp/Effects/bs2b.c \
	jdsp/Effects/arbEqConv.c \
	jdsp/Effects/eel2/numericSys/libsamplerate/samplerate.c \
	jdsp/Effects/eel2/numericSys/libsamplerate/src_sinc.c \
	jdsp/Effects/eel2/numericSys/FilterDesign/generalFdesign.c \
	jdsp/Effects/eel2/numericSys/FilterDesign/cos_fib_paraunitary.c \
	jdsp/Effects/eel2/numericSys/FilterDesign/polyphaseFilterbank.c \
	jdsp/Effects/eel2/numericSys/FilterDesign/polyphaseASRC.c \
	jdsp/Effects/eel2/numericSys/FilterDesign/eqnerror.c \
	jdsp/Effects/eel2/numericSys/FilterDesign/firls.c \
	jdsp/Effects/eel2/numericSys/SolveLinearSystem/inv.c \
	jdsp/Effects/eel2/numericSys/SolveLinearSystem/pinv.c \
	jdsp/Effects/eel2/numericSys/SolveLinearSystem/mldivide.c \
	jdsp/Effects/eel2/numericSys/SolveLinearSystem/mrdivide.c \
	jdsp/Effects/eel2/numericSys/SolveLinearSystem/qr_fact.c \
	jdsp/Effects/eel2/numericSys/solvopt.c \
	jdsp/Effects/eel2/numericSys/cpoly.c \
	jdsp/Effects/eel2/numericSys/MersenneTwister.c \
	jdsp/Effects/eel2/numericSys/quadprog.c \
	jdsp/Effects/eel2/s_str.c \
	jdsp/Effects/eel2/fft.c \
	jdsp/Effects/eel2/nseel-compiler.c \
	jdsp/Effects/eel2/nseel-ram.c \
	jdsp/Effects/eel2/y.tab.c \
	jdsp/binaryBlobs.c \
	jdsp/jdspController.c \
	jamesdsp.c \

# terminator
LOCAL_CPPFLAGS := -ffunction-sections -fdata-sections -Ofast -march=armv8-a -mfpu=neon -ftree-vectorize -fvisibility=hidden -DDEBUG -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-implicit-int -Wno-pointer-sign -Wno-missing-field-initializers -Wno-incompatible-pointer-types-discards-qualifiers -Wno-error -Wno-pointer-bool-conversion
LOCAL_CFLAGS := -ffunction-sections -fdata-sections -Ofast -march=armv8-a -mfpu=neon -ftree-vectorize -fvisibility=hidden -DDEBUG -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable -Wno-implicit-int -Wno-pointer-sign -Wno-missing-field-initializers -Wno-incompatible-pointer-types-discards-qualifiers -Wno-error -Wno-pointer-bool-conversion
LOCAL_LDFLAGS += -Wl,--gc-sections,--exclude-libs,ALL  -Wno-unused-function -Wno-unused-but-set-variable -Wno-unused-parameter -Wno-unused-variable

include $(BUILD_SHARED_LIBRARY)
