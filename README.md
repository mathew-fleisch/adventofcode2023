# adventofcode2023

## Day 01

https://adventofcode.com/2023/day/1

Parse a text file line by line grabbing the first and last number from each and adding them all together.

```bash
cd day01

# Part 1

# Example
./day01_part1.sh

# Real data
./day01_part1.sh ./example_part1.txt


# Part 2

# Example
./day01_part2.sh

# Real data
./day01_part2.sh ./example_part2.txt
```

## Day 02

https://adventofcode.com/2023/day/2

Grouped maximization of 3 colors. In part one, each "game" (line) could have no more than 12 red, 13 green and 14 blue cubes. The game ids of those games that met that criteria were summed together to get the answer. In part two, each game of the same data was used to calculate the highest roll for each color of cubes.  

```bash
cd day02

# Part 1

# Example
./day01_part1.sh

# Real data
./day01_part1.sh ./data.txt


# Part 2

# Example
./day01_part2.sh

# Real data
./day01_part2.sh ./data.txt
```

### Template

```bash
#!/bin/bash

data=${1:-./example_part1.txt}

while IFS= read -r line; do
    echo "$line"
done < $data
```