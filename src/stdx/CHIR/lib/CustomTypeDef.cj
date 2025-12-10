/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib
import std.deriving.*

@Derive[Equatable]
protected enum CustomDefKind {
    CLASS | ENUM | EXTEND | STRUCT
}

sealed abstract class CustomTypeDef <: Base & Equatable<CustomTypeDef> {
    private let kind: CustomDefKind
    private let identifier: String
    private let srcCodeIdentifier: String
    private let packageName: String

    public func getIdentifierWithoutPrefix(): String {
        return identifier.removePrefix(GLOBAL_VAL_PREFIX)
    }

    protected init(kind: CustomDefKind, identifier: String, srcName: String, pkgName: String) {
        this.kind = kind
        this.identifier = identifier
        this.srcCodeIdentifier = srcName
        this.packageName = pkgName
    }
    public operator func==(other: CustomTypeDef): Bool {
        return this.kind == other.kind &&
            this.identifier == other.identifier &&
            this.srcCodeIdentifier == other.srcCodeIdentifier &&
            this.packageName == other.packageName
    }
}