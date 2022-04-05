"""
Runs gdb to prepare defs files for senx.
"""

import os
import sys

binary_name = sys.argv[1]
invoke_dir = sys.argv[2]

llvm_ir_name = binary_name + ".ll"
gdb_script_name = "gdb_script"
def_file_name = "def_file"

binary_path = os.path.join(invoke_dir, binary_name)
llvm_ir_path = os.path.join(invoke_dir, llvm_ir_name)
gdb_script_path = os.path.join(invoke_dir, gdb_script_name)
def_file_path = os.path.join(invoke_dir, def_file_name)

struct_list = []
with open(llvm_ir_path, "r") as input_file:
    content_lines = input_file.readlines()
    for line in content_lines:
        if "@" in line:
            break
        if "struct" in line:
            struct_name = line.split(" = ")[0].split(".")[1]
            first_occ = struct_name.find(next(filter(str.isalpha, struct_name)))
            struct_list.append(struct_name[first_occ:])

with open(gdb_script_path, "w") as out_file:
    for struct_name in struct_list:
        out_file.writelines("offsets-of \"{}\"\n".format(struct_name))
        out_file.writelines("printf \"\\n\"\n")

os.system("gdb -batch -silent -x {} {} > {}".format(gdb_script_path, binary_path, def_file_path))
