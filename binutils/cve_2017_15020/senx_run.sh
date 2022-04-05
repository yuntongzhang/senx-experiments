#!/bin/bash
analyze_bc ./nm-new.bc 2>analyze.err
timeout 1800 senx ./nm-new.bc -A -a -l -S -s --special-syms --synthetic --with-symbol-versions -D ./exploit 2>senx.err
