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
  # 禁用额外的视频和图像处理功能
  --disable-pixelutils \
  --disable-vulkan \
  --disable-opencl \
  --disable-opengl \
  --disable-securetransport \
  --disable-xmm-clobber-test \
  --disable-audiotoolbox \
  --disable-outdev=alsa \
  --disable-indev=alsa \
  --disable-outdev=oss \
  --disable-indev=oss \
  --disable-outdev=sdl \
  --disable-indev=sdl \
  --disable-outdev=v4l2 \
  --disable-indev=v4l2 \
  --disable-outdev=fbdev \
  --disable-indev=fbdev \
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
  # 禁用非音频相关库
  --disable-libass \
  --disable-libharfbuzz \
  --disable-libfribidi \
  --disable-freetype \
  --disable-libwebp \
  --disable-libvpx \
  --disable-libx265 \
  --disable-libx264 \
  --disable-libopenh264 \
  --disable-libdav1d \
  --disable-libaom \
  --disable-libsvtav1 \
  --disable-librav1e \
  --disable-libtheora \
  --disable-libspeex \
  --disable-libtwolame \
  --disable-libgsm \
  --disable-libopencore-amrnb \
  --disable-libopencore-amrwb \
  --disable-libvo-amrwbenc \
  --disable-libschroedinger \
  --disable-libilbc \
  --disable-lzo \
  --disable-libopencv \
  --disable-libcdio \
  --disable-libdc1394 \
  --disable-libiec61883 \
  --disable-libjack \
  --disable-libpulse \
  --disable-libopenjpeg \
  --disable-libtesseract \
  --disable-libbs2b \
  --disable-libsoxr \
  --disable-librubberband \
  --disable-libvidstab \
  --disable-libzvbi \
  --disable-libcaca \
  --disable-libchromaprint \
  --disable-libgme \
  --disable-libmodplug \
  --disable-libv4l2 \
  --disable-libvmaf \
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
  --disable-encoder=rawvideo \
  --disable-encoder=h263 \
  --disable-encoder=h263p \
  --disable-encoder=mjpeg \
  --disable-encoder=ljpeg \
  --disable-encoder=jpegls \
  --disable-encoder=png \
  --disable-encoder=bmp \
  --disable-encoder=tiff \
  --disable-encoder=gif \
  --disable-encoder=sgi \
  # 禁用所有视频解码器
  --disable-decoder=mpeg4 \
  --disable-decoder=mpeg2video \
  --disable-decoder=libvpx-vp9 \
  --disable-decoder=libvpx \
  --disable-decoder=rawvideo \
  --disable-decoder=h263 \
  --disable-decoder=h263p \
  --disable-decoder=mjpeg \
  --disable-decoder=ljpeg \
  --disable-decoder=jpegls \
  --disable-decoder=png \
  --disable-decoder=bmp \
  --disable-decoder=tiff \
  --disable-decoder=gif \
  --disable-decoder=sgi \
  --disable-decoder=iff \
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
  --disable-muxer=flv \
  --disable-muxer=m4v \
  --disable-muxer=mpjpeg \
  --disable-muxer=gif \
  --disable-muxer=smjpeg \
  --disable-muxer=yuv4mpegpipe \
  --disable-demuxer=avi \
  --disable-demuxer=mov \
  --disable-demuxer=mkv \
  --disable-demuxer=webp \
  --disable-demuxer=webp_pipe \
  --disable-demuxer=flv \
  --disable-demuxer=m4v \
  --disable-demuxer=mpjpeg \
  --disable-demuxer=gif \
  --disable-demuxer=smjpeg \
  --disable-demuxer=yuv4mpegpipe \
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
