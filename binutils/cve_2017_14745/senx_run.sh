#!/bin/bash
analyze_bc ./objdump.bc 2>analyze.err
timeout 1800 senx ./objdump.bc -D ./exploit 2>senx.err
