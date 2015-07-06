#! /bin/bash
# Iterates over all files and resizes them

# ex:
# resizepics.sh "0616152002.jpg 0616152002a.jpg" 500
for f in $1
do
  echo "Resizing $f to a scaled width of $2 pixels."
  convert $f -resize $2 $f
done

