#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 /path/to/input_dir /path/to/output_dir"
    exit 1
fi

input_dir="$1"
output_dir="$2"

mkdir -p "$output_dir"

find "$input_dir" -type f | while read -r file; do
    base="$(basename "$file")"
    dest="$output_dir/$base"
    count=1
    while [ -e "$dest" ]; do
        dest="$output_dir/${base%.*}_$count.${base##*.}"
        ((count++))
    done
    cp "$file" "$dest"
done