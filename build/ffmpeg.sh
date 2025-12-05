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

  # 使用 --disable-everything 禁用所有组件
  --disable-everything
  
  # 启用核心库
  --enable-ffmpeg
  --enable-avcodec
  --enable-avformat
  --enable-avutil
  --enable-swresample
  --enable-avfilter
  # 添加这行来解决链接问题
  --enable-avdevice
  
  # 启用静态链接
  --enable-static
  --disable-shared
  
  # 启用音频编解码器
  --enable-decoder=mp3,float,s16,s32,wavpack,alac,flac,vorbis,opus,pcm_*,aac,aac_latm
  --enable-encoder=mp3,pcm_s16le,pcm_f32le,aac
  --enable-parser=aac,mp3,flac,vorbis
  
  # 启用音频容器格式
  --enable-demuxer=mp3,wav,flac,ogg,opus,aac
  --enable-muxer=mp3,wav,flac,ogg,opus,aac
  
  # 启用音频处理滤镜
  --enable-filter=aresample,aformat,volume,pan,atempo,equalizer,acompressor,astats,silencedetect,silenceremove
  --enable-filter=concat,asetpts,amix,amerge
  
  # 启用必要协议
  --enable-protocol=file
  
  # 禁用不需要的功能
  --disable-network
  --disable-bzlib
  --disable-lzma
  --disable-iconv
  --disable-swscale
  --disable-postproc
  --disable-symver
  --disable-safe-bitstream-reader
  --disable-optimizations
  --disable-small
  
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