#!/bin/bash

data=${1:-./example_part1.txt}

numbers=0

while IFS= read -r line; do
    echo "$line"
    first=""
    last=""
    for (( i=0; i<${#line}; i++ )); do
        char="${line:$i:1}"
        if [ -z $first ]; then
            if [ -z "${char//[0-9]}" ]; then
                first=$char
                break
            fi
        fi
    done
    for (( i=(${#line}-1); i>=0; i-- )); do
        char="${line:$i:1}"
        if [ -z $last ]; then
            if [ -z "${char//[0-9]}" ]; then
                last=$char
                break
            fi
        fi
    done
    this="${first}${last}"
    echo "next => $numbers + $this"
    numbers=$((numbers+this))
done < $data

echo "Total: $numbers"