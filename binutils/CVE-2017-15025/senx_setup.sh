#!/bin/bash
git clone git://sourceware.org/git/binutils-gdb.git source
cd source/
git checkout 515f23e63c0074ab531bc954f84ca40c6281a724

CC="wllvm" CXX="wllvm++" CFLAGS="-DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer -Wno-error -g -O0" CXXFLAGS="$CFLAGS" ./configure --disable-shared --disable-gdb --disable-libdecnumber --disable-readline --disable-sim --disable-werror

make CFLAGS="-g" CXXFLAGS="$CFLAGS"

bin=nm-new

cp binutils/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
