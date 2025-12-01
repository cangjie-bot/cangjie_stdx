/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin.execute

import stdx.CHIR.lib.*
import stdx.CHIR.serialize.*
import std.collection.*
import stdx.plugin.*

@C
public func executeCHIRPlugin(data: CPointer<UInt8>, length: Int64): PluginResult {
    let pkg = deserialize(data, length)
    let builder = CHIRBuilder(pkg)
    var success = true
    for (it in chirPluginGenerator) {
        let plugin = it.generator(builder)
        try {
            plugin.preVisit()
            match (plugin) {
                case funcPlugin: Plugin<Function> =>
                    for (f in pkg.globalFuncs) {
                        funcPlugin.run(f)
                    }
                case packagePlugin: Plugin<Package> => packagePlugin.run(pkg)
                case _ => throw Exception("invalid plugin type: " + plugin.name)
            }
        } catch (e: Exception) {
            println("throw exception while running CHIR plugin: " + plugin.name)
            println(e.toString())
            success = false
        }
    }
    if (!success) {
        return PluginResult(CPointer<UInt8>(), 0, false)
    }
    let (resultData, resultLength) = serialize(pkg)
    return PluginResult(resultData, resultLength, true)
}