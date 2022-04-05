#!/bin/bash
analyze_bc ./potrace.bc 2>analyze.err
timeout 1800 senx potrace.bc ./exploit 2>senx.err
