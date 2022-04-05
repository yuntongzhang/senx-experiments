#!/bin/bash

unzip source.zip
cd source/

./configure
make CFLAGS="-static -fsanitize=address -g" CXXFLAGS="-static -fsanitize=address -g" LDFLAGS=" -fsanitize=address"

cp src/potrace ../
