/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package stdx.plugin.macros

import std.ast.*

/**
 * Annotates an AST plugin class and automatically generates plugin registration code.
 *
 * This macro automatically generates a `registerPlugin` function after the annotated class,
 * used to register the plugin with the compiler, and adds an ASTPlugin super type to the annotated class.
 *
 * @param attrs Macro attribute parameters specifying the compilation stage (`CompileStage`) at which the plugin runs.
 * @param pluginClass The plugin class definition being annotated.
 * @return A token sequence containing the original class definition and the automatically generated registration function.
 *
 * Example:
 * ```
 * @astPlugin[BeforeMacro]
 * public class MyPlugin {
 *     public prop name: String { get() { "MyPlugin" } }
 *     public func run(`package`: Package): Bool { true }
 * }
 * ```
 */
public macro astPlugin(attrs: Tokens, pluginClass: Tokens): Tokens {
    if (let Some(decl: ClassDecl) <- (parseDecl(pluginClass) as ClassDecl)) {
        decl.superTypes.add(RefType(Tokens(Token(TokenKind.IDENTIFIER, "ASTPlugin"))), at: 0)
        if (!decl.superTypeBitAnds.size == 0) {
            decl.superTypeBitAnds = Tokens(Token(TokenKind.BITAND, "&")) + decl.superTypeBitAnds
        }
        quote($(decl)
        @C public func registerPlugin() {
            registerASTPlugin({ => $(decl.identifier)() }, $(attrs))
        })
    } else {
        pluginClass
    }
}
