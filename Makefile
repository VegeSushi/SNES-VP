ifeq ($(strip $(PVSNESLIB_HOME)),)
$(error "Please create an environment variable PVSNESLIB_HOME by following this guide: https://github.com/alekmaul/pvsneslib/wiki/Installation")
endif

include ${PVSNESLIB_HOME}/devkitsnes/snes_rules

.PHONY: all clean bitmaps rom

export ROMNAME := video

PNG_FILES := $(wildcard gfx/*.png)

PIC_FILES := $(patsubst gfx/%.png,%.pic,$(PNG_FILES))

all: bitmaps rom

clean: cleanBuildRes cleanRom cleanGfx
	@rm -f $(PIC_FILES)

%.pic: gfx/%.png
	@echo convert bitmap ... $<
	$(GFXCONV) -s 32 -o 16 -u 16 -t png -i $<

bitmaps: $(PIC_FILES)

rom: $(ROMNAME).sfc
