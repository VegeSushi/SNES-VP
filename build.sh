#!/bin/bash

if ! command -v convert &> /dev/null; then
    echo "Error: Please install ImageMagick."
    exit 1
fi

if ! command -v ffmpeg &> /dev/null; then
    echo "Error: Please install FFmpeg."
    exit 1
fi

if [ -z "$PVSNESLIB_HOME" ]; then
    echo "Error: PVSnesLib is not detected."
    exit 1
fi

if [ -z "$1" ]; then
    echo "Usage: $0 <video_file> <max_frames>"
    exit 1
fi


if [ -z "$2" ]; then
    echo "Usage: $0 <video_file> <max_frames>"
    exit 1
fi

VIDEO_FILE="$1"
MAX_FRAMES="$2"

GFX_DIR="gfx"

echo Setting up directories...
mkdir -p "$GFX_DIR"

echo Cleaning...
rm -f "$GFX_DIR"/*.png
rm -f "$GFX_DIR"/*.pic
rm -f "$GFX_DIR"/*.pal
rm -fv linkfile
make clean

echo Exporting frames...
ffmpeg -i "$1" -frames:v $2 "$GFX_DIR"/frame%03d.png

echo Running ImageMagick...
./magick_all.sh

echo Converting frames...
#./convert_pngs.sh
make bitmaps

echo Generating data.asm file...
./generate_data.sh

echo Generating header...
./generate_header.sh

echo Building rom...
make rom