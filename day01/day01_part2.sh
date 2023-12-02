#!/bin/bash

data=${1:-./example_part2.txt}

numbers=0
words="one two three four five six seven eight nine"

get_number() {
    local word=$1
    case $word in
        "one")
            echo "1"
            ;;
        "two")
            echo "2"
            ;;
        "three")
            echo "3"
            ;;
        "four")
            echo "4"
            ;;
        "five")
            echo "5"
            ;;
        "six")
            echo "6"
            ;;
        "seven")
            echo "7"
            ;;
        "eight")
            echo "8"
            ;;
        "nine")
            echo "9"
            ;;
        *)
            echo "0"
            ;;
        esac
}

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
        if [ $char = "o" ] || [ $char = "t" ] || [ $char = "f" ] || [ $char = "s" ] || [ $char = "e" ] ||[ $char = "n" ]; then 
            for word in $words; do
                wordlen=${#word}
                if [ "$word" = "${line:$i:wordlen}" ]; then
                    first=$(get_number $word)
                    # echo "FIRST: $first"
                    break 2
                fi 
            done
        fi
    done
    for (( i=(${#line}-1); i>=0; i-- )); do
        char="${line:$i:1}"
        # echo "$char"
        if [ -z $last ]; then
            if [ -z "${char//[0-9]}" ]; then
                last=$char
                break
            fi
        fi
        if [ $char = "o" ] || [ $char = "t" ] || [ $char = "f" ] || [ $char = "s" ] || [ $char = "e" ] ||[ $char = "n" ]; then 
            for word in $words; do
                wordlen=${#word}
                that=${line:$i:wordlen}
                if [ $wordlen -eq ${#that} ]; then
                    # echo "$that"
                    if [ "$word" = "${line:$i:wordlen}" ]; then
                        last=$(get_number $word)
                        # echo "match: $last"
                        break 2
                    fi 
                fi 
            done
        fi
    done
    this="${first}${last}"
    echo "next => $numbers + $this"
    numbers=$((numbers+this))
done < $data

echo "Total: $numbers"