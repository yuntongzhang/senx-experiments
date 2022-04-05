#!/bin/bash
analyze_bc ./djpeg.bc 2>analyze.err
timeout 1800 senx djpeg.bc -colors 256 -bmp ./exploit 2>senx.err
