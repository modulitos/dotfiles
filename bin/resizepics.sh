#! /bin/bash
# Iterates over all files and resizes them according to the -w flag
# ie `resizepics -w 10 *.png` or
# `resizepics -w 10 *.png a.png my-file.jpg`

convertFiles ()
{ # Convert our files by reading in width and file names as arguments
  width=$1
  # remove the flag and argument from the variable
  shift
  for f in $@
  do
    echo "Resizing $f to a scaled width of $width pixels."
    convert $f -resize $width $f
  done
}

# alternative implementation
optionPassed=0
while getopts ':w:' flag; do
  case "$flag" in
    w)
      optionPassed=1
      shift 2 # remove the flag and optarg from our argument
      convertFiles $OPTARG $@
      ;;
    :)
      echo "invalid argument passed"
      ;;
  esac
done

if [ $optionPassed -eq 0 ]
then
echo "Please pass a '-w' flag to specify width of the conversion"
echo "ie: 'resizepics -w 500 *.png'"
echo "ie: 'resizepics -w 60% *.png'"
exit 2
fi

# # Old implementation:
# # resizepics.sh "0616152002.jpg 0616152002a.jpg" 500
# for f in $1
# do
#   echo "Resizing $f to a scaled width of $2 pixels."
#   convert $f -resize $2 $f
# done
