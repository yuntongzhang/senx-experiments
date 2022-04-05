#!/bin/bash
analyze_bc ./tiffcp.bc 2>analyze.err
timeout 1800 senx tiffcp.bc -i ./exploit ./tmpout.tif 2>senx.err
