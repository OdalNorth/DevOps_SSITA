#!/bin/bash

file=$(find $1 -maxdepth 1 -type f -cmin -$2)
echo -e "$file"