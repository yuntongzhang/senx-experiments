#!/bin/bash
analyze_bc ./make-prime-list.bc 2>analyze.err
timeout 1800 senx ./make-prime-list.bc 5 2>senx.err
