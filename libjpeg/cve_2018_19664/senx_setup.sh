#!/bin/bash
git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git source
cd source/
git checkout beefb62

mkdir build; cd build;
cmake -G"Unix Makefiles" -DCMAKE_C_COMPILER="wllvm"  -DCMAKE_C_FLAGS_RELEASE='-g -O0 -D_NO_STRING_INLINES -DFORTIFY_SOURCE=0' -DREQUIRE_SIMD=0 -DWITH_SIMD=0 ..

make

cp ./djpeg ../../
cd ../../

extract-bc ./djpeg
