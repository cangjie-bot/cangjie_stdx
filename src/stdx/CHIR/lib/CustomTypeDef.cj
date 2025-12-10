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

sealed abstract class CustomTypeDef <: Base & Equatable<CustomTypeDef> & Hashable {
    private let _kind: CustomDefKind
    private let _identifier: String
    private let _srcCodeIdentifier: String
    private let _packageName: String
    internal var _hashCode: Int64 = 0

    public func hashCode(): Int64 {
        return _hashCode
    }

    protected prop kind: CustomDefKind {
        get() {
            return _kind
        }
    }
    public prop identifier: String {
        get() {
            return _identifier
        }
    }
    public prop identifierWithoutPrefix: String {
        get() {
            return _identifier.removePrefix(GLOBAL_VAL_PREFIX)
        }
    }
    public prop srcCodeIdentifier: String {
        get() {
            return _srcCodeIdentifier
        }
    }
    public prop packageName: String {
        get() {
            return _packageName
        }
    }
    internal func calculateHashCode(): Int64 {
        return identifier.hashCode()
    }
    internal init(kind: CustomDefKind, identifier: String, srcName: String, pkgName: String) {
        this._kind = kind
        this._identifier = identifier
        this._srcCodeIdentifier = srcName
        this._packageName = pkgName
    }
    public operator func==(other: CustomTypeDef): Bool {
        return this.kind == other.kind &&
            this.identifier == other.identifier &&
            this.srcCodeIdentifier == other.srcCodeIdentifier &&
            this.packageName == other.packageName
    }
}