#!/bin/bash
unzip source.zip
cd source/

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

bin=tiffcrop

cp tools/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
