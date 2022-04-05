#!/bin/bash

unzip source.zip
cd source/

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"

cp src/potrace ../
cd ../

extract-bc ./potrace
