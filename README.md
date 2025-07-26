# SNES-VP

A demo project for converting any video format to the .sfc SNES cartridge format.

## Requirements

- **convert (ImageMagick)**
- **ffmpeg**
- **PVSnesLib** ( [It's repo](https://github.com/alekmaul/pvsneslib) )
- **make**

## Usage

```bash
./build.sh video.mp4 frames
```

- `frames` - the amount of frames to compile.
- `video.mp4` - the video file, can be any format supported by FFmpeg.

## Note

- Currently the bash scripts work only on Linux, no Windows version is planned, but WSL should work fine.

- The video frames are scaled to 32x32