#!/bin/bash

count=0

path_to_file=$1
shell_type=$2

while IFS= read -r line
    do
        if [[ $line =~ $shell_type ]]
        then
            read -d ':' -a user <<< "$line"
            echo "${user[0]}"
            (count+=1)
        fi
done < $path_to_file