#!/bin/bash
analyze_bc ./cjpeg.bc 2>analyze.err
timeout 1800 senx cjpeg.bc -outfile out.tmp ./exploit 2>senx.err
