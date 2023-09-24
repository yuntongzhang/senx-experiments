#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout f3069a5

# instrumentation
sed -i '2443i if(0) return;' tools/tiff2ps.c

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

bin=tiff2ps

cp tools/$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
