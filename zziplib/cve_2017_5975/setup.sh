#!/bin/bash

git clone https://github.com/gdraheim/zziplib.git
mv zziplib source
cd source/
git checkout 33d6e9c
cd docs/
wget https://github.com/LuaDist/libzzip/raw/master/docs/zziplib-manpages.tar
cd ../

./configure
make CFLAGS="-static -fsanitize=address -g" CXXFLAGS="-static -fsanitize=address -g" -j10

cp Linux_5.4.0-91-generic_x86_64.d/bins/unzzipcat-mem ../
