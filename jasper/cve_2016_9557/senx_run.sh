#!/bin/bash
analyze_bc ./imginfo.bc 2>analyze.err
timeout 1800 senx ./imginfo.bc -f ../exploit 2>senx.err
