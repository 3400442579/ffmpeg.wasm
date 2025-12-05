#!/bin/bash
# `-o <OUTPUT_FILE_NAME>` must be provided when using this build script.
# ex:
#     bash ffmpeg-wasm.sh -o ffmpeg.js

set -euo pipefail

EXPORT_NAME="createFFmpegCore"

CONF_FLAGS=(
  -I. 
  -I./src/fftools 
  -I$INSTALL_DIR/include 
  -L$INSTALL_DIR/lib 
  -Llibavcodec 
  -Llibavfilter 
  -Llibavformat 
  -Llibavutil 
  -Llibswresample 
  -lavcodec 
  -lavfilter 
  -lavformat 
  -lavutil 
  -lswresample 
  -Wno-deprecated-declarations 
  $LDFLAGS 
  -sENVIRONMENT=worker
  -sWASM_BIGINT                            # enable big int support
  -sSTACK_SIZE=4MB                         # 减少栈大小，音频处理不需要5MB
  -sMODULARIZE                             # modularized to use as a library
  -sFILESYSTEM=1                           # 保持文件系统支持
  -sASSERTIONS=1                           # 禁用断言以减小体积
  -sALLOW_TABLE_GROWTH=0                   # 禁用表增长
  -sEXPORT_ES6=0                           # 在构建时控制ES6导出
  
  ${FFMPEG_MT:+ -sINITIAL_MEMORY=1024MB}   # ALLOW_MEMORY_GROWTH is not recommended when using threads, thus we use a large initial memory
  ${FFMPEG_MT:+ -sPTHREAD_POOL_SIZE=32}    # use 32 threads
  ${FFMPEG_ST:+ -sINITIAL_MEMORY=20MB -sALLOW_MEMORY_GROWTH} # 减少初始内存大小，允许增长
  -sEXPORT_NAME="$EXPORT_NAME"             # required in browser env, so that user can access this module from window object
  -sEXPORTED_FUNCTIONS=$(node src/bind/ffmpeg/export.js) # exported functions
  -sEXPORTED_RUNTIME_METHODS=$(node src/bind/ffmpeg/export-runtime.js) # exported built-in functions
  -lworkerfs.js
  --pre-js src/bind/ffmpeg/bind.js        # extra bindings, contains most of the ffmpeg.wasm javascript code
  # 保留音频处理需要的源代码
  src/fftools/cmdutils.c 
  src/fftools/ffmpeg.c 
  src/fftools/ffmpeg_filter.c  # 音频滤镜需要此文件
  src/fftools/ffmpeg_mux.c    # 音频输出和文件生成需要此文件
  src/fftools/ffmpeg_opt.c 
  src/fftools/ffmpeg_hw.c    # 硬件加速相关，音频处理不需要
  src/fftools/opt_common.c   # 共享选项处理，ffmpeg_opt.c 已包含音频选项
)

emcc "${CONF_FLAGS[@]}" $@
