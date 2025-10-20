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

std::vector<Token> GetTokensFromBytes(const uint8_t* pBuffer)
{
    if (pBuffer == nullptr) {
        return {};
    }
    std::vector<Token> tokens{};
    uint32_t numberOfTokens = 0;
    (void)std::copy(pBuffer, pBuffer + sizeof(uint32_t), reinterpret_cast<uint8_t*>(&numberOfTokens));
    pBuffer += sizeof(uint32_t);
    for (uint32_t i = 0; i < numberOfTokens; ++i) {
        uint16_t kind = 0;
        (void)std::copy(pBuffer, pBuffer + sizeof(uint16_t), reinterpret_cast<uint8_t*>(&kind));
        pBuffer += sizeof(uint16_t);
        uint32_t strLen = 0;
        (void)std::copy(pBuffer, pBuffer + sizeof(uint32_t), reinterpret_cast<uint8_t*>(&strLen));
        pBuffer += sizeof(uint32_t);
        std::string value = GetStringFromBytes(pBuffer, strLen);
        pBuffer += strLen;
        uint32_t fileID = 0;
        constexpr auto i4 = sizeof(int32_t);
        (void)std::copy(pBuffer, pBuffer + i4, reinterpret_cast<uint8_t*>(&fileID));
        pBuffer += i4;
        int32_t line = 0;
        int32_t column = 0;
        (void)std::copy(pBuffer, pBuffer + i4, reinterpret_cast<uint8_t*>(&line));
        pBuffer += i4;
        (void)std::copy(pBuffer, pBuffer + i4, reinterpret_cast<uint8_t*>(&column));
        pBuffer += i4;
        Position begin{fileID, line, column};

        uint16_t isSingle = 0;
        (void)std::copy(pBuffer, pBuffer + sizeof(uint16_t), reinterpret_cast<uint8_t*>(&isSingle));
        pBuffer += sizeof(uint16_t);
        unsigned delimiterNum{1};
        if (static_cast<TokenKind>(kind) == TokenKind::MULTILINE_RAW_STRING) {
            (void)std::copy(pBuffer, pBuffer + sizeof(uint16_t), reinterpret_cast<uint8_t*>(&delimiterNum));
            pBuffer += sizeof(uint16_t);
        }
        Position end{begin == INVALID_POSITION ? INVALID_POSITION
            : begin + GetTokenLength(value.size(), static_cast<TokenKind>(kind), delimiterNum)};
        Token token{static_cast<TokenKind>(kind), std::move(value), begin, end};
        token.delimiterNum = delimiterNum;
        token.isSingleQuote = (isSingle == 1) ? true : false;
        (void)tokens.emplace_back(std::move(token));
    }
    return tokens;
}
} // namespace

