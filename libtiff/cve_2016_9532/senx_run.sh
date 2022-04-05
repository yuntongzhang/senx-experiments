#!/bin/bash
analyze_bc ./tiffcrop.bc 2>analyze.err
timeout 1800 senx tiffcrop.bc ./exploit out.tmp 2>senx.err
