#!/bin/bash
git clone https://github.com/libjpeg-turbo/libjpeg-turbo.git source
cd source/
git checkout 4f24016

autoreconf -fiv
CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" ./configure

make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"

cp ./djpeg ../
cd ../

extract-bc ./djpeg
