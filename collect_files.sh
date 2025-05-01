#!/bin/bash

INPUT_DIR="$1"
OUTPUT_DIR="$2"

mkdir -p "$OUTPUT_DIR"
declare -A seen

find "$INPUT_DIR" -type f | while read -r file; do
    base=$(basename "$file")
    name="${base%.*}"
    ext="${base##*.}"
    [[ "$name" == "$ext" ]] && ext="" || ext=".$ext"

    newname="$base"
    count=1
    while [[ -e "$OUTPUT_DIR/$newname" ]]; do
        newname="${name}${count}${ext}"
        ((count++))
    done

    cp "$file" "$OUTPUT_DIR/$newname"
done
