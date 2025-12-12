# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

file(
    GLOB
    openssl_ffi_src
    opensslSymbols.c
)
# Object library用于嵌入其他静态产物，避免额外的 openssl 符号保持逻辑。
set(libname cangjie-dynamicLoader-opensslFFI)
add_library(${libname}-objs OBJECT ${openssl_ffi_src})


if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    add_library(${libname} STATIC $<TARGET_OBJECTS:${libname}-objs> staticSymbols.c)
    target_include_directories(${libname} PRIVATE ${OPENSSL_INCLUDE_DIR})
endif()

target_include_directories(${libname}-objs PRIVATE ${OPENSSL_INCLUDE_DIR})

install_cangjie_library_ffi(${libname})


if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    # 共享库仍然只带动态加载逻辑，不强制引入 openssl 符号。
    add_library(${libname}-shared SHARED $<TARGET_OBJECTS:${libname}-objs>)
    set_target_properties(${libname}-shared PROPERTIES OUTPUT_NAME ${libname})
    if(MINGW)
        target_link_options(${libname}-shared PRIVATE -pthread -Wl,--export-all-symbols)
    endif()
    install_cangjie_library_ffi_s(${libname}-shared)
endif()
