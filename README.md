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
| 1 | binutils | CVE-2017-14745 | No | - |
| 2 | binutils | CVE-2017-15020 | No | - |
| 3 | binutils | CVE-2017-15025 | _Not applicable_ | -_Not applicable_|
| 4 | binutils | CVE-2017-6965 | No | - |
| 5 | coreutils | gnubug-19784 | No | - |
| 6 | coreutils | gnubug-25003 | No | - |
| 7 | coreutils | gnubug-25023 | No | - |
| 8 | coreutils | gnubug-26545 | No | - |
| 11 | jasper | CVE-2016-8691 | _Not applicable_ | _Not applicable_ |
| 12 | jasper | CVE-2016-9557 | No | - |
| 13 | libarchive | CVE-2016-5844 | Yes | Wrong (cannot compile) |
| 14 | libjpeg | CVE-2012-2806 | No | - |
| 15 | libjpeg | CVE-2017-15232 | _Not applicable_ | _Not applicable_ |
| 16 | libjpeg | CVE-2018-14498 | No | - |
| 17 | libjpeg | CVE-2018-19664 | No | - |
| 18 | libming | CVE-2016-9264 | Yes | Wrong (exploit still fail) |
| 19 | libming | CVE-2018-8806 | _Not applicable_ | _Not applicable_ |
| 20 | libming | CVE-2018-8964 | _Not applicable_ | _Not applicable_ |
| 21 | libtiff | bugzilla-2611 | _Not applicable_ | _Not applicable_ |
| 22 | libtiff | bugzilla-2633 | Yes | Correct |
| 23 | libtiff | CVE-2016-10092 | Yes | Wrong (exploit still fail) |
| 24 | libtiff | CVE-2016-10094 | Yes | Correct |
| 25 | libtiff | CVE-2016-10272 | Yes | Wrong (exploit still fail) |
| 26 | libtiff | CVE-2016-3186 |   |   |
| 27 | libtiff | CVE-2016-5314 |   |   |
| 28 | libtiff | CVE-2016-5321 | Yes | Wrong (exploit still fail) |
| 29 | libtiff | CVE-2016-9273 | No | - |
| 30 | libtiff | CVE-2016-9532 | Yes | Wrong (cannot compile) |
| 31 | libtiff | CVE-2017-5225 | Yes | Correct |
| 32 | libtiff | CVE-2017-7595 | _Not applicable_ | _Not applicable_ |
| 33 | libtiff | CVE-2017-7599 | No | - |
| 34 | libtiff | CVE-2017-7600 | No | - |
| 35 | libtiff | CVE-2017-7601 | No | - |
| 36 | libxml2 | CVE-2012-5134 | No | - |
| 37 | libxml2 | CVE-2016-1838 | No | - |
| 38 | libxml2 | CVE-2016-1839 | No | - |
| 39 | libxml2 | CVE-2017-5969 | _Not applicable_ | _NA_ (though a patch produced but cannot compile) |
| 40 | potrace | CVE-2013-7437 | Yes | Correct |
| 41 | zziplib | CVE-2017-5974 | No | - |
| 42 | zziplib | CVE-2017-5975 | No | - |
| 43 | zziplib | CVE-2017-5976 | No | - |


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

Once land in the VM, install some deps to build experimental subjects

1. remove content in `/etc/apt/apt.conf`
2. Install python3.8
```
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz
tar -xf Python-3.8.0.tgz
cd Python-3.8.0
./configure --enable-optimizations
make -j`nproc`
sudo make altinstall
```
3. Install wllvm
```
sudo python3.8 -m pip install wllvm
```
4. Install llvm
```
sudo apt install clang llvm
```
5. set env var
```
export LLVM_COMPILER=clang
```

To run the benchmark, clone this repo first:

```bash
git clone https://github.com/yuntongzhang/senx-experiments.git
cd senx-experiments
git checkout fuzzrepair-instr
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
