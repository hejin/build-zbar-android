# NOTE：
# 	a dirty hack - u need to create symlinks for x86/x86-64 toolchain path, to make it follow the name convention of other architecures.
#   saying, "ln -s $ANDROID_NDK/toolchains/x86-4.9/ $ANDROID_NDK/toolchains/i686-linux-android-4.9" for x86 and similar stuff for x86-64

function do_build() {
	export ANDROID_HOST=$1
	export ANDROID_ARCH=$2
	export ANDROID_SYSROOT=$ANDROID_NDK/platforms/android-$ANDROID_VERSION/arch-$ANDROID_ARCH
	export CFLAGS="--sysroot=$ANDROID_SYSROOT -I$ANDROID_NDK/sysroot/usr/include -I$ANDROID_NDK/sysroot/usr/include/$ANDROID_HOST"
	export CPPFLAGS="--sysroot=$ANDROID_SYSROOT -I$ANDROID_NDK/sysroot/usr/include -I$ANDROID_NDK/sysroot/usr/include/$ANDROID_HOST"
	export AR=$ANDROID_HOST-ar
	export RANLIB=$ANDROID_HOST-ranlib
	export PATH=$ANDROID_NDK/toolchains/$ANDROID_HOST-$ANDROID_TOOLCHAIN_VERSION/prebuilt/$ANDROID_BUILD/bin:$PATH
	make distclean
	./configure --host=$ANDROID_HOST --with-sysroot=$ANDROID_SYSROOT --prefix=$PWD/libiconv-release/$ANDROID_TARGET
	if [ -z "$3" ]; then
		return
	fi	
	make -j4
	make install
}

function target2arch() {
	case $1 in
		"arm64-v8")
		echo "arm64";;
		"armeabi-v7a")
		echo "arm";;
		"x86")
		echo "x86";;  
	esac
}

function target2host() {
	case $1 in
		"arm64-v8")
		echo "aarch64-linux-android";;
		"armeabi-v7a")
		echo "arm-linux-androideabi";;
		"x86")
		echo "i686-linux-android";;  
	esac
}

function build() {
	targets="arm64-v8 armeabi-v7a x86"
	for target in $targets; do
		export ANDROID_TARGET=$target
		android_arch=$(target2arch $target)
		echo $android_arch
		android_host=$(target2host $target)
		echo $android_host
		do_build $android_host $android_arch $1
		if [ -z "$1" ]; then
			return
		fi
		done
}

build $1
