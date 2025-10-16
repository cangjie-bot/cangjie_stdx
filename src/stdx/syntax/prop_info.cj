/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

class PropInfo {
    var index: Int64 = 0
    var offset: Offset = Offset()
    init() {}
    init(index: Int64, offset: Offset) {
        this.index = index
        this.offset = Offset(offset.line, offset.column)
    }
}
