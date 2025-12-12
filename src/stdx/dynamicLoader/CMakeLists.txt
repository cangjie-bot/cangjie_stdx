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

# Because we want to embed it into other static artifacts to avoid extra openssl symbol retention logic.
# So we build a static library here.
set(libname cangjie-dynamicLoader-opensslFFI)

add_library(${libname}-objs OBJECT ${openssl_ffi_src})
target_include_directories(${libname}-objs PRIVATE ${OPENSSL_INCLUDE_DIR})

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    # Static FFI builds opensslSymbols.c with CJ_OPENSSL_STATIC to get strong refs.
    add_library(${libname} STATIC ${openssl_ffi_src} staticSymbols.c)
    target_compile_definitions(${libname} PRIVATE CJ_OPENSSL_STATIC=1)
    target_include_directories(${libname} PRIVATE ${OPENSSL_INCLUDE_DIR})
endif()

install_cangjie_library_ffi(${libname})



if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    # dynamic library only contains dynamic loading logic, does not forcibly introduce openssl symbols.
    add_library(${libname}-shared SHARED $<TARGET_OBJECTS:${libname}-objs> staticSymbols.c)
    set_target_properties(${libname}-shared PROPERTIES OUTPUT_NAME ${libname})
    target_include_directories(${libname}-shared PRIVATE ${OPENSSL_INCLUDE_DIR})
    target_link_libraries(${libname}-shared PRIVATE OpenSSL::Crypto OpenSSL::SSL)
    if(MINGW)
        target_link_options(${libname}-shared PRIVATE -pthread -Wl,--export-all-symbols)
    endif()
    install_cangjie_library_ffi_s(${libname}-shared)
endif()
