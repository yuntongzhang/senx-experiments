#!/bin/bash
git clone https://gitlab.gnome.org/GNOME/libxml2.git source
cd source/
git checkout cbb27165

./autogen.sh
CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared --without-threads --without-lzma

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

bin=xmllint

cp ./$bin ../
cd ../

extract-bc ./$bin
llvm-dis ./$bin.bc
