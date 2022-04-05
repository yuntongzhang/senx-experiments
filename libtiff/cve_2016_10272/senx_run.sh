#!/bin/bash
analyze_bc ./tiffcrop.bc 2>analyze.err
timeout 1800 senx tiffcrop.bc -i ./exploit out.tmp 2>senx.err
