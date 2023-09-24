import argparse
import json
import os
import re
import shutil
import glob
import subprocess
from datetime import datetime

FILE_META_DATA = "meta-data.json"

FILE_ANALYZE_ERR = "analyze.err"
FILE_SENX_ERR = "senx.err"
FILE_STRUCT_DEF = "def_file"
FILE_GDB_SCRIPT = "gdb_script"

PATTERN_TALOS = "*.bc.talos"
PATTERN_PATCH = "*.bc.patch"

all_in_vulnloc_bench = list(range(1, 44)) # 43 entries in total
ffmpeg_bugs = [9, 10]
DEFAULT_LIST = [ x for x in all_in_vulnloc_bench if x not in ffmpeg_bugs ] # 41 entries in total

def main():
    parser = argparse.ArgumentParser(description="Driver to run SenX on all vulnerabilities.")
    parser.add_argument('--setup', default=False, action='store_true',
                        help='Only setup the vulnerabilities.')
    parser.add_argument('--run', default=False, action='store_true',
                        help='Only run the vulnerabilities.')
    parser.add_argument('--saveres', default=False, action='store_true',
                        help='Only save the result of previous run to some dir.')
    parser.add_argument('--cleanup', default=False, action='store_true',
                        help='Clean up files generated from last run.')
    parser.add_argument('--bug', action='append', type=int,
                        help='Specify which bug(s) to run. If nothing specified, all will be run.')

    parsed_args = parser.parse_args()
    setup_only = parsed_args.setup
    run_only = parsed_args.run
    save_result = parsed_args.saveres
    clean_up = parsed_args.cleanup
    selected_vul_list = parsed_args.bug

    if selected_vul_list: # user speicified some
        vul_ids_to_run = selected_vul_list
    else: # user did not specify anything
        vul_ids_to_run = DEFAULT_LIST

    with open(FILE_META_DATA, 'r') as f:
        vulnerabilities = json.load(f)

    curr_dir = os.getcwd()

    vuls_failed_setup = [] # records which one failed setup
    vuls_generated_patch = [] # records which one generated patch

    for vulnerability in vulnerabilities:
        if int(vulnerability['id']) not in vul_ids_to_run:
            continue

        bug_name = str(vulnerability['bug_id'])
        subject = str(vulnerability['subject'])

        now = datetime.now()
        print("\n\033[34m[{}] Processing {} {} ... \033[0m".format(now, subject, bug_name))

        vul_dir = os.path.join(curr_dir, subject, bug_name)
        os.chdir(vul_dir)
        if save_result:
            # determine the name for result directory
            existing_dirs = os.listdir(vul_dir)
            num_existing_res = 0
            res_dir_pattern = re.compile("^result-([0-9]+)")
            for dir in existing_dirs:
                if res_dir_pattern.match(dir):
                    this_num = int(res_dir_pattern.match(dir).group(1))
                    num_existing_res = max(num_existing_res, this_num)
            new_dir_name = "result-" + str(num_existing_res + 1)
            # copy files generated from previous run to new result directory
            os.mkdir(new_dir_name)
            if os.path.isfile(FILE_ANALYZE_ERR):
                shutil.copy2(FILE_ANALYZE_ERR, new_dir_name)
            if os.path.isfile(FILE_SENX_ERR):
                shutil.copy2(FILE_SENX_ERR, new_dir_name)
            generated_patch = glob.glob(PATTERN_PATCH)
            for p in generated_patch:
                shutil.copy2(p, new_dir_name)
            continue

        if clean_up:
            files_to_remove = [FILE_ANALYZE_ERR, FILE_SENX_ERR, FILE_STRUCT_DEF, FILE_GDB_SCRIPT]
            old_patch = glob.glob(PATTERN_PATCH)
            old_talos = glob.glob(PATTERN_TALOS)
            files_to_remove.extend(old_patch)
            files_to_remove.extend(old_talos)
            for f in files_to_remove:
                if os.path.isfile(f):
                    os.remove(f)
            continue

        if not run_only:
            # see if this one has already been setup
            ll_file = glob.glob("*.ll")
            if ll_file:
                print("Already built. Skipping building of this one ...")
            else:
                cp = subprocess.run("./senx_setup.sh", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                if cp.returncode != 0:
                    print("\033[91m Error in setup. Please check ... \033[0m")
                    vuls_failed_setup.append(bug_name)
                else:
                    print("\033[92m Setup success. \033[0m")
                
        if not setup_only:
            os.system("./senx_run.sh")
            # check whether a patch file is produced
            generated_patch = glob.glob("*.bc.patch")
            if generated_patch:
                print("\033[96m A patch has been generated. Please check. \033[0m")
                vuls_generated_patch.append(bug_name)
        os.chdir(curr_dir)

    if vuls_failed_setup:
        print("\033[91m Failed to setup the following vulnerabilities: \033[0m")
        for bug_name in vuls_failed_setup:
            print("\033[91m {} \033[0m".format(bug_name))
    
    if vuls_generated_patch:
        print("\033[96m The following vulnerabilities generated patches: \033[0m")
        for bug_name in vuls_generated_patch:
            print("\033[96m {} \033[0m".format(bug_name))

if __name__ == "__main__":
    main()
