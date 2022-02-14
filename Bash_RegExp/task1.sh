#!/bin/bash

regexp1="^(Кувіл)([аіиу]|ою)\s*$"

while IFS= read -r line
    do
        echo $line | grep -E $regexp1
done < $1