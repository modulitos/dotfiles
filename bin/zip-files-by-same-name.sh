#!/usr/bin/env bash

# resources for extracting extension and filename: http://www.linuxjournal.com/content/bash-parameter-expansion

# usage:
# ./zip-files-by-same-name.sh "directory-full-of-shapefiles/.shp"
# (use quotes to prevent pathname expansion)

for f in $1
do
    filename=$(basename "$f")
    # echo "f: " $f
    path=${f%/*}
    # echo "path: " ${f%/*}
    extension="${filename##*.}"
    filename="${filename%.*}"
    # echo "filename: $filename"
    # echo "filenames:" `ls $path/$filename.*`
    zip $path/$filename.zip `ls $path/$filename.*`
done
