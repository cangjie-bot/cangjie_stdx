/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin

import std.collection.*
import stdx.CHIR.lib.*

public var chirPluginGenerator = ArrayList<CHIRPluginInfo>()

public class CHIRPluginInfo <: PluginInfo {
    private let _generator: (CHIRBuilder) -> PluginBase

    public init(libVersion: String, generator: (CHIRBuilder) -> PluginBase) {
        super(libVersion)
        this._generator = generator
    }
    public prop generator: (CHIRBuilder) -> PluginBase {
        get() {
            return _generator
        }
    }
}