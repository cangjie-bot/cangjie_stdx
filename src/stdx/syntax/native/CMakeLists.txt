# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# Generate cpp code for syntax using flatc with cpp backend.
set(SCHEMA_SRC NodeFormat.fbs)
get_filename_component(FILENAME ${SCHEMA_SRC} NAME_WE)
set(FLATC_EXECUTABLE "${CMAKE_BINARY_DIR}/bin/flatc")
set(FLATBUFFER_SRC ${CMAKE_CURRENT_SOURCE_DIR}/../../../../third_party/flatbuffers)

# message(FATAL_ERROR "flatbuffer source: ${CMAKE_CURRENT_SOURCE_DIR}")

set(FLATC_CPP_OUTPUT "${CMAKE_BINARY_DIR}/include/flatbuffers/${FILENAME}_generated.h")
add_custom_command(
    OUTPUT ${FLATC_CPP_OUTPUT}
    COMMAND ${FLATC_EXECUTABLE} ARGS --no-warnings -c -o "${CMAKE_BINARY_DIR}/include/flatbuffers" ${SCHEMA_SRC}
    DEPENDS flatbuffers ${SCHEMA_SRC} # flatc defined in flatbuffers project: add_executable(flatc..)
    COMMENT "generate cpp file using flatc"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

# Generate cangjie code for syntax using flatc with cangjie backend.
set(FLATC_CJ_OUTPUT "${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj")
set(FLATBUFFER_DEPEND_CJ_DIR ${FLATBUFFER_SRC}/cangjie)
add_custom_command(
    OUTPUT ${FLATC_CJ_OUTPUT}
    COMMAND ${FLATC_EXECUTABLE} ARGS --no-warnings --cangjie -o "${CMAKE_BINARY_DIR}" ${SCHEMA_SRC}
    DEPENDS flatbuffers ${SCHEMA_SRC} # flatc defined in flatbuffers project: add_executable(flatc..)

    COMMAND sed 's/std.ast/stdx.syntax/g' ${FLATBUFFER_DEPEND_CJ_DIR}/flatbuffer_object.cj > ${CMAKE_BINARY_DIR}/flatbuffer_object.cj
    COMMAND sed 's/std.ast/stdx.syntax/g' ${FLATBUFFER_DEPEND_CJ_DIR}/decode.cj > ${CMAKE_BINARY_DIR}/decode.cj
    COMMAND sed 's/std.ast/stdx.syntax/g' ${FLATBUFFER_DEPEND_CJ_DIR}/table.cj > ${CMAKE_BINARY_DIR}/table.cj
    COMMAND sed 's/std.ast/stdx.syntax/g' ${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj > ${CMAKE_BINARY_DIR}/${FILENAME}_generated_update.cj
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/flatbuffer_object.cj
            ${CMAKE_SOURCE_DIR}/src/stdx/syntax/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/decode.cj
            ${CMAKE_SOURCE_DIR}/src/stdx/syntax/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/table.cj
            ${CMAKE_SOURCE_DIR}/src/stdx/syntax/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/${FILENAME}_generated_update.cj
            ${CMAKE_SOURCE_DIR}/src/stdx/syntax/${FILENAME}_generated.cj
    COMMENT "generate cangjie file using flatc"

    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

add_custom_target(FLATC_OUTPUTS ALL DEPENDS ${FLATC_CJ_OUTPUT} ${FLATC_CPP_OUTPUT})

# build syntax ffi lib shared
file(GLOB synatx_ffi_src
    AstApi.cpp
    NodeWriter.cpp
    ExprWriter.cpp
    TokenWriter.cpp)
set(libname stdx.syntaxFFI)
add_library(${libname} SHARED ${synatx_ffi_src})
set_target_properties(${libname} PROPERTIES COMPILE_FLAGS "-fPIC")
add_dependencies(${libname} FLATC_OUTPUTS)

set(CANGJIE_INC_DIR)
set(AST_SUPPORT_LIB_DIR)
set(LSP_LIB_DIR)
# using CANGJIE_HOME or cangjie source directory
if(DEFINED ENV{CANGJIE_HOME})
    if ("$ENV{CANGJIE_LSP_PATH}" STREQUAL "")
        set(LSP_LIB_DIR $ENV{CANGJIE_HOME}/tools/lib)
    else()
        set(LSP_LIB_DIR $ENV{CANGJIE_LSP_PATH})
    endif()
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_cj_lib_dir)
    set(AST_SUPPORT_LIB_DIR $ENV{CANGJIE_HOME}/lib/${output_cj_lib_dir})
    set(CANGJIE_INC_DIR $ENV{CANGJIE_HOME}/include)
    if(NOT EXISTS "${CANGJIE_INC_DIR}/cangjie")
        # using local cangjie source
        set(CANGJIE_INC_DIR ~/dev/cangjie/cangjie/include)
        if(NOT EXISTS "${CANGJIE_INC_DIR}/cangjie")
            message(FATAL_ERROR "NOT FOUND CANGJIE HEADERS")
        endif()
    endif()
else()
    message(FATAL_ERROR "NOT FOUND CJC")
endif()

target_compile_options(${libname} PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
target_include_directories(${libname} PRIVATE ${CANGJIE_INC_DIR} ${CMAKE_BINARY_DIR}/include)
if(CANGJIE_BUILD_STDLIB_WITH_COVERAGE)
    target_compile_options(${libname} PUBLIC "-fno-exceptions")
    target_compile_definitions(${libname} PRIVATE CANGJIE_ENABLE_GCOV)
endif()

if(DARWIN)
    target_link_libraries(${libname} PUBLIC cangjie-lsp)
    add_library(cangjie-lsp SHARED IMPORTED)
    set_target_properties(cangjie-lsp PROPERTIES IMPORTED_LOCATION ${LSP_LIB_DIR}/libcangjie-lsp.dylib)
else()
    if (MINGW)
        add_library(cangjie-lsp SHARED IMPORTED)
        set_target_properties(cangjie-lsp PROPERTIES IMPORTED_IMPLIB ${LSP_LIB_DIR}/libcangjie-lsp.dll.a)
        target_link_libraries(${libname} PUBLIC cangjie-lsp)
    endif()
endif()

# install for dynamic and static lib
install_cangjie_library_ffi(${libname})
install_cangjie_library_ffi_s(${libname})