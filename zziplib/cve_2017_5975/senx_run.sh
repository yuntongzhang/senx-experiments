#!/bin/bash
analyze_bc ./unzzipcat-mem.bc 2>analyze.err
timeout 1800 senx unzzipcat-mem.bc ./exploit 2>senx.err
