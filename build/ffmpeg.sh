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
  --enable-small
  --enable-static
  --disable-shared
  --disable-network
  
  # 禁用所有不必要的组件
  --disable-everything
  
  # 启用音频处理必需的功能（添加AMR支持）
  --enable-decoder=mp3,mp2,m4a,aac,wma*,flac,vorbis,opus,wavpack,pcm_*,alac,amr*,amrnb,amrwb
  --enable-encoder=mp3,mp2,m4a,aac,flac,vorbis,opus,pcm_*,amrnb,amrwb
  --enable-parser=mpegaudio,aac,latm,vorbis,opus,amr
  --enable-demuxer=mp3,mp2,m4a,aac,wma*,flac,ogg,wav,au,oma,ast,afc,ape,dsf,dsd*,3gpp,amr
  --enable-muxer=mp3,mp2,m4a,aac,flac,ogg,wav,oma,ast,3gp,amr
  --enable-filter=aresample,aformat,volume,pan,amerge,amix,silenceremove,atrim,concat,asetnsamples,aconvert,channelsplit,channelmap
  
  # 启用基础工具
  --enable-protocol=file

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