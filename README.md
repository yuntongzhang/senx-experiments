# SenX Experiments

Contains setup and results from running [SenX](https://ieeexplore.ieee.org/abstract/document/8835226)
on the [VulnLoc](https://github.com/VulnLoc/VulnLoc) benchmark.


## Vulnerabilities

Vulnerability details are in the file `meta-data`.


## Details for each vulnerability

For each vulnerability, its directory contains script for setting up and running SenX on it.

- `senx_setup.sh`: script to download and build the vulnerable program to run with SenX.
- `senx_run.sh`: script to do preparation and run SenX.
- `exploit`: exploit input to trigger the vulnerability.
- `dev.patch`: developer patch for reference.
- `setup.sh`: script to download and build the vulnerable program with sanitizers. The sanitizers
are used as oracles to turn the vulnerability into a crash and thus determine whether the
vulnerability is still present.


## Results for each vulnerability

Results for each vulnerability are stored in the `results-N` directories in each of the vulnerability
directory. The larger `N` is, the more recent the results are. Therefore, please refer to the
directories with the largest `N` for the latest result. In the `result-N` directory, there are a few
files:

- `analyze.err`: error log from running `analyze_bc` (a pre-step for SenX).
- `senx.err`: error log from running `senx` itself.
- `*.patch` (optional): the patch file produced by SenX (if a patch is successfully generated).


## Results summary

The results of running SenX are summarized in the following table. SenX currently supports buffer
overflows, bad casts, and integer overflows. Vulnerabilities that are not of these types are marked
with `Not Applicable`.

For the other vulnerabilities, if there is a patch file generated,
the column `Patch generated?` is marked as `Yes`; otherwise, it is marked with `No`. For those with
a patch file generated, the patch file is further examined by applying it on the vulnerable program,
compiling the patched program, and run the patched program with the exploit input. If the patched
program does not exhibit the vulnerability with the exploit input, the volumn `Patch correct?` is
marked as `Correct`. Otherwise, if compilation fails after applying the patch, it is marked as
`Wrong (cannot compile)`; if compilation succeeds but the vulnerability is still present with the
exploit input, it is marked as `Wrong (exploit sstill fail)`.


| Bug ID | Program | Vulnerability | Patch generated? | Patch correct? |
| :----: | :-----: | :-----------: | :--------------: | :------------: |
| 1 | binutils | cve_2017_6965 | No | - |
| 2 | binutils | cve_2017_14745 | No | - |
| 3 | binutils | cve_2017_15020 | No | - |
| 4 | binutils | cve_2017_15025 | _Not applicable_ | _Not applicable_ |
| 5 | coreutils | gnubug_19784 | No | - |
| 6 | coreutils | gnubug_25003 | No | - |
| 7 | coreutils | gnubug_25023 | No | - |
| 8 | coreutils | gnubug_26545 | No | - |
| 9 | jasper | cve_2016_8691 | _Not applicable_ | _Not applicable_ |
| 10 | jasper | cve_2016_9557 | No | - |
| 11 | libarchive | cve_2016_5844 | Yes | Wrong (cannot compile) |
| 12 | libjpeg | cve_2012_2806 | No | - |
| 13 | libjpeg | cve_2017_15232 | _Not applicable_ | _Not applicable_ |
| 14 | libjpeg | cve_2018_14498 | No | - |
| 15 | libjpeg | cve_2018_19664 | No | - |
| 16 | libming | cve_2016_9264 | Yes | Wrong (exploit still fail) |
| 17 | libming | cve_2018_8806 | _Not applicable_ | _Not applicable_ |
| 18 | libming | cve_2018_8964 | _Not applicable_ | _Not applicable_ |
| 19 | libtiff | bugzilla_2611 | _Not applicable_ | _Not applicable_ |
| 20 | libtiff | bugzilla_2633 | Yes | Correct |
| 21 | libtiff | cve_2016_5321 | Yes | Wrong (exploit still fail) |
| 22 | libtiff | cve_2016_9273 | No | - |
| 23 | libtiff | cve_2016_9532 | Yes | Wrong (cannot compile) |
| 24 | libtiff | cve_2016_10092 | Yes | Wrong (exploit still fail) |
| 25 | libtiff | cve_2016_10094 | Yes | Correct |
| 26 | libtiff | cve_2016_10272 | Yes | Wrong (exploit still fail) |
| 27 | libtiff | cve_2017_5225 | Yes | Correct |
| 28 | libtiff | cve_2017_7595 | _Not applicable_ | _Not applicable_ |
| 29 | libtiff | cve_2017_7599 | No | - |
| 30 | libtiff | cve_2017_7600 | No | - |
| 31 | libtiff | cve_2017_7601 | No | - |
| 32 | libxml2 | cve_2012_5134 | No | - |
| 33 | libxml2 | cve_2016_1838 | No | - |
| 34 | libxml2 | cve_2016_1839 | No | - |
| 35 | libxml2 | cve_2017_5969 | _Not applicable_ | _NA_ (though a patch produced but cannot compile) |
| 36 | potrace | cve_2013_7437 | Yes | Correct |
| 37 | zziplib | cve_2017_5974 | No | - |
| 38 | zziplib | cve_2017_5975 | No | - |
| 39 | zziplib | cve_2017_5976 | No | - |


## Steps used in experiments

To run SenX on the experiment benchmark, first set up the SenX VM:

```bash
# register the unzipped VM
VBoxManage registervm '/home/yuntong/Ubuntu 16.04 - Senx/Ubuntu 16.04 - Senx.vbox'
# fix issue for "Nonexistent host networking interface, name 'vboxnet0' (VERR_INTERNAL_ERROR)"
VBoxManage hostonlyif create
# fix issue for "cpum#1: X86_CPUID_AMD_FEATURE_EDX_AXMMX is not supported by the host but has already exposed to the guest [ver=19 pass=final] (VERR_SSM_LOAD_CPUID_MISMATCH)"
VBoxManage discardstate "Ubuntu 16.04 - Senx"
# start the VM in headless mode
VBoxHeadless --startvm "Ubuntu 16.04 - Senx"
# ssh into it, passwd is `user`
ssh -p 3022 user@127.0.0.1
```

Once land in the VM, clone this repo:

```bash
git clone https://github.com/yuntongzhang/senx-experiments.git
cd senx-experiments
```

Next, put the file `offsets.py` at correct place:

```bash
cp offsets.py /home/user/bin/
```

Set up additional gdb command by adding the following lines to `/home/user/.gdbinit`:

```
python import sys
python sys.path.append("/home/user/bin")
python import offsets
```

Now, set up and run all the vulnerabilities with the driver script:

```bash
python3 driver.py --setup
python3 driver.py --run
python3 driver.py --saveres
```
