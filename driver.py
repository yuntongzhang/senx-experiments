import argparse
import json
import os

FILE_META_DATA = "meta-data"

def main():
    parser = argparse.ArgumentParser(description="Driver to run SenX on all vulnerabilities.")
    parser.add_argument('--setup', default=False, action='store_true',
                        help='Only setup the vulnerabilities.')
    parser.add_argument('--run', default=False, action='store_true',
                        help='Only run the vulnerabilities.')

    parsed_args = parser.parse_args()
    setup_only = parsed_args.setup
    run_only = parsed_args.run

    with open(FILE_META_DATA, 'r') as f:
        vulnerabilities = json.load(f)

    curr_dir = os.getcwd()
    for vulnerability in vulnerabilities:
        bug_name = str(vulnerability['bug_id'])
        subject = str(vulnerability['subject'])
        vul_dir = os.path.join(curr_dir, subject, bug_name)
        os.chdir(vul_dir)
        if not run_only:
            os.system("./senx_setup.sh")
        if not setup_only:
            os.system("./senx_run.sh")
        os.chdir(curr_dir)


if __name__ == "__main__":
    main()
