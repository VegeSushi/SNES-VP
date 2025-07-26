#!/bin/bash

for img in gfx/*.png; do
  echo "Converting $img..."
  convert "$img" -resize 32x32\! -colors 16 -depth 4 -type Palette PNG8:"$img"
done