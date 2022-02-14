import sys
import rpmfile

def rpm_info(path_file):
    with rpmfile.open(path_file) as package:
        rpm_release = package.headers.get('release').decode('ascii')
        rpm_version = package.headers.get('version').decode('ascii')
        
        return f"release: {rpm_release}\nversion: {rpm_version}"

if __name__ == "__main__":
   print(rpm_info(sys.argv[1]))