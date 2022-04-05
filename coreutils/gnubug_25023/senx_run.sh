#!/bin/bash
bin=pr

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc "-S$(printf "\t\t\t")" ./dummy -m ./dummy 2>senx.err
