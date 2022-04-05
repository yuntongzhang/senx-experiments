#!/bin/bash
git clone https://github.com/gdraheim/zziplib.git source
cd source/
git checkout 33d6e9c

cd docs/
wget https://github.com/LuaDist/libzzip/raw/master/docs/zziplib-manpages.tar
cd ../


CC="wllvm" CXX="wllvm++" CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS" ./configure --enable-static --disable-shared

make CFLAGS="-g -O0 -static" CXXFLAGS="$CFLAGS"

cp Linux_4.4.0-210-generic_x86_64.d/bins/unzzipcat-mem ../
cd ../

extract-bc ./unzzipcat-mem
