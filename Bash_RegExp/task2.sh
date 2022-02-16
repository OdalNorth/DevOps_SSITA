#!/bin/bash

regexp2="^(Іван)([ауе]|к[оу])?\s*$|^(Ван)([яіо]|ею|ьок|ьк([ау]|(ові)))\s*$"

while IFS= read -r line
    do
        if [[ $line =~ $regexp2 ]]
        then 
            echo $line
        fi
done < $1