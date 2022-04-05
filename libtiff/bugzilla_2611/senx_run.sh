#!/bin/bash
analyze_bc ./tiffmedian.bc 2>analyze.err
timeout 1800 senx tiffmedian.bc ./exploit out.tmp 2>senx.err
