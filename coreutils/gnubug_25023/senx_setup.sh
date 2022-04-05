#!/bin/bash

git clone https://github.com/coreutils/coreutils.git source
cd source/
git checkout ca99c52

./bootstrap
export FORCE_UNSAFE_CONFIGURE=1 && CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" src/pr

cp src/pr ../

cd ../
extract-bc ./pr
