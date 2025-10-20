/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

public abstract class Type <: ToString & Hashable & Equatable<Type> {
    public Type(public let kind: TypeKind) {}

    public open func toString() {
        kind.toString()
    }
    public open func hashCode() { kind.hashCode() }
    public open operator func==(other: Type) { kind == other.kind }
}

public enum TypeKind <: Hashable & Equatable<TypeKind> & ToString {
    | Invalid
    | `Int64`
    | `UInt8`
    | `Bool`
    | Ref

    public func toInt(): UInt8 {
        match (this) {
            case Invalid => 0
            case `Int64` => 4
            case `UInt8` => 6
            case `Bool` => 15
            case Ref => 29
        }
    }
    public func toString(): String {
        match (this) {
            case Invalid => "Invalid"
            case `Int64` => "Int64"
            case `UInt8` => "UInt8"
            case `Bool` => "Bool"
            case Ref => "Ref"
        }
    }
    public func hashCode() { toInt().hashCode() }
    public operator func==(other: TypeKind) { toInt() == other.toInt() }
}

extend PackageFormat_CHIRTypeKind <: ToString {
    public func toTypeKind() {
        match (this) {
            case CHIRTypeKind_INVALID => TypeKind.Invalid
            case CHIRTypeKind_INT64 => TypeKind.`Int64`
            case CHIRTypeKind_UINT8 => TypeKind.`UInt8`
            case CHIRTypeKind_BOOLEAN => TypeKind.`Bool`
            case CHIRTypeKind_REFTYPE => TypeKind.Ref
            case _ => TypeKind.Invalid
        }
    }

    public func toString(): String {
        match (this) {
            case CHIRTypeKind_INVALID => "CHIRTypeKind_INVALID"
            case CHIRTypeKind_INT8 => "CHIRTypeKind_INT8"
            case CHIRTypeKind_INT16 => "CHIRTypeKind_INT16"
            case CHIRTypeKind_INT32 => "CHIRTypeKind_INT32"
            case CHIRTypeKind_INT64 => "CHIRTypeKind_INT64"
            case CHIRTypeKind_INT_NATIVE => "CHIRTypeKind_INT_NATIVE"
            case CHIRTypeKind_UINT8 => "CHIRTypeKind_UINT8"
            case CHIRTypeKind_UINT16 => "CHIRTypeKind_UINT16"
            case CHIRTypeKind_UINT32 => "CHIRTypeKind_UINT32"
            case CHIRTypeKind_UINT64 => "CHIRTypeKind_UINT64"
            case CHIRTypeKind_UINT_NATIVE => "CHIRTypeKind_UINT_NATIVE"
            case CHIRTypeKind_FLOAT16 => "CHIRTypeKind_FLOAT16"
            case CHIRTypeKind_FLOAT32 => "CHIRTypeKind_FLOAT32"
            case CHIRTypeKind_FLOAT64 => "CHIRTypeKind_FLOAT64"
            case CHIRTypeKind_RUNE => "CHIRTypeKind_RUNE"
            case CHIRTypeKind_BOOLEAN => "CHIRTypeKind_BOOLEAN"
            case CHIRTypeKind_UNIT => "CHIRTypeKind_UNIT"
            case CHIRTypeKind_NOTHING => "CHIRTypeKind_NOTHING"
            case CHIRTypeKind_VOID => "CHIRTypeKind_VOID"
            case CHIRTypeKind_TUPLE => "CHIRTypeKind_TUPLE"
            case CHIRTypeKind_STRUCT => "CHIRTypeKind_STRUCT"
            case CHIRTypeKind_ENUM => "CHIRTypeKind_ENUM"
            case CHIRTypeKind_FUNC => "CHIRTypeKind_FUNC"
            case CHIRTypeKind_CLASS => "CHIRTypeKind_CLASS"
            case CHIRTypeKind_RAWARRAY => "CHIRTypeKind_RAWARRAY"
            case CHIRTypeKind_VARRAY => "CHIRTypeKind_VARRAY"
            case CHIRTypeKind_C_POINTER => "CHIRTypeKind_C_POINTER"
            case CHIRTypeKind_C_STRING => "CHIRTypeKind_C_STRING"
            case CHIRTypeKind_GENERIC => "CHIRTypeKind_GENERIC"
            case CHIRTypeKind_REFTYPE => "CHIRTypeKind_REFTYPE"
            case CHIRTypeKind_BOXTYPE => "CHIRTypeKind_BOXTYPE"
            case CHIRTypeKind_THIS => "CHIRTypeKind_THIS"
        }
    }
}

public class PrimitiveType <: Type {
    public init(kind: TypeKind) {
        super(kind)
    }

    public func getTypeSuffix() {
        match (kind) {
            case TypeKind.`Int64` => "i64"
            case TypeKind.`UInt8` => "u8"
            case TypeKind.`Bool` => "b"
            case _ => ""
        }
    }
}

public class InvalidType <: Type {
    private init() {
        super(TypeKind.Invalid)
    }
    public override operator func==(other: Type) { other is InvalidType }
    public static let instance = InvalidType()
}

public class RefType <: Type {
    public RefType(public var base: Type, public var dims: UInt8) {
        super(TypeKind.Ref)
    }

    public override func hashCode() {
        ((Int64(kind.toInt()) << 8) & Int64(dims)) ^ base.hashCode()
    }
    public override func toString(): String {
        let s = StringBuilder()
        s.append(base.toString())
        for (i in 0..dims) {
            s.append('&')
        }
        s.toString()
    }
    public override operator func==(other: Type) {
        if (let o: RefType <- other) {
            base == o.base
        } else {
            false
        }
    }
}
