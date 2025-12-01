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

public macro RegisterPlugin(input: Tokens): Tokens {
    let subClassDecl = (parseDecl(input) as ClassDecl).getOrThrow()
    if (subClassDecl.superTypes.size != 1) {
        throw Exception(subClassDecl.identifier.value + " must have exactly one super type")
    }
    let superType = (subClassDecl.superTypes[0] as RefType).getOrThrow()
    if (superType.identifier.value != "Plugin") {
        throw Exception(subClassDecl.identifier.value + " must inherit from Plugin")
    }
    let typeArgs = superType.typeArguments
    if (typeArgs.size != 1) {
        throw Exception("class Plugin must have exactly one type argument")
    }
    // TOOD: 目前宏展开阶段无法获取token的package name，需要等late宏的实现，暂时先简单处理一下
    let typeArgName = (typeArgs[0] as RefType).getOrThrow().identifier.value
    let isCHIRPlugin = typeArgName == "Function" || typeArgName == "Package"
    if (isCHIRPlugin) {
        return generateCHIRPluginInfo(subClassDecl)
    } else {
        return generateASTPluginInfo(subClassDecl)
    }
}