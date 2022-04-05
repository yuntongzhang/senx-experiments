#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout b28076b

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

cp tools/tiff2pdf ../
cd ../

extract-bc ./tiff2pdf
