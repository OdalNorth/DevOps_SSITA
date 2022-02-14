import os
import sys

def create_folder(arg_path, arg_prefix, arg_counts, arg_mode):
    for i in range(1, int(arg_counts) + 1):
        path_folder = os.path.join(f'{arg_path}', f'{arg_prefix}{i}')
        os.mkdir(path_folder, int("0o" + arg_mode, base = 8))

if __name__ == '__main__':
    create_folder(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])

#   rm -drf usr* - delete created folders