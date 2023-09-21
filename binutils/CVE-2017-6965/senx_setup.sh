#!/bin/bash
git clone git://sourceware.org/git/binutils-gdb.git source
cd source/
git checkout 53f7e8ea7fad1fcff1b58f4cbd74e192e0bcbc1d

CC="wllvm" CXX="wllvm++" CFLAGS="-DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer -Wno-error -g -O0" CXXFLAGS="$CFLAGS" ./configure --disable-shared --disable-gdb --disable-libdecnumber --disable-readline --disable-sim --disable-werror

make CFLAGS="-g" CXXFLAGS="$CFLAGS"

bin=readelf

cp binutils/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
