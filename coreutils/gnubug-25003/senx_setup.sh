#!/bin/bash

git clone https://github.com/coreutils/coreutils.git source
cd source/
git checkout 68c5eec

./bootstrap
export FORCE_UNSAFE_CONFIGURE=1 && CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static -fPIE" CXXFLAGS="$CFLAGS" ./configure
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static -fPIC -fPIE" CXXFLAGS="$CFLAGS"
# do it again as some other unrelated binary fails for previous step
CC="wllvm" CXX="wllvm++" make CFLAGS="-g -O0 -static -fPIC -fPIE" CXXFLAGS="$CFLAGS" src/split

bin=split

cp src/$bin ../

cd ../
extract-bc ./$bin
llvm-dis ./$bin.bc
