#!/bin/bash
git clone https://github.com/libming/libming.git source
cd source/
git checkout c4d20b1

./autogen.sh
CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" ./configure --disable-freetype

make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"

bin=swftophp

cp util/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
