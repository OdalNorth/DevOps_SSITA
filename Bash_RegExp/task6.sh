#!/bin/bash

path_to_file=$1
group="^$2"

while IFS= read -r line
    do
        if [[ ! $line =~ $group ]]
        then
            echo $line
        fi
done < $path_to_file