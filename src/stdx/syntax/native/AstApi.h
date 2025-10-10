/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
#ifndef CANGJIE_AST_API_H
#define CANGJIE_AST_API_H

#include <string>

extern "C" {
struct ParseRes {
    uint8_t* node;
    char* eMsg;
};
}

#endif /* CANGJIE_AST_API_H */
