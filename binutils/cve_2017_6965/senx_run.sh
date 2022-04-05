#!/bin/bash
analyze_bc ./readelf.bc 2>analyze.err
timeout 1800 senx readelf.bc -w ./exploit 2>senx.err
