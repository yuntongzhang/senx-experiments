#!/bin/bash
analyze_bc ./swftophp.bc 2>analyze.err
timeout 1800 senx swftophp.bc ./exploit 2>senx.err
