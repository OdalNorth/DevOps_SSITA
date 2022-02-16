#!/bin/bash

regexp1="^(Кувіл)([аіиу]|ою)\s*$"

while IFS= read -r line
    do
        if [[ $line =~ $regexp1 ]]
        then 
            echo $line
        fi
done < $1