/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

public class StructDef <: CustomTypeDef {
    protected init(identifier: String, srcName: String, pkgName: String) {
        super(CustomDefKind.STRUCT, identifier, srcName, pkgName)
    }
}