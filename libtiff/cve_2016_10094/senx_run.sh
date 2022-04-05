#!/bin/bash
analyze_bc ./tiff2pdf.bc 2>analyze.err
timeout 1800 senx tiff2pdf.bc ./exploit -o foo 2>senx.err
