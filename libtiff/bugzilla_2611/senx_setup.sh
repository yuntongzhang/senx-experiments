#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout 9a72a69

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

cp tools/tiffmedian ../
cd ../

extract-bc ./tiffmedian
