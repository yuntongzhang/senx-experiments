#!/bin/bash
bin=nm-new

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc -A -a -l -S -s --special-syms --synthetic --with-symbol-versions -D ./exploit 2>senx.err
