/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
 /*
 * @file
 *
 * This file declares the NodeWriter, which serializes AST for Syntax.
 */

#ifndef CANGJIE_TOKEN_WRITER_H
#define CANGJIE_TOKEN_WRITER_H

#include <fstream>
#include <set>
#include <vector>

#include "cangjie/Lex/Token.h"

using namespace Cangjie;

namespace TokenWriter {
    std::vector<Token> GetTokensFromBytes(const uint8_t* pBuffer);
}

#endif /* CANGJIE_TOKEN_SERIALIZATION_H */
    