#!/bin/bash
bin=djpeg

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc -colors 256 -bmp ./exploit 2>senx.err
