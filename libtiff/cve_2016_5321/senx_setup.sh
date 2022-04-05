#!/bin/bash
unzip source.zip
cd source/

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

cp tools/tiffcrop ../
cd ../

extract-bc ./tiffcrop
