#!/bin/bash

set -euo pipefail

CONF_FLAGS=(
  --target-os=none
  --arch=x86_32
  --enable-cross-compile
  --disable-asm
  --disable-stripping
  --disable-programs
  --disable-doc
  --disable-debug
  --disable-runtime-cpudetect
  --disable-autodetect

  # 禁用所有视频相关组件
  --disable-avdevice
  --disable-swscale
  --disable-postproc
  --disable-swresample-arm
  --disable-swscale-alpha
  --disable-swscale-arm

  # 保留必要滤镜功能
  --enable-avfilter
  
  # 禁用不必要的库和功能
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
  --disable-network
  
  # 禁用所有视频编解码器
  --disable-everything
  
  # 启用音频处理必需的功能
  --enable-decoder=mp3,m4a,aac,flac,vorbis,opus,wavpack,pcm_*
  --enable-encoder=mp3,m4a,aac,flac,vorbis,opus,pcm_*
  --enable-parser=mpegaudio,aac,latm,vorbis,opus
  --enable-demuxer=mp3,m4a,aac,flac,ogg,wav,au
  --enable-muxer=mp3,m4a,aac,flac,ogg,wav
  --enable-filter=aresample,aformat,volume,pan,amerge,amix,silenceremove,atrim,concat
  
  # 启用基础工具
  --enable-protocol=file
  --enable-filter=aformat,aresample

  # 工具链配置
  --nm=emnm
  --ar=emar
  --ranlib=emranlib
  --cc=emcc
  --cxx=em++
  --objcc=emcc
  --dep-cc=emcc
  --extra-cflags="$CFLAGS"
  --extra-cxxflags="$CXXFLAGS"

  # 禁用线程以进一步减小体积
  --disable-pthreads
  --disable-w32threads
  --disable-os2threads
)

emconfigure ./configure "${CONF_FLAGS[@]}" $@