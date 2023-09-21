#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout 3cfd62d

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

bin=tiffcp

cp tools/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
