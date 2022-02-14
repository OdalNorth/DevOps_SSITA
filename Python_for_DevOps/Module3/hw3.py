import os
import sys
import paramiko


def create_folder_ssh():
    #variable initialization 
    connection_ip = sys.argv[1]
    port_number = sys.argv[2]
    connection_uname = sys.argv[3]
    arg_path = sys.argv[4]
    arg_prefix = sys.argv[5]
    arg_counts = sys.argv[6]
    arg_mode = sys.argv[7]
    key_ssh = (os.path.join(os.path.expanduser('~'), '.ssh', 'id_rsa'))

    #connection initializate
    ssh = paramiko.SSHClient()
    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh.connect(connection_ip, port = port_number, username = connection_uname, key_filename = key_ssh)

    #create folders
    for i in range(1, int(arg_counts) + 1):
        path_folder = f'{arg_path}' + '/' + f'{arg_prefix}{i}'
        try:
            result_command = f'mkdir -m {arg_mode} {path_folder}'
            stdin, stdout, stderr = ssh.exec_command(result_command)
        except OSError:
            print("Folder creation failed!!!")
        else:
            print(f"Folder created {path_folder}")
    
    ssh.close()



if __name__ == "__main__":
    create_folder_ssh()