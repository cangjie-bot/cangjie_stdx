/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin

sealed abstract class PluginInfo {
    private let _libVersion: String

    public init(libVersion: String) {
        this._libVersion = libVersion
    }
    public prop libVersion: String {
        get() {
            return _libVersion
        }
    }
}

sealed abstract class PluginBase {
    private let _name: String

    public init(name: String) {
        this._name = name
    }
    public prop name: String {
        get() {
            return _name
        }
    }
    public open func preVisit(): Unit {}
    public open func postVisit(): Unit {}
}

public abstract class Plugin<T> <: PluginBase {
    public init(name: String) {
        super(name)
    }
    public open func run(value: T): Unit
}