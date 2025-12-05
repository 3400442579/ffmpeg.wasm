# FFmpeg 配置选项分析

## 1. 帮助选项

- `--help`: 显示帮助信息
- `--list-decoders`: 显示所有可用的解码器
- `--list-encoders`: 显示所有可用的编码器
- `--list-hwaccels`: 显示所有可用的硬件加速器
- `--list-demuxers`: 显示所有可用的解复用器
- `--list-muxers`: 显示所有可用的复用器
- `--list-protocols`: 显示所有可用的协议
- `--list-filters`: 显示所有可用的滤镜

## 2. 标准选项

- `--prefix=PREFIX`: 安装前缀
- `--enable-gpl`: 允许使用 GPL 代码
- `--enable-version3`: 升级 (L)GPL 到版本 3
- `--enable-nonfree`: 允许使用非自由代码

## 3. 配置选项

- `--disable-static`: 不构建静态库
- `--enable-shared`: 构建共享库
- `--enable-small`: 优化大小而非速度
- `--disable-runtime-cpudetect`: 禁用运行时 CPU 能力检测
- `--disable-all`: 禁用构建组件、库和程序
- `--disable-everything`: 禁用下面列出的所有组件
- `--disable-autodetect`: 禁用自动检测的外部库

## 4. 组件选项

- `--disable-avdevice`: 禁用 libavdevice 构建
- `--disable-avcodec`: 禁用 libavcodec 构建
- `--disable-avformat`: 禁用 libavformat 构建
- `--disable-swresample`: 禁用 libswresample 构建
- `--disable-swscale`: 禁用 libswscale 构建
- `--disable-avfilter`: 禁用 libavfilter 构建
- `--disable-pthreads`: 禁用 pthreads
- `--disable-network`: 禁用网络支持

## 5. 单个组件选项

- `--disable-encoder=NAME`: 禁用指定的编码器
- `--enable-encoder=NAME`: 启用指定的编码器
- `--disable-decoder=NAME`: 禁用指定的解码器
- `--enable-decoder=NAME`: 启用指定的解码器
- `--disable-muxer=NAME`: 禁用指定的复用器
- `--enable-muxer=NAME`: 启用指定的复用器
- `--disable-demuxer=NAME`: 禁用指定的解复用器
- `--enable-demuxer=NAME`: 启用指定的解复用器
- `--disable-protocol=NAME`: 禁用指定的协议
- `--enable-protocol=NAME`: 启用指定的协议
- `--disable-filter=NAME`: 禁用指定的滤镜
- `--enable-filter=NAME`: 启用指定的滤镜

## 6. 外部库支持

### 音频相关库
- `--enable-libmp3lame`: 启用 MP3 编码
- `--enable-libvorbis`: 启用 Vorbis 编解码
- `--enable-libopus`: 启用 Opus 编解码
- `--enable-libfdk-aac`: 启用 AAC 编解码（高质量）
- `--enable-libspeex`: 启用 Speex 编解码
- `--enable-libtwolame`: 启用 MP2 编码
- `--enable-libsoxr`: 启用 libsoxr 重采样
- `--enable-libpulse`: 启用 Pulseaudio 输入
- `--enable-libjack`: 启用 JACK 音频服务器
- `--enable-libilbc`: 启用 iLBC 编解码
- `--enable-libgsm`: 启用 GSM 编解码
- `--enable-libopencore-amrnb`: 启用 AMR-NB 编解码
- `--enable-libopencore-amrwb`: 启用 AMR-WB 解码
- `--enable-libvo-amrwbenc`: 启用 AMR-WB 编码

### 视频/图像相关库（音频处理中要禁用的）
- `--enable-libx264`: 启用 H.264 编码
- `--enable-libx265`: 启用 H.265/HEVC 编码
- `--enable-libvpx`: 启用 VP8/VP9 编解码
- `--enable-libaom`: 启用 AV1 编解码
- `--enable-libwebp`: 启用 WebP 编码
- `--enable-libass`: 启用字幕渲染
- `--enable-libfreetype`: 启用字体渲染
- `--enable-libfribidi`: 改进 drawtext 滤镜
- `--enable-libharfbuzz`: 改进 drawtext 滤镜

### 其他库
- `--enable-libopencv`: 启用视频过滤
- `--enable-libzimg`: 启用 z.lib，zscale 滤镜需要
- `--enable-librubberband`: 启用 rubberband 滤镜
- `--enable-libvmaf`: 启用 vmaf 滤镜

## 7. 硬件加速支持

### NVIDIA
- `--disable-cuvid`: 禁用 Nvidia CUVID
- `--disable-nvenc`: 禁用 Nvidia 视频编码
- `--disable-nvdec`: 禁用 Nvidia 视频解码加速

### Intel
- `--disable-vaapi`: 禁用 Video Acceleration API
- `--enable-libmfx`: 启用 Intel MediaSDK (Quick Sync Video)

### AMD
- `--disable-amf`: 禁用 AMF 视频编码

### Apple
- `--disable-audiotoolbox`: 禁用 Apple AudioToolbox
- `--disable-videotoolbox`: 禁用 VideoToolbox

### 跨平台
- `--disable-opencl`: 禁用 OpenCL
- `--disable-opengl`: 禁用 OpenGL
- `--disable-vulkan`: 禁用 Vulkan

## 8. 优化选项

- `--disable-asm`: 禁用所有汇编优化
- `--disable-mmx`: 禁用 MMX 优化
- `--disable-sse`: 禁用 SSE 优化
- `--disable-sse2`: 禁用 SSE2 优化
- `--disable-sse3`: 禁用 SSE3 优化
- `--disable-ssse3`: 禁用 SSSE3 优化
- `--disable-sse4`: 禁用 SSE4 优化
- `--disable-sse42`: 禁用 SSE4.2 优化
- `--disable-avx`: 禁用 AVX 优化
- `--disable-avx2`: 禁用 AVX2 优化
- `--disable-neon`: 禁用 NEON 优化（ARM）
- `--disable-simd128`: 禁用 WebAssembly simd128 优化

## 9. 协议

- `--enable-protocol=file`: 启用文件协议（本地文件系统）
- `--enable-protocol=http`: 启用 HTTP 协议
- `--enable-protocol=https`: 启用 HTTPS 协议
- `--enable-protocol=rtmp`: 启用 RTMP 协议
- `--enable-protocol=rtsp`: 启用 RTSP 协议

## 10. 设备

- `--disable-indev=alsa`: 禁用 ALSA 输入设备
- `--disable-outdev=alsa`: 禁用 ALSA 输出设备
- `--disable-indev=pulse`: 禁用 PulseAudio 输入设备
- `--disable-outdev=pulse`: 禁用 PulseAudio 输出设备
- `--disable-indev=jack`: 禁用 JACK 输入设备
- `--disable-outdev=jack`: 禁用 JACK 输出设备

## 音频处理构建建议

对于音频处理，建议使用以下策略：

1. 使用 `--disable-everything` 禁用所有组件
2. 只启用必要的组件：`--enable-avcodec`, `--enable-avformat`, `--enable-avfilter`, `--enable-swresample`, `--enable-avutil`
3. 只启用需要的音频编解码器和格式
4. 只启用需要的音频滤镜
5. 只启用文件协议，禁用网络协议
6. 禁用所有视频相关的硬件加速和库

这样可以创建一个专注于音频处理的最小化 FFmpeg 构建，减小 WebAssembly 文件的大小。