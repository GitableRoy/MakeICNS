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


for arg in "$@"
  do
    echo "Creating icon for $arg"

    if [[ -f $arg ]]; then
      # if file placed in script is not a PNG or JPG then exit
      if ! [[ "$arg" == *"png"* || "$arg" == *"jpg"* || "$arg" == *"jpeg"* \
            || "$arg" == *"tif"* || "$arg" == *"svg"* ]]; then
        echo "The file "$arg" is a "$(echo $arg|cut -d "." -f2)" file. \
              Please enter a .png, .jpg, .tif, or .svg file"
        continue
      fi

      filename=$(echo $arg | cut -d "." -f1)

      # resize file to same dimensions
      size=$(echo magick identify -format "%wx%h\n" $arg)
      width=$($size | cut -d "x" -f1 | bc)
      height=$($size | cut -d "x" -f2 | bc)

      # create a resized png if dimenions were not the same
      if ! [[ $width == $height ]]; then
        if [[ $width > $height ]]; then
          lgrVal=$width
        else
          lgrVal=$height
        fi
        magick convert $arg -resize $lgrVal"x"$lgrVal\! -quality 100 $filename"_resize.png"
        ofilename=$filename
        filename=$(echo $filename"_resize")
      fi


      # create necessary icns files in /tmp
      mkdir /tmp/iconbuilder.iconset

      magick convert $arg -resize 512x512! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_512x512.png"
      magick convert $arg -resize 256x256! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_256x256.png"
      magick convert $arg -resize 128x128! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_128x128.png"
      magick convert $arg -resize 64x64! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_64x64.png"
      magick convert $arg -resize 32x32! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_32x32.png"
      magick convert $arg -resize 16x16! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_16x16.png"

      magick convert $arg -resize 512x512! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_512x512@2x.png"
      magick convert $arg -resize 256x256! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_256x256@2x.png"
      magick convert $arg -resize 128x128! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_128x128@2x.png"
      magick convert $arg -resize 64x64! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_64x64@2x.png"
      magick convert $arg -resize 32x32! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_32x32@2x.png"
      magick convert $arg -resize 16x16! -fuzz 01% -transparent white \
          -quality 100 /tmp/iconbuilder.iconset/"icon_16x16@2x.png"

      iconutil --convert icns --output $filename".icns" /tmp/iconbuilder.iconset


      # clean up by removing iconbuilder.folder
      rm -rf /tmp/iconbuilder.iconset

      # remove extra file if resize was necessary and change .icns to original filename
      if [[ $filename == *"resize"* ]]; then
        mv $filename".icns" $ofilename".icns"
        rm $(echo $filename".png")
      fi
    elif [[ -d $arg ]]; then
      for sub in $arg/*; do
        if [[ -f $sub ]]; then
          # if file placed in script is not a PNG or JPG then exit
          if ! [[ "$sub" == *"png"* || "$sub" == *"jpg"* || "$sub" == *"jpeg"* \
          || "$sub" == *"tif"* || "$sub" == *"svg"* ]]; then
            echo "The file "$sub" is a "$(echo $sub|cut -d "." -f2)" file. \
                  Please enter a .png, .jpg, .tif, or .svg file"
            continue
          fi

          filename=$(echo $sub | cut -d "." -f1)

          # resize file to same dimensions
          size=$(echo magick identify -format "%wx%h\n" $sub)
          width=$($size | cut -d "x" -f1 | bc)
          height=$($size | cut -d "x" -f2 | bc)

          # create a resized png if dimenions were not the same
          if ! [[ $width == $height ]]; then
            if [[ $width > $height ]]; then
              lgrVal=$width
            else
              lgrVal=$height
            fi
            magick convert $sub -resize $lgrVal"x"$lgrVal\! -quality 100 $filename"_resize.png"
            ofilename=$filename
            filename=$(echo $filename"_resize")
          fi


          # create necessary icns files in /tmp
          mkdir /tmp/iconbuilder.iconset

          magick convert $sub -resize 512x512! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_512x512.png"
          magick convert $sub -resize 256x256! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_256x256.png"
          magick convert $sub -resize 128x128! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_128x128.png"
          magick convert $sub -resize 64x64! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_64x64.png"
          magick convert $sub -resize 32x32! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_32x32.png"
          magick convert $sub -resize 16x16! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_16x16.png"

          magick convert $sub -resize 512x512! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_512x512@2x.png"
          magick convert $sub -resize 256x256! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_256x256@2x.png"
          magick convert $sub -resize 128x128! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_128x128@2x.png"
          magick convert $sub -resize 64x64! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_64x64@2x.png"
          magick convert $sub -resize 32x32! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_32x32@2x.png"
          magick convert $sub -resize 16x16! -fuzz 01% -transparent white \
              -quality 100 /tmp/iconbuilder.iconset/"icon_16x16@2x.png"

          iconutil --convert icns --output $filename".icns" /tmp/iconbuilder.iconset


          # clean up by removing iconbuilder.folder
          rm -rf /tmp/iconbuilder.iconset

          # remove extra file if resize was necessary and change .icns to original filename
          if [[ $filename == *"resize"* ]]; then
            mv $filename".icns" $ofilename".icns"
            rm $(echo $filename".png")
          fi
        fi
      done
    fi

  done
exit 0
