import sys
import json

def sort_json(arg_input, arg_output):
    with open(arg_input, 'r') as input_data:
        input_file = json.load(input_data)

        with open(arg_output, 'w') as output_data:
            json.dump(input_file, output_data, indent = 4, sort_keys = False)

if __name__ == '__main__':
    sort_json(sys.argv[1], sys.argv[2])