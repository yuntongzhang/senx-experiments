#!/bin/bash

git clone https://github.com/coreutils/coreutils.git source
cd source/
git checkout 8d34b45

./bootstrap
export FORCE_UNSAFE_CONFIGURE=1 && CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" src/shred

cp src/shred ../

cd ../
extract-bc ./shred
