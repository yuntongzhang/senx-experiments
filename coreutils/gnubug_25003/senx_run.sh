#!/bin/bash
analyze_bc ./split.bc 2>analyze.err
timeout 1800 senx ./split.bc -n7/75 ./dummy 2>senx.err
