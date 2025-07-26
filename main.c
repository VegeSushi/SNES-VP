#include <snes.h>
#include <stdint.h>
#include "frames.h"

int main(void)
{
	setMode(BG_MODE1, 0);
    bgSetDisable(0);
    bgSetDisable(1);
    bgSetDisable(2);
    setScreenOn();

    int i = 0;
    int y;
    int frames = FRAME_COUNT;

    for (;;)
	{
		oamSetEx(0, OBJ_LARGE, OBJ_SHOW);
		for (i = 0; i < frames; i++) {
			oamInitGfxSet(
				sprites[i].gfx,
				sprites[i].gfx_end - sprites[i].gfx,
				sprites[i].pal,
				sprites[i].pal_end - sprites[i].pal,
				0, 0x0000, OBJ_SIZE32_L64
			);

			oamSet(0, 50, 50, 3, 0, 0, 0, 0);
			for (y = 0; y < 4; y++) {
    			WaitForVBlank();
			}
		}
		oamSetEx(0, OBJ_LARGE, OBJ_HIDE);
		for (y = 0; y < 15; y++) {
    		WaitForVBlank();
		}
	}


    return 0;
}
