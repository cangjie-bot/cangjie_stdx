/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package stdx.CHIR.pluginMacro

import std.ast.*

public macro CHIRPluginMacro(input: Tokens): Tokens {
    let decl = (parseDecl(input) as ClassDecl).getOrThrow()
    let declName = Token(TokenKind.STRING_LITERAL, decl.identifier.value)
    let initToken = quote(internal init(builder: CHIRBuilder) {
        super($declName, builder)
    })
    let initDecl = parseDecl(initToken)
    decl.body.decls.add(initDecl)
    return quote(
        $decl
        @C
        public func registerPlugin(): Bool {
            let info = CHIRPluginInfo("1.0.0", {builder => $(decl.identifier)(builder)})
            pluginGenerator.add(info)
            return true
        }
    )
}