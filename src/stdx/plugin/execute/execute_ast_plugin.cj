/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin.execute

import std.collection.*

@C
public func executeASTPlugin(data: CPointer<UInt8>, length: Int64): PluginResult {
    return PluginResult(CPointer<UInt8>(), 0, false)
}