#!/bin/bash

if [[ "$#" -lt 2 ]]; then
    echo "Usage: $0 /path/to/input_dir /path/to/output_dir [--max_depth N]"
    exit 1
fi

input_dir="$1"
output_dir="$2"
max_depth=""

if [[ "$3" == "--max_depth" && -n "$4" ]]; then
    max_depth="$4"
fi

mkdir -p "$output_dir"

if [[ -n "$max_depth" ]]; then
    find "$input_dir" -type f -mindepth 1 -maxdepth "$((max_depth + 1))" | while read -r file; do
        rel_path="${file#$input_dir/}"
        out_file="$output_dir/$rel_path"
        mkdir -p "$(dirname "$out_file")"
        cp "$file" "$out_file"
    done
else
    find "$input_dir" -type f | while read -r file; do
        rel_path="${file#$input_dir/}"
        out_file="$output_dir/$rel_path"
        mkdir -p "$(dirname "$out_file")"
        cp "$file" "$out_file"
    done
fi
