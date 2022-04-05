#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout b28076b

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

bin=tiff2pdf

cp tools/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
