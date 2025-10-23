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
 * This file implements the NodeWriter.
 */
#include "TokenWriter.h"
#include <algorithm>

using namespace Cangjie;

namespace TokenWriter {
inline size_t GetTokenLength(size_t originalSize, TokenKind kind, unsigned delimiterNum)
{
    constexpr auto doubleQuotesSize = 2;
    constexpr auto multiQuotesSize = 6;
    switch (kind) {
        // both windows and linux trait NL as 1 size
        case TokenKind::NL:
            return 1;
        case TokenKind::STRING_LITERAL:
            return originalSize + doubleQuotesSize;
        case TokenKind::RUNE_LITERAL:
        case TokenKind::JSTRING_LITERAL:
            return originalSize + doubleQuotesSize + 1;
        case TokenKind::MULTILINE_STRING:
            return originalSize + multiQuotesSize;
        // For ##"abc"##, the offset of the length and value is 3 * 2.
        case TokenKind::MULTILINE_RAW_STRING:
            return originalSize + ((delimiterNum + 1) << 1);
        default:
            return originalSize;
    }
}

std::string GetStringFromBytes(const uint8_t* pBuffer, uint32_t strLen)
{
    if (pBuffer == nullptr) {
        return "";
    }
    std::string value;
    for (uint32_t i = 0; i < strLen; i++) {
        if (*pBuffer == '\0') {
            value += "\\0";
            pBuffer += 1;
            continue;
        }
        value.push_back(static_cast<char>(*pBuffer));
        pBuffer += 1;
    }
    return value;
}

} // namespace

