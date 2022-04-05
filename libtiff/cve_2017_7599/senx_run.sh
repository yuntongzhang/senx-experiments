#!/bin/bash
bin=tiffcp

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc -i ./exploit ./tmpout.tif 2>senx.err
