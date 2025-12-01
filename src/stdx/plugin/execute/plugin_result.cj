/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin.execute

@C
public struct PluginResult {
    PluginResult(public let data: CPointer<UInt8>, public let length: Int64, public let success: Bool) {}
}