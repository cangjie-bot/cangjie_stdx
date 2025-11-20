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

# 1. 源文件（保持不变）
file(GLOB synatx_ffi_src
    AstApi.cpp
    NodeWriter.cpp
    ExprWriter.cpp
    TokenWriter.cpp
    ParserSyntax.cpp
    ParserSyntaxImpl.cpp
)

set(libname stdx.syntaxFFI)

# 2. 改为 STATIC 库（不再是 SHARED）
add_library(${libname} STATIC ${synatx_ffi_src})

# 不再需要 -fPIC 强制设置（静态库通常不需要，除非被用于 shared lib）
# 但如果后续会被链接进 shared lib，保留也无妨
set_target_properties(${libname} PROPERTIES COMPILE_FLAGS "-fPIC")

# 3. 依赖（保持不变）
add_dependencies(${libname} FLATC_OUTPUTS)

# 4. 查找 Cangjie 路径（保持不变）
set(CANGJIE_INC_DIR)
set(AST_SUPPORT_LIB_DIR)
set(LSP_LIB_DIR)

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

# 5. 编译选项和头文件（保持不变）
target_compile_options(${libname} PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
target_include_directories(${libname} PRIVATE ${CANGJIE_INC_DIR} ${CMAKE_BINARY_DIR}/include)

if(CANGJIE_BUILD_STDLIB_WITH_COVERAGE)
    target_compile_options(${libname} PUBLIC "-fno-exceptions")
    target_compile_definitions(${libname} PRIVATE CANGJIE_ENABLE_GCOV)
endif()

# 6. 🔥 关键：合并 libcangjie-ast-support.a 到静态库中

# 构建 support.a 的完整路径
string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_cj_lib_dir)
set(AST_SUPPORT_LIB_PATH "${AST_SUPPORT_LIB_DIR}/libcangjie-ast-support.a")

if(NOT EXISTS "${AST_SUPPORT_LIB_PATH}")
    message(FATAL_ERROR "AST support library not found: ${AST_SUPPORT_LIB_PATH}")
endif()

# 方法：使用自定义命令合并（兼容所有 CMake 版本）
set(MERGED_STATIC_LIB "${CMAKE_CURRENT_BINARY_DIR}/lib${libname}.a")

# 获取当前库生成的 .a 文件路径（CMake 自动生成）
get_target_property(ORIGINAL_STATIC_LIB ${libname} ARCHIVE_OUTPUT_NAME)
if(ORIGINAL_STATIC_LIB STREQUAL "ORIGINAL_STATIC_LIB-NOTFOUND")
    set(ORIGINAL_STATIC_LIB "lib${libname}.a")
endif()
set(ORIGINAL_STATIC_LIB_PATH "${CMAKE_CURRENT_BINARY_DIR}/${ORIGINAL_STATIC_LIB}")

# 自定义合并命令
add_custom_command(
    OUTPUT ${MERGED_STATIC_LIB}
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${AST_SUPPORT_LIB_PATH} ${MERGED_STATIC_LIB}
    COMMAND ar q ${MERGED_STATIC_LIB} ${ORIGINAL_STATIC_LIB_PATH}
    COMMAND ranlib ${MERGED_STATIC_LIB}
    DEPENDS ${libname} ${AST_SUPPORT_LIB_PATH}
    COMMENT "Merging libcangjie-ast-support.a into ${MERGED_STATIC_LIB}"
)

# 创建一个 INTERFACE 库，供其他目标链接最终合并后的静态库
add_library(${libname}_merged INTERFACE)
target_link_libraries(${libname}_merged INTERFACE ${MERGED_STATIC_LIB})

# 7. 安装规则（你可能需要调整 install_cangjie_library_ffi_s）
# 假设 install_cangjie_library_ffi_s 安装静态库，现在应指向 MERGED 版本

# 重写安装逻辑（如果原函数不支持自定义路径）
install(FILES ${MERGED_STATIC_LIB}
        DESTINATION lib
        RENAME lib${libname}.a)

# 如果你仍想保留原来的 install 函数调用，可注释上面 install，并修改函数行为
# 但更安全的方式是显式安装 merged 库