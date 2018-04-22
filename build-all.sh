#!/bin/bash
# NOTE: please adjust the following variables as your build environment.
export ANDROID_BUILD=darwin-x86_64
export ANDROID_NDK=$HOME/Library/Android/sdk/ndk-bundle
export NDK_BIN=$ANDROID_NDK/ndk-build
export ANDROID_VERSION=24
export ANDROID_TOOLCHAIN_VERSION=4.9

tar xfz ./src/libiconv-1.15.tar.gz
unzip ./src/ZBar-master-20180422.zip

#prepare iconv
ICONV_SRCDIR=$PWD/libiconv-1.15/
ICONV_SCRIPTS=$PWD/scripts/iconv/
ZBAR_SRCDIR=$PWD/ZBar-master/
ZBAR_SCRIPTS=$PWD/scripts/zbar/

patch -p0 -Rf < $ICONV_SCRIPTS/localcharset.c.diff
cd $ICONV_SRCDIR && sh $ICONV_SCRIPTS/prep.sh

ANDROID_JNI_DIR=$ZBAR_SRCDIR/android/jni/
cp -f $ZBAR_SCRIPTS/*.mk $ANDROID_JNI_DIR
cd $ANDROID_JNI_DIR && $NDK_BIN
