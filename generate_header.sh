#!/bin/bash

header="frames.h"

echo "Generating $header..."

# Start header
cat > "$header" <<EOF
#ifndef FRAMES_H
#define FRAMES_H

#include <snes.h>

// Traditional extern declarations
EOF

entries=()

for pic in gfx/*.pic; do
    [ -e "$pic" ] || continue
    name=$(basename "$pic" .pic)
    pal="gfx/${name}.pal"

    echo "extern char gfx${name}, gfx${name}_end;" >> "$header"

    if [ -f "$pal" ]; then
        echo "extern char pal${name}, pal${name}_end;" >> "$header"
        entries+=("{ &gfx${name}, &gfx${name}_end, &pal${name}, &pal${name}_end }")
    else
        entries+=("{ &gfx${name}, &gfx${name}_end, NULL, NULL }")
    fi

    echo "" >> "$header"
done

# Add struct and array
cat >> "$header" <<EOF
typedef struct {
    const char* gfx;
    const char* gfx_end;
    const char* pal;
    const char* pal_end;
} SpriteData;

static const SpriteData sprites[] = {
EOF

for entry in "${entries[@]}"; do
    echo "    $entry," >> "$header"
done

cat >> "$header" <<EOF
};

static const int sprite_count = sizeof(sprites) / sizeof(SpriteData);
EOF

# Calculate FRAME_COUNT = round up sprite_count to nearest multiple of 4
total=${#entries[@]}
rounded=$(( (total + 3) / 4 * 4 ))

echo "#define FRAME_COUNT $rounded" >> "$header"
echo "" >> "$header"
echo "#endif // FRAMES_H" >> "$header"

echo "Header generated successfully: $header"
