import os
import sys
import json

result_json = {
    'id' : 0,
    'number' : 0,
    'committer_name' : '',
    'committer_email' : ''
}

def json_parse(path_files, path_result):
    for selected_file in os.listdir(path_files):
        if selected_file.endswith(".json"):
            file_Dir = os.path.join(path_files, selected_file)

            with open(file_Dir) as input_file:
                data_json = json.load(input_file)

            if (int(data_json['result']) != 0) and (int(data_json['number']) > int(result_json['number'])):
                result_json['id'] = data_json['id']
                result_json['number'] = data_json['number']
                result_json['committer_name'] = data_json['committer_name']
                result_json['committer_email'] = data_json['committer_email']

            with open(path_result, "w") as output_json:
                #file_json.write(json.JSONEncoder().encode(result_json))
                json.dump(result_json, output_json, indent = 4, sort_keys = False)


if __name__ == '__main__':
    json_parse(sys.argv[1], sys.argv[2])