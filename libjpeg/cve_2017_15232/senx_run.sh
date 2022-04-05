#!/bin/bash
analyze_bc ./djpeg.bc 2>analyze.err
timeout 1800 senx djpeg.bc -crop "1x1+16+16" -onepass -dither ordered -dct float -colors 8 -targa -grayscale -outfile o ./exploit 2>senx.err
