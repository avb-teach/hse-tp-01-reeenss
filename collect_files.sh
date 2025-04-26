#!/bin/bash

if [[ "$#" -lt 2 ]]; then
    echo "Usage: $0 /path/to/input_dir /path/to/output_dir [--max_depth N]"
    exit 1
fi

input_dir="$1"
output_dir="$2"
max_depth=""

i=3
while [[ $i -le $# ]]; do
  if [[ "$3" == "--max_depth" ]]; then
    max_depth="$4"
    i=$((i+2))
    shift 2
  else
    echo "Unknown parameter: $3"
    exit 1
  fi
done
shift 2

mkdir -p "$output_dir"

copy_files() {
  find "$1" -type f \( -path "$1" -o -prune \) -print0 | while IFS= read -r -d $'\0' file; do
    rel_path="${file#$1/}"
    out_file="$2/$rel_path"
    mkdir -p "$(dirname "$out_file")"
    cp "$file" "$out_file"
  done
}

if [[ -n "$max_depth" ]]; then
  find "$input_dir" -mindepth 1 -maxdepth "$((max_depth + 1))" -type d -print0 | while IFS= read -r -d $'\0' dir; do
    copy_files "$dir" "$output_dir"
  done
  copy_files "$input_dir" "$output_dir"
else
  copy_files "$input_dir" "$output_dir"
fi
