#!/bin/bash

git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git source
cd source/
git checkout f4b8a5c

export CXXFLAGS="-O0 -fsanitize=address -fsanitize=undefined"
export CFLAGS="-O0 -fsanitize=address -fsanitize=undefined"
# Use the debug build option
cmake -DCMAKE_BUILD_TYPE=Debug CMakeLists.txt
make -j`nproc`

cp ./cjpeg ../

# autoreconf -i
# ./configure CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" --without-simd --enable-static --disable-shared
# make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" -j`nproc`
