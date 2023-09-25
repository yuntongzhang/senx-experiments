#!/bin/bash
git clone https://github.com/vadz/libtiff.git source-test
cd source-test
git checkout f3069a5

# instrumentation
sed -i '2443i if(0) return;' tools/tiff2ps.c

# apply patch
git add .
git commit -m "Before patch"
git apply ../result-1/formatted.patch

# build
./autogen.sh
PROJECT_CONFIG_OPTIONS=" --enable-static --disable-shared"
PROJECT_CFLAGS="-g -O0 -static"
PROJECT_CPPFLAGS="-g -O0 -static"
PROJECT_LDFLAGS="-static"
./configure CFLAGS="${PROJECT_CFLAGS}" CPPFLAGS="${PROJECT_CPPFLAGS}" LDFLAGS="${PROJECT_LDFLAGS}" ${PROJECT_CONFIG_OPTIONS}
PROJECT_CFLAGS="-static -fsanitize=address -ggdb -O0"
PROJECT_CPPFLAGS="-static -fsanitize=address  -ggdb -O0"
PROJECT_LDFLAGS="-static  -fsanitize=address -O0"
make CFLAGS="${PROJECT_CFLAGS}" CPPFLAGS="${PROJECT_CPPFLAGS}" LDFLAGS="${PROJECT_LDFLAGS}" -j`nproc`

if [ $? -eq 0 ]; then
    echo "Build OK"
else
    echo "Build failed"
    exit 122
fi

bin=tiff2ps
cp tools/$bin ../
cd ../
ASAN_OPTIONS=detect_leaks=0:handle_abort=1:exitcode=123 UBSAN_OPTIONS=halt_on_error=1:exitcode=123 ./$bin ./exploit
