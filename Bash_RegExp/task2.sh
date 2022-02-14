#!/bin/bash

regexp2="^(Іван)([ауе]|к[оу])?\s*$|^(Ван)([яіо]|ею|ьок|ьк([ау]|(ові)))\s*$"

while IFS= read -r line
    do
        echo $line | grep -E $regexp2
done < $1