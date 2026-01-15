/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package stdx.plugin.macros

import std.ast.*

public macro astPlugin(attrs: Tokens, pluginClass: Tokens): Tokens {
    if (let Some(decl: ClassDecl) <- (parseDecl(pluginClass) as ClassDecl)) {
        quote($(pluginClass)
        @C public func registerPlugin() {
            registerASTPlugin({ => $(decl.identifier)() }, $(attrs))
        })
    } else {
        pluginClass
    }
}