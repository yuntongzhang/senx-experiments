import json
import os
import re
import subprocess
from datetime import datetime
from os.path import join as pjoin

FILE_META_DATA = "meta-data.json"

all_in_vulnloc_bench = list(range(1, 44)) # 43 entries in total
ffmpeg_bugs = [9, 10]
DEFAULT_LIST = [ x for x in all_in_vulnloc_bench if x not in ffmpeg_bugs ] # 41 entries in total

def main():
    vul_ids_to_run = DEFAULT_LIST

    with open(FILE_META_DATA, 'r') as f:
        vulnerabilities = json.load(f)

    curr_dir = os.getcwd()

    patch_fail_build = []
    patch_still_crash = []
    patch_plausible = []

    for vulnerability in vulnerabilities:
        if int(vulnerability['id']) not in vul_ids_to_run:
            continue

        bug_name = str(vulnerability['bug_id'])
        subject = str(vulnerability['subject'])

        vul_dir = os.path.join(curr_dir, subject, bug_name)
        existing_dirs = os.listdir(vul_dir)
        num_existing_res = 0
        res_dir_pattern = re.compile("^result-([0-9]+)")
        for dir in existing_dirs:
            if res_dir_pattern.match(dir):
                this_num = int(res_dir_pattern.match(dir).group(1))
                num_existing_res = max(num_existing_res, this_num)
        if num_existing_res == 0:
            # no result
            continue
        latest_dir = pjoin(vul_dir, "result-" + str(num_existing_res))
        patch = pjoin(latest_dir, "formatted.patch")
        if not os.path.isfile(patch):
            # no patch file
            continue

        # now we finally should process patch for this bug
        now = datetime.now()
        print("\n\033[34m[{}] Processing {} {} ... \033[0m".format(now, subject, bug_name))

        os.chdir(vul_dir)

        cp = subprocess.run("./senx_test.sh", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        rc = cp.returncode
        if rc == 122:
            print("\033[91m Build patched program failed ... \033[0m")
            patch_fail_build.append(bug_name)
        elif rc == 123:
            print("\033[91m Patch did not resolve crash in the exploit ... \033[0m")
            patch_still_crash.append(bug_name)
        else:
            print("\033[92m Patch is plausible ... \033[0m")
            patch_plausible.append(bug_name)
        
        os.chdir(curr_dir)

    if patch_fail_build:
        print("\033[91m Patched program failed to build for the following vulnerabilities: \033[0m")
        for bug_name in patch_fail_build:
            print("\033[91m {} \033[0m".format(bug_name))

    if patch_still_crash:
        print("\033[91m Patched program still crashes for the following vulnerabilities: \033[0m")
        for bug_name in patch_still_crash:
            print("\033[91m {} \033[0m".format(bug_name))
    
    if patch_plausible:
        print("\033[96m Patch is plausible for the following vulnerabilities: \033[0m")
        for bug_name in patch_plausible:
            print("\033[96m {} \033[0m".format(bug_name))

if __name__ == "__main__":
    main()
