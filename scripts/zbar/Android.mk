#
# Android NDK makefile 
#
# build - <ndk path>/ndk-build ICONV_SRC=<iconv library src> 
# clean -  <ndk path>/ndk-build clean
#
MY_LOCAL_PATH := $(call my-dir)

# libiconv
include $(CLEAR_VARS)
ICONV_SRC := $(PWD)/../../../libiconv-1.15
LOCAL_PATH := $(ICONV_SRC)

LOCAL_MODULE := libiconv

LOCAL_CFLAGS := \
    -Wno-multichar \
    -D_ANDROID \
    -DLIBDIR="c" \
    -DBUILDING_LIBICONV \
    -DBUILDING_LIBCHARSET \
    -DIN_LIBRARY

LOCAL_SRC_FILES := \
	$(ICONV_SRC)/lib/iconv.c \
	$(ICONV_SRC)/libcharset/lib/localcharset.c \
	$(ICONV_SRC)/lib/relocatable.c

LOCAL_C_INCLUDES := \
	$(ICONV_SRC)/include \
	$(ICONV_SRC)/libcharset \
	$(ICONV_SRC)/libcharset/include

include $(BUILD_SHARED_LIBRARY)

LOCAL_LDLIBS := -llog -lcharset

# libzbarjni
include $(CLEAR_VARS)

LOCAL_PATH := $(MY_LOCAL_PATH)
ZBAR_SRC := $(PWD)/../..
LOCAL_MODULE := zbarjni
LOCAL_SRC_FILES := $(ZBAR_SRC)/java/zbarjni.c \
		   $(ZBAR_SRC)/zbar/img_scanner.c \
		   $(ZBAR_SRC)/zbar/decoder.c \
		   $(ZBAR_SRC)/zbar/image.c \
		   $(ZBAR_SRC)/zbar/symbol.c \
		   $(ZBAR_SRC)/zbar/convert.c \
		   $(ZBAR_SRC)/zbar/config.c \
		   $(ZBAR_SRC)/zbar/scanner.c \
		   $(ZBAR_SRC)/zbar/error.c \
		   $(ZBAR_SRC)/zbar/refcnt.c \
		   $(ZBAR_SRC)/zbar/video.c \
		   $(ZBAR_SRC)/zbar/video/null.c \
		   $(ZBAR_SRC)/zbar/decoder/code128.c \
		   $(ZBAR_SRC)/zbar/decoder/code39.c \
		   $(ZBAR_SRC)/zbar/decoder/code93.c \
		   $(ZBAR_SRC)/zbar/decoder/codabar.c \
		   $(ZBAR_SRC)/zbar/decoder/databar.c \
		   $(ZBAR_SRC)/zbar/decoder/ean.c \
		   $(ZBAR_SRC)/zbar/decoder/i25.c \
		   $(ZBAR_SRC)/zbar/decoder/qr_finder.c \
		   $(ZBAR_SRC)/zbar/qrcode/bch15_5.c \
		   $(ZBAR_SRC)/zbar/qrcode/binarize.c \
		   $(ZBAR_SRC)/zbar/qrcode/isaac.c \
		   $(ZBAR_SRC)/zbar/qrcode/qrdec.c \
		   $(ZBAR_SRC)/zbar/qrcode/qrdectxt.c \
		   $(ZBAR_SRC)/zbar/qrcode/rs.c \
		   $(ZBAR_SRC)/zbar/qrcode/util.c

LOCAL_C_INCLUDES := $(ZBAR_SRC)/include \
		    $(ZBAR_SRC)/zbar \
		    $(ICONV_SRC)/include 

LOCAL_SHARED_LIBRARIES := libiconv

include $(BUILD_SHARED_LIBRARY)
