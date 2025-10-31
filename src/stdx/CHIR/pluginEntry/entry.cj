/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.pluginEntry

import stdx.CHIR.lib.*
import std.collection.*

public struct CHIRPluginInfo {
    private let _libVersion: String
    private let _generator: (CHIRBuilder) -> CHIRPluginBase

    public init(libVersion: String, generator: (CHIRBuilder) -> CHIRPluginBase) {
        this._libVersion = libVersion
        this._generator = generator
    }
    public prop libVersion: String {
        get() {
            return _libVersion
        }
    }
    public prop generator: (CHIRBuilder) -> CHIRPluginBase {
        get() {
            return _generator
        }
    }
}

public var pluginGenerator = ArrayList<CHIRPluginInfo>()

public abstract class CHIRPluginBase {
    
    private let _name: String
    protected let _builder: CHIRBuilder

    public init(name: String, builder: CHIRBuilder) {
        this._name = name
        this._builder = builder
    }
    public prop name: String {
        get() {
            return _name
        }
    }
    public open func preVisit(): Unit {
    }
}

public abstract class CHIRPlugin<T> <: CHIRPluginBase {
    public init(name: String, builder: CHIRBuilder) {
        super(name, builder)
    }
    public open func run(value: T): Unit
}

@C
public struct PluginResult {
    PluginResult(public let data: CPointer<UInt8>, public let length: Int64, public let success: Bool) {}
}

@C
public func CHIRPluginEntry(data: CPointer<UInt8>, length: Int64): PluginResult {
    let pkg = deserialize(data, length)
    let builder = CHIRBuilder(pkg)
    var success = true
    for (it in pluginGenerator) {
        let plugin = it.generator(builder)
        try {
            plugin.preVisit()
            match (plugin) {
                case funcPlugin: CHIRPlugin<Function> =>
                    for (f in pkg.globalFuncs) {
                        funcPlugin.run(f)
                    }
                case packagePlugin: CHIRPlugin<Package> => packagePlugin.run(pkg)
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