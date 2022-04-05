#!/bin/bash
wget https://libarchive.org/downloads/libarchive-3.2.0.zip
unzip libarchive-3.2.0.zip
rm libarchive-3.2.0.zip
mv libarchive-3.2.0 source
cd source/

CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" ./configure --without-openssl

make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"

cp ./bsdtar ../
cd ../

extract-bc ./bsdtar
