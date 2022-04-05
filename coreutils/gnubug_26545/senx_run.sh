#!/bin/bash
analyze_bc ./shred.bc 2>analyze.err
timeout 1800 senx ./shred.bc -n4 -s7 ./dummy 2>senx.err
