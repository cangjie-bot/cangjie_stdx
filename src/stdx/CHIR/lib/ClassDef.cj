/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

public class ClassDef <: CustomTypeDef {
    public prop classType: ClassType {
        get() {
            return (_type as ClassType).getOrThrow()
        }
    }
    internal init(identifier: String, srcName: String, pkgName: String) {
        super(CustomDefKind.CLASS, identifier, srcName, pkgName)
        this._hashCode = calculateHashCode()
    }
}