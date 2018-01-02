#!/bin/sh

COMMON_FLAGS="-I/Users/plasma/Work/wl/meadow/nuttx/include -nostdinc -nostdlib"
COMMON_DEFINES="-D_POSIX_VERSION=201112L -DHAVE_USR_INCLUDE_MALLOC_H=1 -DLACKS_SYS_PARAM_H=1 -DHAVE_MMAP=1 -D__NuttX__=1 -DSA_RESTART=0 -DSTDIN_FILENO=0 -DSTDOUT_FILENO=1 -DSTDERR_FILENO=2"
CFLAGS="--specs=nosys.specs -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 $COMMON_DEFINES $COMMON_FLAGS"
CPPFLAGS="$COMMON_DEFINES $COMMON_FLAGS"
./autogen.sh --host=arm-none-eabi \
	CFLAGS="$CFLAGS" \
	CPPFLAGS="$CPPFLAGS" \
	--disable-boehm \
	--disable-mcs \
	--enable-interpreter \
	--enable-nls=no \
	--enable-minimal=profiler,decimal,pinvoke,debug,appdomains,verifier,large_code,logging,com,attach,jit,simd,soft_debug,perfcounters,normalization,desktop_loader,shared_perfcounters,remoting,security,lldb,mdb
