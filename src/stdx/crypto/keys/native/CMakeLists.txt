# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

file(
    GLOB
    keys_ffi_src
    keys.c
)

set(libname stdx.crypto.keysFFI)

add_library(${libname}-objs OBJECT ${keys_ffi_src})

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    add_library(${libname} STATIC $<TARGET_OBJECTS:${libname}-objs>)
endif()

target_include_directories(${libname}-objs PRIVATE ${CMAKE_SOURCE_DIR}/src/stdx/dynamicLoader)
target_include_directories(${libname}-objs PRIVATE ${OPENSSL_INCLUDE_DIR})
install_cangjie_library_ffi(${libname})

# key.ffi compile .so
if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH ON)
    add_library(${libname}-shared SHARED $<TARGET_OBJECTS:${libname}-objs>)
    target_link_libraries(${libname}-shared cangjie-dynamicLoader-opensslFFI-shared)
    target_link_libraries(${libname}-shared boundscheck)
    if(MINGW)
        target_link_libraries(${libname}-shared crypt32)
        target_link_libraries(${libname}-shared ws2_32)
    endif()
    set_target_properties(${libname}-shared PROPERTIES OUTPUT_NAME ${libname})
    install_cangjie_library_ffi_s(${libname}-shared)
endif()