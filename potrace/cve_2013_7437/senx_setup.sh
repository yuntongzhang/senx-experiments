#!/bin/bash

unzip source.zip
cd source/

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static" CPPFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0 -static" CPPFLAGS="$CFLAGS" -j10

bin=potrace

cp src/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
