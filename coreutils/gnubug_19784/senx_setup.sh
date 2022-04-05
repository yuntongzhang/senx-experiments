#!/bin/bash

git clone https://github.com/coreutils/coreutils.git source
cd source/
git checkout 658529a

./bootstrap
export FORCE_UNSAFE_CONFIGURE=1 && CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"./configure
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" src/make-prime-list

cp src/make-prime-list ../

cd ../
extract-bc ./make-prime-list
