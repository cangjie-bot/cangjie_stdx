/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList
import std.fs.*
import std.sort.*

class Parser {
    private let impl: ParserImpl
    private let filepath: String

    private init(filePath: String) {
        impl = ParserImpl(filePath)
        filepath = filePath
    }

    static func parseFile(filePath: String): (?SourceFile, Array<Diagnostic>) {
        let fileInfo = try {
            let path = canonicalize(filePath)
            FileInfo(path)
        } catch (e: Exception) {
            throw Exception("IOException: ${e.message}")
        }
        if (fileInfo.path.extensionName != "cj") {
            throw Exception("IOException: The file extension of the source file must be 'cj'.")
        } else if (!fileInfo.canRead()) {
            throw Exception("IOException: The file is not readable.")
        } else if (!fileInfo.isRegular()) {
            throw Exception("IOException: The path ${fileInfo.path.toString()} is not a file!")
        }
        let (node, diags) = Parser(fileInfo.path.toString()).parse()
        let file: ?SourceFile = if (let Some(root) <- node) {
            root as SourceFile
        } else {
            None
        }
        (file, diags)
    }

    static func parsePackage(dirPath: String): (?Package, Array<Diagnostic>) {
        let fileList = ArrayList<SourceFile>()
        let fileImpls = ArrayList<(SyntaxNodeImpl, String)>()
        let diagsList = ArrayList<Diagnostic>()
        let fileInfos = try {
            let path: Path = Path(dirPath)
            var fileInfos = Directory.readFrom(dirPath)
            let comparator = {l: FileInfo, r: FileInfo => l.name.compare(r.name)}
            sort(fileInfos, by: comparator)
            fileInfos
        } catch (e: Exception) {
            throw Exception("IOException: ${e.message}")
        }
        for (fileInfo in fileInfos) {
            if (fileInfo.path.extensionName != "cj") {
                continue
            }
            var (file, diags) = parseFile(fileInfo.path.toString())
            if (let Some(f) <- file) {
                fileList.add(f)
                fileImpls.add((f.nodeImpl, fileInfo.path.toString()))
            } else {
                throw Exception("InternalException: Failed to parse the file ${fileInfo.path.toString()}.")
            }
            diagsList.add(all: diags)
        }
        let (isMacro, name) = checkPackage(fileList)
        let pkg = Package(isMacro, name, fileImpls.toArray())
        (pkg, diagsList.toArray())
    }

    static func getPackageName(file: SourceFile) {
        if (let Some(pkgHeader) <- file.pkgHeader) {
            return String.join(pkgHeader.packageNameIdentifiers, delimiter: ".")
        }
        return "default"
    }

    static func checkPackage(sourceFiles: ArrayList<SourceFile>): (Bool, String) {
        if (sourceFiles.size == 0) {
            return (false, "")
        }
        var packageName = getPackageName(sourceFiles[0])
        var isMacro: Bool = sourceFiles[0].isMacroPackage
        for (f in sourceFiles) {
            if (packageName != getPackageName(f)) {
                throw Exception("ParseException: found more than one package declaration for the package.")
            }
            if (isMacro != f.isMacroPackage) {
                throw Exception("ParseException: found different macro package declaration.")
            }
        }
        return (isMacro, packageName)
    }

    private func parse(): (?SyntaxTreeNode, Array<Diagnostic>) {
        let (root, diags) = impl.parseFile()
        (buildSyntaxTree(root), getParseDiag(diags))
    }

    // build syntax tree by syntax impl tree
    private func buildSyntaxTree(node: ?SyntaxNodeImpl): ?SyntaxTreeNode {
        if (let Some(root) <- node) {
            SyntaxNodeImplTranslator.translateFile(root, filepath)
        } else {
            None
        }
    }

    private func getParseDiag(diag: ?String): Array<Diagnostic> {
        var result = Array<Diagnostic>()
        if (let Some(str) <- diag) {
            return splitByWarning(str)
        } else {
            return []
        }
    }

    private func splitByWarning(str: String): Array<Diagnostic> {
        var strArray = str.split(NEWLINE, removeEmpty: true)
        var errorMsg = ""
        var hintMsg = ""
        var result = ArrayList<Diagnostic>()
        for (s in strArray) {
            // remove color from note string
            if (s.contains("\u{001b}[33mwarning\u{001b}[0m:")) {
                if (!errorMsg.isEmpty()) {
                    let diag = DiagnosticInfo.Warning(errorMsg, hintMsg)
                    result.add(Diagnostic(diag))
                    hintMsg = ""
                }
                errorMsg = s
            } else {
                hintMsg = hintMsg + s + NEWLINE
            }
        }
        result.add(Diagnostic(DiagnosticInfo.Warning(errorMsg, hintMsg)))
        return result.toArray()
    }
}
