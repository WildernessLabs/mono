#!/bin/sh
NUTTX_HOME=$MEADOW_BASE/nuttx
COMMON_FLAGS="-D_POSIX_VERSION=201112L -DHAVE_USR_INCLUDE_MALLOC_H=1 -DLACKS_SYS_PARAM_H=1 -D__NuttX__=1 -DSA_RESTART=0 -DSTDIN_FILENO=0 -DSTDOUT_FILENO=1 -DSTDERR_FILENO=2 -I$NUTTX_HOME/include -nostdinc -nostdlib -fno-builtin -Os -Wno-discarded-qualifiers -Wno-unused-function -Wno-missing-prototypes -Wno-misleading-indentation -Wno-unused-variable -Wno-int-conversion -Wno-shift-count-overflow -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast -Wno-maybe-uninitialized -Wno-overflow -Wno-incompatible-pointer-types -Wno-format"
CFLAGS="--specs=nosys.specs -mthumb -mcpu=cortex-m7 -mfloat-abi=hard -mfpu=fpv5-d16 $COMMON_FLAGS"
CXXFLAGS="-DCONFIG_WCHAR_BUILTIN"
CPPFLAGS="$COMMON_FLAGS"
LDFLAGS="-e main -L$NUTTX_HOME/lib -L$NUTTX_HOME/arch/arm/src/board -ldrivers -lconfigs -lstubs -lcrypto -lbinfmt -lcxx -luc -lumm -lproxies -lfs -lgcc -lm"
./autogen.sh --enable-maintainer-mode --enable-compile-warnings --host=arm-none-eabi --disable-boehm --disable-mcs --disable-support-build --enable-interpreter --enable-nls=no --enable-minimal=jit,profiler,decimal,pinvoke,debug,appdomains,verifier,large_code,logging,com,attach,simd,perfcounters,normalization,desktop_loader,shared_perfcounters,remoting,security,lldb,mdb,shadowcopy,sockets CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS" CXXFLAGS="$CXXFLAGS" LDFLAGS="$LDFLAGS" CC="ccache arm-none-eabi-gcc"
