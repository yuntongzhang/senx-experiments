#!/bin/bash
bin=tiff2pdf

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc ./exploit -o foo 2>senx.err
