#!/bin/bash
git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git source
cd source/
git checkout ae8cdf5


CC="wllvm" CXX="wllvm++" ./configure CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" --without-simd --enable-static --disable-shared
make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" -j`nproc`

bin=cjpeg

cp ./$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
