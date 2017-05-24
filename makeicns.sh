#!/bin/bash

# This script accepts a [ PNG | JPG | TIF | SVG ] file and returns an .icns

# if user doesn't have imagemagick, exit
checkMagick=$(which magick)
if  [ -z $checkMagick ]; then
  echo "You must have imagemagick installed to use this script!"
  exit 0
fi

# check for arguments
if [[ $# -eq 0 ]]; then
  echo "No argument entered. Please supply this script with a PNG!"
  exit 0
fi


for file in "$@"
  do
    echo "Creating icon for $file"
    # if file placed in script is not a PNG or JPG then exit
    if ! [[ "$file" == *"png"* || "$file" == *"jpg"* || \
            "$file" == *"tif"* || "$file" == *"svg"* ]]; then
      echo "The file "$file" is a "$(echo $file|cut -d "." -f2)" file. \
            Please enter a .png, .jpg, .tif, or .svg file"
      continue
    fi

    filename=$(echo $file | cut -d "." -f1)

    # resize file to same dimensions
    size=$(echo magick identify -format "%wx%h\n" $file)
    width=$($size | cut -d "x" -f1 | bc)
    height=$($size | cut -d "x" -f2 | bc)

    # create a resized png if dimenions were not the same
    if ! [[ $width == $height ]]; then
      if [[ $width > $height ]]; then
        lgrVal=$width
      else
        lgrVal=$height
      fi
      magick convert $file -resize $lgrVal"x"$lgrVal\! -quality 100 $filename"_resize.png"
      filename=$(echo $filename"_resize")
    fi


    # create necessary icns files in /tmp
    mkdir /tmp/iconbuilder.iconset

    magick convert $file -resize 512x512! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_512x512.png"
    magick convert $file -resize 256x256! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_256x256.png"
    magick convert $file -resize 128x128! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_128x128.png"
    magick convert $file -resize 64x64! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_64x64.png"
    magick convert $file -resize 32x32! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_32x32.png"
    magick convert $file -resize 16x16! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_16x16.png"

    magick convert $file -resize 512x512! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_512x512@2x.png"
    magick convert $file -resize 256x256! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_256x256@2x.png"
    magick convert $file -resize 128x128! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_128x128@2x.png"
    magick convert $file -resize 64x64! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_64x64@2x.png"
    magick convert $file -resize 32x32! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_32x32@2x.png"
    magick convert $file -resize 16x16! -fuzz 01% -transparent white /tmp/iconbuilder.iconset/"icon_16x16@2x.png"

    iconutil --convert icns --output $filename".icns" /tmp/iconbuilder.iconset


    # clean up by removing iconbuilder.folder
    rm -rf /tmp/iconbuilder.iconset

    # remove extra file if resize was necessary
    if [[ $filename == *"resize"* ]]; then
      rm $(echo $filename".png")
    fi

  done
exit 0
