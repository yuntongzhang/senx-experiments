#!/bin/bash
git clone git://sourceware.org/git/binutils-gdb.git source
cd source/
git checkout 7a31b38ef87d133d8204cae67a97f1989d25fa18

CC="wllvm" CXX="wllvm++" CFLAGS="-DFORTIFY_SOURCE=2 -fstack-protector-all -fno-omit-frame-pointer -Wno-error -g -O0" CXXFLAGS="$CFLAGS" ./configure --disable-shared --disable-gdb --disable-libdecnumber --disable-readline --disable-sim --disable-werror

make CFLAGS="-g" CXXFLAGS="$CFLAGS"

cp binutils/nm-new ../
cd ../

extract-bc ./nm-new
