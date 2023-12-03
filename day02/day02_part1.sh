#!/bin/bash

data=${1:-./example_data.txt}

max_red=12
max_green=13
max_blue=14

possible=""

while IFS= read -r line; do
    echo "$line"
    game_id=$(echo "$line" | sed -e 's/Game\ \(.*\):.*/\1/g')
    echo "GameID: $game_id"
    ind=0
    thispossible=1
    for turn in $(echo "$line" | sed -e 's/.*://g' | sed -e 's/\ //g' | tr ';' ' '); do
        # echo "$game_id[$ind]: $turn";
        cind=0
        for color in $(echo "$turn" | tr ',' ' '); do
            echo "$game_id[$ind][$cind]: $color";
            num=0
            if [[ $color =~ "red" ]]; then
                num=$(echo "$color" | sed -e 's/red//g');
                if [ $num -gt $max_red ]; then
                    thispossible=0
                fi
            fi
            if [[ $color =~ "blue" ]]; then
                num=$(echo "$color" | sed -e 's/blue//g');
                if [ $num -gt $max_blue ]; then
                    thispossible=0
                fi
            fi
            if [[ $color =~ "green" ]]; then
                num=$(echo "$color" | sed -e 's/green//g');
                if [ $num -gt $max_green ]; then
                    thispossible=0
                fi
            fi
            cind=$((cind+1))
        done
        ind=$((ind+1))
    done
    echo "This possible: $thispossible"
    if [ $thispossible -eq 1 ]; then
        possible="$possible $game_id"
    fi
    echo "-----------------------------------------"
done < $data

echo "Sum possible: $possible"
echo "$possible" | tr ' ' '\n' | awk '{s+=$1} END {print s}' 