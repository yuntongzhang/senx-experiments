#!/bin/bash
analyze_bc ./tiffcrop.bc 2>analyze.err
timeout 1800 senx tiffcrop.bc ./exploit ./tmpout.tif 2>senx.err
