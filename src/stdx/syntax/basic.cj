/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

// Diagnostic
public enum DiagnosticInfo {
    | Warning(String, String) | ...
}

public class Diagnostic {
    public let diagInfo: DiagnosticInfo

    internal init(diagInfo: DiagnosticInfo) {
        this.diagInfo = diagInfo
    }
}

// Parse result
public class ParsingResult<T> where T <: SyntaxTreeNode {
    public let node: T
    public let diags: Array<Diagnostic>

    internal init(node: T, diags: Array<Diagnostic>) {
        this.node = node
        this.diags = diags
    }
}
