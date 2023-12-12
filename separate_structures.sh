#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: misomers.sh crest_ensemble.xyz"
    exit 1
fi

filename="$1"

# Read the first line of the file and save the integer to "atomnumb"
atomnumb=$(head -n 1 "$filename" | awk '{print $1}')

# Calculate the total number of lines in the file
total_lines=$(wc -l < "$filename")

# Calculate strnumb as the total number of lines divided by atomnumb
strnumb=$((total_lines / (atomnumb + 2)))

# Create a new folder to contain the xyz files
mkdir "isomers"

# Loop to create isomer files
for ((i=1; i<=strnumb; i++)); do
    # Calculate starting and ending lines for each isomer
    start_line=$(((3 * i) + (i - 1) * (atomnumb-1)))
    end_line=$((start_line + atomnumb - 1))

    # Create isomer file
    isomer_filename="isomers/isomer${i}.xyz"
    sed -n "${start_line},${end_line}p" "$filename" > "$isomer_filename"

    echo "Created $isomer_filename"
done
