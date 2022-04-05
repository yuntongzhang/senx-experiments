#!/bin/bash

unzip source.zip
cd source/

autoreconf -i
CC="wllvm" CXX="wllvm++" CFLAGS="-static -g -O0" CXXFLAGS="$CFLAGS" ./configure
make CFLAGS="-static -g -O0" CXXFLAGS="$CFLAGS"

cp src/appl/imginfo ../
cd ../

extract-bc ./imginfo
