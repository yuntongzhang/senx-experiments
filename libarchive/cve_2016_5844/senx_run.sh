#!/bin/bash
analyze_bc ./bsdtar.bc 2>analyze.err
timeout 1800 senx bsdtar.bc -tf ./libarchive-signed-int-overflow.iso 2>senx.err
