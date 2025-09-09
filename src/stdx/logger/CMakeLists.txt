# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if(OHOS)
    set(LOGGER_SRCS
        common_logger_ohos.cj
        json_logger.cj
        str_ext.cj
        text_logger.cj
        simple_logger.cj
        CACHE INTERNAL "")
else()
    set(LOGGER_SRCS
        common_logger.cj
        json_logger.cj
        str_ext.cj
        text_logger.cj
        simple_logger.cj
        CACHE INTERNAL "")
endif()
