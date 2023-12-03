#!/bin/bash

data=${1:-./example_data.txt}

max_red=0
max_green=0
max_blue=0

possible=""

while IFS= read -r line; do
    echo "$line"
    game_id=$(echo "$line" | sed -e 's/Game\ \(.*\):.*/\1/g')
    echo "GameID: $game_id"
    ind=0
    thispossible=1
    max_red=0
    max_green=0
    max_blue=0
    for turn in $(echo "$line" | sed -e 's/.*://g' | sed -e 's/\ //g' | tr ';' ' '); do
        # echo "$game_id[$ind]: $turn";
        cind=0
        for color in $(echo "$turn" | tr ',' ' '); do
            echo "$game_id[$ind][$cind]: $color";
            num=0
            if [[ $color =~ "red" ]]; then
                num=$(echo "$color" | sed -e 's/red//g');
                if [ $num -gt $max_red ]; then
                    max_red=$num
                fi
            fi
            if [[ $color =~ "blue" ]]; then
                num=$(echo "$color" | sed -e 's/blue//g');
                if [ $num -gt $max_blue ]; then
                    max_blue=$num
                fi
            fi
            if [[ $color =~ "green" ]]; then
                num=$(echo "$color" | sed -e 's/green//g');
                if [ $num -gt $max_green ]; then
                    max_green=$num
                fi
            fi
            cind=$((cind+1))
        done
        ind=$((ind+1))
    done
    echo "Lowest possible: $max_red red, $max_blue blue, $max_green green"
    this_game=$((max_red * max_blue * max_green))
    echo "This game: $this_game"
    possible="$possible $this_game"
    echo "-----------------------------------------"
done < $data

echo "Sum possible: $possible"
echo "$possible" | tr ' ' '\n' | awk '{s+=$1} END {print s}' 