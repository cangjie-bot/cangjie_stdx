# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# Generate cpp code for ast using flatc with cpp backend.
set(SCHEMA_SRC ${CMAKE_SOURCE_DIR}/schema/PackageFormat.fbs)
get_filename_component(FILENAME ${SCHEMA_SRC} NAME_WE)
set(FLATC_EXECUTABLE "${CMAKE_BINARY_DIR}/bin/flatc")
set(FLATBUFFER_SRC ${CMAKE_SOURCE_DIR}/third_party/flatbuffers)

set(FLATC_CHIR_CJ_OUTPUT "${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj")
set(FLATBUFFER_DEPEND_CJ_DIR ${FLATBUFFER_SRC}/cangjie)
set(REPLACE_FILE ${CMAKE_BINARY_DIR}/replace.cmake)
file(WRITE ${REPLACE_FILE} [=[
    file(READ ${SOURCE} TEXT)
    string(REPLACE std.ast stdx.chir TEXT ${TEXT})
    file(WRITE ${TARGET} ${TEXT})
]=])

add_custom_command(
    OUTPUT ${FLATC_CHIR_CJ_OUTPUT} ${CMAKE_CURRENT_SOURCE_DIR}/table.cj
           ${CMAKE_CURRENT_SOURCE_DIR}/flatbuffer_object.cj
           ${CMAKE_CURRENT_SOURCE_DIR}/decode.cj
           ${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}_generated.cj
    DEPENDS flatbuffers ${SCHEMA_SRC} ${REPLACE_FILE}
    COMMAND ${FLATC_EXECUTABLE} ARGS --no-warnings --cangjie -o "${CMAKE_BINARY_DIR}" ${SCHEMA_SRC}
    COMMAND ${CMAKE_COMMAND} -DSOURCE=${FLATBUFFER_DEPEND_CJ_DIR}/table.cj -DTARGET=${CMAKE_CURRENT_SOURCE_DIR}/table.cj -P ${REPLACE_FILE}
    COMMAND ${CMAKE_COMMAND} -DSOURCE=${FLATBUFFER_DEPEND_CJ_DIR}/flatbuffer_object.cj -DTARGET=${CMAKE_CURRENT_SOURCE_DIR}/flatbuffer_object.cj -P ${REPLACE_FILE}
    COMMAND ${CMAKE_COMMAND} -DSOURCE=${FLATBUFFER_DEPEND_CJ_DIR}/decode.cj -DTARGET=${CMAKE_CURRENT_SOURCE_DIR}/decode.cj -P ${REPLACE_FILE}
    COMMAND ${CMAKE_COMMAND} -DSOURCE=${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj -DTARGET=${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}_generated.cj -P ${REPLACE_FILE}
    COMMENT "Copy std.chir files to libs")
add_custom_target(FLATC_OUTPUTS_STD_CHIR ALL DEPENDS ${FLATC_CHIR_CJ_OUTPUT} ${CMAKE_CURRENT_SOURCE_DIR}/table.cj
    ${CMAKE_CURRENT_SOURCE_DIR}/flatbuffer_object.cj
    ${CMAKE_CURRENT_SOURCE_DIR}/decode.cj
    ${CMAKE_CURRENT_SOURCE_DIR}/${FILENAME}_generated.cj)
