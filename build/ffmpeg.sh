#!/bin/bash

set -euo pipefail

CONF_FLAGS=(
  --target-os=none              # disable target specific configs
  --arch=x86_32                 # use x86_32 arch
  --enable-cross-compile        # use cross compile configs
  --disable-asm                 # disable asm
  --disable-stripping           # disable stripping as it won't work
  --disable-programs            # disable ffmpeg, ffprobe and ffplay build
  --disable-doc                 # disable doc build
  --disable-debug               # disable debug mode
  --disable-runtime-cpudetect   # disable cpu detection
  --disable-autodetect          # disable env auto detect

  --disable-avdevice
  --disable-swscale
  --disable-postproc
  --enable-avfilter
  --disable-symver
  --disable-safe-bitstream-reader
  # 进一步禁用不需要的特性
  --disable-bzlib
  --disable-lzma
  --disable-iconv
  --disable-audiotoolbox
  --disable-coreimage
  --disable-videotoolbox
  --disable-avfoundation
  --disable-sdl2
  --disable-xlib
  --disable-zlib
  --disable-libxcb
  --disable-cuda
  --disable-cuvid
  --disable-nvenc
  --disable-vaapi
  --disable-vdpau
  --disable-optimizations
  --disable-small
  --enable-static
  --disable-shared
  --disable-hwaccels
  --disable-hwaccel=all
  --disable-hwdevice=all
  --disable-encoder=h264
  --disable-encoder=libx264
  --disable-decoder=h264
  --disable-muxer=mp4
  --disable-demuxer=mp4
  # 禁用更多视频编码器
  --disable-encoder=hevc
  --disable-encoder=libx265
  --disable-decoder=hevc
  --disable-encoder=vp8
  --disable-encoder=vp9
  --disable-decoder=vp8
  --disable-decoder=vp9
  --disable-encoder=mjpeg
  --disable-decoder=mjpeg
  --disable-muxer=matroska
  --disable-demuxer=matroska
  --disable-muxer=flv
  --disable-demuxer=flv
  --disable-gpl
  # 禁用所有视频相关编码器
  --disable-encoder=mpeg4
  --disable-encoder=mpeg2video
  --disable-encoder=libxvid
  --disable-encoder=libvpx-vp9
  --disable-encoder=libvpx
  # 禁用所有视频解码器
  --disable-decoder=mpeg4
  --disable-decoder=mpeg2video
  --disable-decoder=libvpx-vp9
  --disable-decoder=libvpx
  # 禁用视频格式
  --disable-muxer=avi
  --disable-muxer=mov
  --disable-muxer=mkv
  --disable-demuxer=avi
  --disable-demuxer=mov
  --disable-demuxer=mkv
  # 禁用不需要的协议
  # 保留必要的文件协议，禁用网络协议
  --disable-protocol=http
  --disable-protocol=https
  --disable-protocol=rtmp
  --disable-protocol=rtsp
  --disable-protocol=tcp
  --disable-protocol=udp
  --disable-protocol=crypto
  --disable-protocol=hls
  --disable-protocol=concat
  --disable-protocol=subfile
  # 禁用图像相关格式
  --disable-muxer=image2
  --disable-muxer=image2pipe
  --disable-demuxer=image2
  --disable-demuxer=image2pipe
  --disable-demuxer=gif
  --disable-demuxer=png
  --disable-demuxer=mjpeg
  --disable-muxer=gif
  --disable-muxer=png
  --disable-muxer=mjpeg
  # 明确启用需要的音频格式
  --enable-demuxer=wav
  --enable-muxer=wav
  --enable-demuxer=mp3
  --enable-muxer=mp3
  --enable-demuxer=aac
  --enable-muxer=aac
  --enable-demuxer=ogg
  --enable-muxer=ogg
  --enable-demuxer=flac
  --enable-muxer=flac

  # assign toolchains and extra flags
  --nm=emnm
  --ar=emar
  --ranlib=emranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
  --extra-cflags="$CFLAGS"
  --extra-cxxflags="$CXXFLAGS"

  # disable thread when FFMPEG_ST is NOT defined
  ${FFMPEG_ST:+ --disable-pthreads --disable-w32threads --disable-os2threads}
)

emconfigure ./configure "${CONF_FLAGS[@]}" $@
emmake make -j
