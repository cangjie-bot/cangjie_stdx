/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

/**
 * @brief Parses a source file located at the specified path and returns the parsing result.
 *
 * @param filePath The file path to the source file that needs to be parsed.
 * @return A ParsingResult object containing the parsed SourceFile or an error.
 *
 * @throws Exception if there is an issue reading the file.
 */
public func parseFile(filePath: String): ParsingResult<SourceFile> {
    if (let (Some(file), diags) <- Parser.parseFile(filePath)) {
        ParsingResult<SourceFile>(file, diags)
    } else {
        throw Exception("InternalException: Illegal argument was encountered while obtaining the SourceFile node.")
    }
}

/**
 * @brief Parses a package located at the specified path and returns the parsing result.
 *
 * @param dirPath The directory path to the source files that needs to be parsed.
 * @return A ParsingResult object containing the parsed Package or an error.
 *
 * @throws Exception if there is an issue reading the file.
 */
public func parsePackage(dirPath: String): ParsingResult<Package> {
    if (let (Some(pkg), diags) <- Parser.parsePackage(dirPath)) {
        ParsingResult<Package>(pkg, diags)
    } else {
        throw Exception("InternalException: Illegal argument was encountered while obtaining the Package node.")
    }
}
