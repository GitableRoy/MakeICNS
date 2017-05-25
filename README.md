# MakeICNS
This is a quick script that makes a macOS ICNS file out of your PNGs, JPGs, TIFs and SVGs

![alt text](https://github.com/GitableRoy/MakeICNS/raw/dev/example.gif)

## Prerequisites

[ImageMagick](https://www.imagemagick.org/script/download.php) is required to run this script

## Getting Started

To use:

1. Open your Terminal
2. Clone the directory to your desired location
3. Move to repository's directory `cd path/to/MakeICNS`
4. Use command `./makeicns.sh path/to/file`
 + Example 1: Only One File : `./makeicns.sh ~/Pictures/logo.svg`
 + Example 2: Multiple Files: `./makeicns.sh ~/Pictures/hello.png ~/Pictures/world.jpg`
 + Example 3: Directory     : `./makeicns.sh ~/Pictures/`
 5. You will find the icns file where your image file is

## Tips for a simpler workflow

MakeICNS does a few things:
MakeICNS accepts multiple arguments for files and folders. Linking may help lower excessive typing. Link by:
 + `ln -s path/to/MakeICNS/makeicns.sh /usr/local/bin/`
 + Then you can go to your picture's directory and simply type: `makeicns.sh picture.png`
 + Alternatively you can open your Terminal, type `makeicns.sh` and drag files/folders into Terminal
