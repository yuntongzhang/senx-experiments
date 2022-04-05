#!/bin/bash
git clone https://github.com/vadz/libtiff.git source
cd source/
git checkout 3144e57

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

cp tools/tiffcp ../
cd ../

extract-bc ./tiffcp
