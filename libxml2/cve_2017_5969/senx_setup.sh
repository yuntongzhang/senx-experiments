#!/bin/bash
git clone https://gitlab.gnome.org/GNOME/libxml2.git source
cd source/
git checkout 362b3229

./autogen.sh
CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared --without-threads --without-lzma

make CFLAGS="-g -O0" CXXFLAGS="$CFLAGS"

cp ./xmllint ../
cd ../

extract-bc ./xmllint
