#!/bin/bash
analyze_bc ./xmllint.bc 2>analyze.err
timeout 1800 senx xmllint.bc ./exploit 2>senx.err
