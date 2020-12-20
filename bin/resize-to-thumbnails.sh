#!/bin/bash

FILES=("$@")
for i in "${FILES[@]}"
do
  echo "Processing image $i ..."
  filename=$(basename "$i")
  extension="${filename##*.}"
  filename="${filename%.*}"
  thumb_filename="${filename}-thumb.${extension}"
  convert -thumbnail 200 "$i" "$thumb_filename"
  echo "new file created: $thumb_filename"
done

