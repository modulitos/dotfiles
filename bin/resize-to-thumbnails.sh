#!/bin/bash

#!/bin/bash
FILES="$@"
for i in $FILES
do
echo "Processing image $i ..."
filename=$(basename "$i")
extension="${filename##*.}"
filename="${filename%.*}"
convert -thumbnail 200 $i ${filename}-thumb.${extension}
done

