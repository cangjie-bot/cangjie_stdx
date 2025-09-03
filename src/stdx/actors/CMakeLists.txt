# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
#
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(ACTORS_SRCS
    actor_future.cj
    actors.cj
    mailbox.cj
    priority_queue.cj
    semaphore.cj
    CACHE INTERNAL "")

add_subdirectory(macros)