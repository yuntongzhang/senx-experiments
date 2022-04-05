#!/bin/bash
analyze_bc ./listmp3.bc 2>analyze.err
timeout 1800 senx listmp3.bc ./exploit 2>senx.err
