# SenX Experiments

Scripts and subjects for running SenX on the VulnLoc benchmark.

## Setup and run VM in server

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
