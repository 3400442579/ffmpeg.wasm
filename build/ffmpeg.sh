#!/bin/bash

set -euo pipefail

# 使用 --disable-everything 禁用所有组件，然后只启用需要的组件
CONF_FLAGS=(
  # 基本配置
  --target-os=none             # disable target specific configs
  --arch=x86_32                # use x86_32 arch for WebAssembly
  --enable-cross-compile       # use cross compile configs
  --disable-asm                # disable asm
  --disable-stripping          # disable stripping as it won't work
  --disable-ffplay             # disable ffplay build
  --disable-ffmpeg             # disable ffmpeg build
  #--disable-ffprobe            # disable ffprobe build
  --disable-doc                # disable doc build
  --disable-debug              # disable debug mode
  --disable-runtime-cpudetect  # disable cpu detection
  --disable-autodetect         # disable env auto detect
  
  # 禁用所有组件
  --disable-everything
  --enable-ffprobe 
  
  # 启用必要的组件
  --enable-avcodec             # 编解码器
  --enable-avformat            # 格式处理
  --enable-avfilter            # 滤镜（音频滤镜）
  --enable-swresample          # 音频重采样
  --enable-avutil              # 工具库
  
  # 禁用不需要的库
  --disable-avdevice           # 设备支持
  --disable-swscale            # 视频缩放（不需要）
  --disable-postproc           # 后处理（不需要）
  
  # 禁用硬件加速
  --disable-amf
  --disable-audiotoolbox
  --disable-cuda-llvm
  --disable-cuvid
  --disable-d3d11va
  --disable-dxva2
  --disable-ffnvcodec
  --disable-libdrm
  --disable-nvdec
  --disable-nvenc
  --disable-vaapi
  --disable-vdpau
  --disable-videotoolbox
  --disable-vulkan
  
  # 禁用网络功能
  --disable-network
  
  # 启用音频编解码器
  --enable-decoder=mp3
  --enable-decoder=aac
  --enable-decoder=flac
  --enable-decoder=vorbis
  --enable-decoder=opus
  --enable-decoder=pcm_s16le
  --enable-decoder=pcm_s16be
  --enable-decoder=pcm_u8
  --enable-decoder=pcm_mulaw
  --enable-decoder=pcm_alaw
  --enable-decoder=pcm_s24le
  --enable-decoder=pcm_s24be
  --enable-decoder=pcm_s32le
  --enable-decoder=pcm_s32be
  --enable-decoder=pcm_f32le
  --enable-decoder=pcm_f32be
  --enable-decoder=amrnb
  --enable-decoder=amrwb
  --enable-decoder=wmav1
  --enable-decoder=wmav2
  --enable-decoder=wmapro
  --enable-decoder=mp3adu
  --enable-decoder=mp3on4
  
  # 启用音频编码器
  --enable-encoder=libmp3lame
  --enable-encoder=aac
  --enable-encoder=flac
  --enable-encoder=libvorbis
  --enable-encoder=libopus
  --enable-encoder=libvo_amrwbenc
  --enable-encoder=wmav2
  --enable-encoder=pcm_mulaw
  --enable-encoder=pcm_alaw
  #--enable-encoder=pcm_s8
  --enable-encoder=pcm_s16le
  #--enable-encoder=pcm_s24le
  #--enable-encoder=pcm_s32le
  #--enable-encoder=pcm_f32le
  
  # 启用音频格式
  --enable-demuxer=mp3
  --enable-demuxer=aac
  --enable-demuxer=adts
  --enable-demuxer=flac
  --enable-demuxer=ogg
  --enable-demuxer=wav
  --enable-demuxer=opus
  --enable-demuxer=amr
  --enable-demuxer=asf
  --enable-demuxer=mov
  --enable-demuxer=mp4
  --enable-demuxer=3gpp
  --enable-demuxer=aiff
  --enable-demuxer=au
  --enable-muxer=mp3
  --enable-muxer=aac
  --enable-muxer=adts
  --enable-muxer=flac
  --enable-muxer=ogg
  --enable-muxer=wav
  --enable-muxer=opus
  --enable-muxer=amr
  --enable-muxer=asf
  --enable-muxer=mov
  --enable-muxer=mp4
  --enable-muxer=3gpp
  #--enable-muxer=ipod
  #--enable-muxer=aiff
  #--enable-muxer=au
  
  # 启用音频滤镜
  --enable-filter=volume
  --enable-filter=aresample
  --enable-filter=aformat
  --enable-filter=anull
  --enable-filter=afade
  --enable-filter=concat
  --enable-filter=atrim
  --enable-filter=amerge
  --enable-filter=amix
  --enable-filter=asplit
  --enable-filter=atempo
  --enable-filter=adelay
  --enable-filter=areverse
  --enable-filter=equalizer
  #--enable-filter=bass
  #--enable-filter=treble  移除treble和bass 用equalizer代替
  
  # 只启用文件协议
  --enable-protocol=file
  
  # 启用音频外部库
  --enable-libmp3lame
  --enable-libvorbis
  --enable-libopus
  
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
  
  # 线程配置
  ${FFMPEG_ST:+ --disable-pthreads --disable-w32threads --disable-os2threads}
)

emconfigure ./configure "${CONF_FLAGS[@]}" $@
emmake make -j