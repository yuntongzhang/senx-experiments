#!/bin/bash
analyze_bc ./tiffsplit.bc 2>analyze.err
timeout 1800 senx tiffsplit.bc ./exploit 2>senx.err
