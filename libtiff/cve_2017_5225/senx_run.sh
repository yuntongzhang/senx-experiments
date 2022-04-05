#!/bin/bash
analyze_bc ./tiffcp.bc 2>analyze.err
timeout 1800 senx tiffcp.bc -p separate ./exploit out.tmp 2>senx.err
