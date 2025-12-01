/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package stdx.plugin.register

import std.ast.*

internal func generateCHIRPluginInfo(subClassDecl: ClassDecl): Tokens {
    let subClassName = Token(TokenKind.STRING_LITERAL, subClassDecl.identifier.value)
    let initToken = quote(internal init(builder: CHIRBuilder) {
        super($subClassName)
        this._builder = builder
    })
    let initDecl = parseDecl(initToken)
    subClassDecl.body.decls.add(initDecl)
    let memberVar = quote(private let _builder: CHIRBuilder)
    let memberVarDecl = parseDecl(memberVar)
    subClassDecl.body.decls.add(memberVarDecl)
    return quote(
        $subClassDecl
        @C
        public func registerPlugin(args: CString): Bool {
            let info = CHIRPluginInfo("1.0.0", {builder => $(subClassDecl.identifier)(builder)})
            chirPluginGenerator.add(info)
            return true
        }
    )
}