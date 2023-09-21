#!/bin/bash

git clone https://github.com/gdraheim/zziplib.git
mv zziplib source
cd source/
git checkout 3a4ffcd
# git checkout 03de3beabbf570474a9ac05d6dc6b42cdb184cd1
cd docs/
wget https://github.com/LuaDist/libzzip/raw/master/docs/zziplib-manpages.tar
cd ../

./configure
make CFLAGS="-static -fsanitize=address -g" CXXFLAGS="-static -fsanitize=address -g" -j10

cp Linux_5.4.0-91-generic_x86_64.d/bins/unzzipcat-mem ../
# cp Linux_5.10.16.3-microsoft-standard-WSL2_x86_64.d/bins/unzzipcat-mem ../
