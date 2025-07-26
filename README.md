# SNES-VP

A demo project for converting any video format to the .sfc SNES cartridge format.

## Requirements

- **convert (ImageMagick)**
- **ffmpeg**
- **PVSnesLib** ( [It's repo](https://github.com/alekmaul/pvsneslib) )
- **make**

## Usage

```bash
./build video.mp4 frames
```

- `frame` - the amount of frames to compile.
- `video.mp4` - the video file, can be any format supported by FFmpeg.