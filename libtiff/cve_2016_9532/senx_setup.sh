#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout d651abc

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

cp tools/tiffcrop ../
cd ../

extract-bc ./tiffcrop
