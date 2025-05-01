#!/bin/bash

#воспользовалась идеей с сайта https://stackoverflow.com/questions/20799905/flatten-directory-structure-and-preserve-duplicate-files
INPUT_DIR="$1"
OUTPUT_DIR="$2"

mkdir -p "$OUTPUT_DIR"

find "$INPUT_DIR" -type f | while read -r file; do
    base=$(basename "$file")
    name="${base%.*}"
    ext="${base##*.}"
    [[ "$name" == "$ext" ]] && ext="" || ext=".$ext"

    target="$OUTPUT_DIR/$base"
    count=1

    while [[ -e "$target" ]]; do
        target="$OUTPUT_DIR/${name}_${count}${ext}"
        ((count++))
    done

    cp "$file" "$target"
done
