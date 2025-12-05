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
  -Wl,--gc-sections 
  -Wl,--strip-all 
  $LDFLAGS 
  -sENVIRONMENT=worker
  -sWASM_BIGINT                            # enable big int support
  -sSTACK_SIZE=2MB                         # 进一步减小栈大小
  -sMODULARIZE                             # modularized to use as a library
  -sFILESYSTEM=1                           # 保持文件系统支持
  -sASSERTIONS=0                           # 禁用断言以减小体积
  -sALLOW_TABLE_GROWTH=0                   # 禁用表增长
  -sEXPORT_ES6=0                           # 在构建时控制ES6导出
  # MINIFY_RUNTIME 选项不存在，已移除
  -sABORTING_MALLOC=0                      # 禁用malloc中止检查
  -sDEMANGLE_SUPPORT=0                     # 禁用符号解析支持
  -sDISABLE_EXCEPTION_CATCHING=1           # 禁用异常捕获以减小体积
  -sNODEJS_CATCH_EXIT=0                    # 禁用Node.js退出捕获
  -sNODEJS_CATCH_REJECTION=0               # 禁用Promise拒绝捕获
  ${FFMPEG_MT:+ -sINITIAL_MEMORY=1024MB}   # ALLOW_MEMORY_GROWTH is not recommended when using threads, thus we use a large initial memory
  ${FFMPEG_MT:+ -sPTHREAD_POOL_SIZE=32}    # use 32 threads
  ${FFMPEG_ST:+ -sINITIAL_MEMORY=20MB -sALLOW_MEMORY_GROWTH} # 减少初始内存大小，允许增长
  -sEXPORT_NAME="$EXPORT_NAME"             # required in browser env, so that user can access this module from window object
  -sEXPORTED_FUNCTIONS=$(node src/bind/ffmpeg/export.js) # exported functions
  -sEXPORTED_RUNTIME_METHODS=$(node src/bind/ffmpeg/export-runtime.js) # exported built-in functions
  # MINIMAL_JS_RUNTIME 选项不存在，已移除
  -sPRECISE_F32=0                             # 禁用精确F32以减小体积
  -lworkerfs.js
  --pre-js src/bind/ffmpeg/bind.js        # extra bindings, contains most of the ffmpeg.wasm javascript code
  # 保留音频处理需要的源代码，但排除硬件加速相关代码
  src/fftools/cmdutils.c 
  src/fftools/ffmpeg.c 
  src/fftools/ffmpeg_filter.c  # 音频滤镜需要此文件
  src/fftools/ffmpeg_mux.c    # 音频输出和文件生成需要此文件
  src/fftools/ffmpeg_opt.c 
  src/fftools/opt_common.c   # 共享选项处理，ffmpeg_opt.c 已包含音频选项
)

emcc "${CONF_FLAGS[@]}" $@
