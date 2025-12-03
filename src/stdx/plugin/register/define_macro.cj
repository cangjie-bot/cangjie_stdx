/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package stdx.plugin.register

import stdx.plugin.*
import std.ast.*

public macro RegisterPlugin(node: Tokens, input: Tokens): Tokens {
    let subClassDecl = (parseDecl(input) as ClassDecl).getOrThrow()
    var superTypes = subClassDecl.superTypes
    for (superType in superTypes) {
        if ((superType as RefType).getOrThrow().identifier.value == "Plugin") {
            throw Exception(subClassDecl.identifier.value + " can't inherit from class Plugin<T> manually.")
        }
    }
    superTypes.add(RefType(quote(Plugin<$node>)))
    let nodeName = node.toString()
    let isCHIRPlugin = nodeName == "Function" || nodeName == "Package"
    if (isCHIRPlugin) {
        return generateCHIRPluginInfo(subClassDecl)
    } else {
        return generateASTPluginInfo(subClassDecl)
    }
}