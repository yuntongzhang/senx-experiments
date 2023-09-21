#!/bin/bash
bin=split

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc -n7/75 ./dummy 2>senx.err
