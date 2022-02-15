#!/bin/bash

count=0

path_to_file=$1
target_file=$2

files_list=$(ls -R $path_to_file)

while read line
    do
        if [[ $line =~ "$target_file"$ ]]
        then
            ((count+=1))
        fi
done <<< $files_list

echo $count