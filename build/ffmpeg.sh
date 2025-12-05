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

  --disable-avdevice \
  --disable-swscale \
  --disable-postproc \
  --enable-avfilter \
  # 进一步禁用不需要的特性
  --disable-bzlib \
  --disable-lzma \
  --disable-iconv \
  --disable-audiotoolbox \
  --disable-coreimage \
  --disable-videotoolbox \
  --disable-avfoundation \
  --disable-sdl2 \
  --disable-xlib \
  --disable-zlib \
  --disable-libxcb \
  --disable-cuda \
  --disable-cuvid \
  --disable-nvenc \
  --disable-vaapi \
  --disable-vdpau \
  --disable-zimg \
  # 禁用非音频相关库
  --disable-libass \
  --disable-harfbuzz \
  --disable-fribidi \
  --disable-freetype \
  --disable-libwebp \
  --disable-libvpx \
  --disable-libx265 \
  --disable-libx264 \
  --disable-optimizations \
  --disable-small \
  --enable-static \
  --disable-shared \
  --disable-encoder=h264 \
  --disable-encoder=libx264 \
  --disable-decoder=h264 \
  --disable-muxer=mp4 \
  --disable-demuxer=mp4 \
  --disable-gpl \
  --disable-network \
  # 禁用所有视频相关编码器
  --disable-encoder=mpeg4 \
  --disable-encoder=mpeg2video \
  --disable-encoder=libxvid \
  --disable-encoder=libvpx-vp9 \
  --disable-encoder=libvpx \
  # 禁用所有视频解码器
  --disable-decoder=mpeg4 \
  --disable-decoder=mpeg2video \
  --disable-decoder=libvpx-vp9 \
  --disable-decoder=libvpx \
  # 禁用 WebP 编码器和解码器
  --disable-encoder=libwebp \
  --disable-encoder=libwebp_anim \
  --disable-decoder=webp \
  --disable-decoder=libwebp_anim \
  # 禁用视频格式
  --disable-muxer=avi \
  --disable-muxer=mov \
  --disable-muxer=mkv \
  --disable-muxer=webp \
  --disable-muxer=webp_pipe \
  --disable-demuxer=avi \
  --disable-demuxer=mov \
  --disable-demuxer=mkv \
  --disable-demuxer=webp \
  --disable-demuxer=webp_pipe \
  # 禁用不需要的协议
  --disable-protocol=http \
  --disable-protocol=https \
  --disable-protocol=rtmp \
  --disable-protocol=rtsp \

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
