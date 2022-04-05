#!/bin/bash
analyze_bc ./tiff2ps.bc 2>analyze.err
timeout 1800 senx tiff2ps.bc ./exploit 2>senx.err
