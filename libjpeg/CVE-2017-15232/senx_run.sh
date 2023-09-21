#!/bin/bash
bin=djpeg

analyze_bc ./$bin.bc 2>analyze.err
python3 ../../prepare_gdb_def.py $bin $(pwd)
timeout 1800 senx -struct-def=def_file ./$bin.bc -crop "1x1+16+16" -onepass -dither ordered -dct float -colors 8 -targa -grayscale -outfile o ./exploit 2>senx.err
