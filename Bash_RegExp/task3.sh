#!/bin/bash

echo "Type your phone number: "
read number

if $number | grep -P '^(03)(7\d{7}|72\d{6}|722\d{5})$'
    then echo "Your phone number belongs to Chernivtsi "
else 
    echo "your number is not from Chernivtsi"
fi