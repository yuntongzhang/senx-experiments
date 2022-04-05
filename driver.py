import argparse
import json
import os
import re
import shutil
import glob

FILE_META_DATA = "meta-data"

def main():
    parser = argparse.ArgumentParser(description="Driver to run SenX on all vulnerabilities.")
    parser.add_argument('--setup', default=False, action='store_true',
                        help='Only setup the vulnerabilities.')
    parser.add_argument('--run', default=False, action='store_true',
                        help='Only run the vulnerabilities.')
    parser.add_argument('--saveres', default=False, action='store_true',
                        help='Only save the result of previous run to some dir.')

    parsed_args = parser.parse_args()
    setup_only = parsed_args.setup
    run_only = parsed_args.run
    save_result = parsed_args.saveres

    with open(FILE_META_DATA, 'r') as f:
        vulnerabilities = json.load(f)

    curr_dir = os.getcwd()
    for vulnerability in vulnerabilities:
        bug_name = str(vulnerability['bug_id'])
        subject = str(vulnerability['subject'])

        print("Processing {} {} ...".format(subject, bug_name))

        vul_dir = os.path.join(curr_dir, subject, bug_name)
        os.chdir(vul_dir)
        if save_result:
            # determine the name for result directory
            existing_dirs = [x[0] for x in os.walk(vul_dir)]
            num_existing_res = 0
            res_dir_pattern = re.compile("^result-([0-9]+)")
            for dir in existing_dirs:
                if res_dir_pattern.match(dir):
                    this_num = int(res_dir_pattern.match(dir).group(1))
                    num_existing_res = max(num_existing_res, this_num)
            new_dir_name = "result-" + str(num_existing_res + 1)
            # copy files generated from previous run to new result directory
            os.mkdir(new_dir_name)
            if os.path.isfile("analyze.err"):
                shutil.copy2("analyze.err", new_dir_name)
            if os.path.isfile("senx.err"):
                shutil.copy2("senx.err", new_dir_name)
            generated_patch = glob.glob("*.bc.patch")
            for p in generated_patch:
                shutil.copy2(p, new_dir_name)
            continue

        if not run_only:
            os.system("./senx_setup.sh")
        if not setup_only:
            os.system("./senx_run.sh")
            # check whether a patch file is produced
            generated_patch = glob.glob("*.bc.patch")
            if generated_patch:
                print("A patch has been generated. Please check.")
        os.chdir(curr_dir)


if __name__ == "__main__":
    main()
