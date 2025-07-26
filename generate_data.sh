#!/bin/bash

output="data.asm"
frames_per_section=15
frame_index=0
section_index=1

echo '.include "hdr.asm"' > "$output"
echo '' >> "$output"

echo ".section \".rosprite${section_index}\" superfree" >> "$output"
echo '' >> "$output"

for picfile in gfx/*.pic; do
  [ -e "$picfile" ] || continue

  filename=$(basename "$picfile" .pic)
  palfile="gfx/${filename}.pal"

  echo "gfx${filename}:" >> "$output"
  echo ".incbin \"$picfile\"" >> "$output"
  echo "gfx${filename}_end:" >> "$output"
  echo "" >> "$output"

  if [ -f "$palfile" ]; then
    echo "pal${filename}:" >> "$output"
    echo ".incbin \"$palfile\"" >> "$output"
    echo "pal${filename}_end:" >> "$output"
    echo "" >> "$output"
  fi

  ((frame_index++))

  if (( frame_index % frames_per_section == 0 )); then
    echo ".ends" >> "$output"
    echo "" >> "$output"
    ((section_index++))
    echo ".section \".rosprite${section_index}\" superfree" >> "$output"
    echo "" >> "$output"
  fi
done

echo ".ends" >> "$output"
