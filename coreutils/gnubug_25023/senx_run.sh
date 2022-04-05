#!/bin/bash
analyze_bc ./pr.bc 2>analyze.err
timeout 1800 senx ./pr.bc "-S$(printf "\t\t\t")" ./dummy -m ./dummy 2>senx.err
