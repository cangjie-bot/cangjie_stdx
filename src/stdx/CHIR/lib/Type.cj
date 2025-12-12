/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib
import std.sort.*

import std.deriving.*

@Derive[Equatable]
protected enum TypeKind <: ToString {
    INVALID |
    INT8 | INT16 | INT32 | INT64 | INT_NATIVE |
    UINT8 | UINT16 | UINT32 | UINT64 | UINT_NATIVE |
    FLOAT16 | FLOAT32 | FLOAT64 |
    BOOL | RUNE | UNIT | NOTHING |
    CLASS | ENUM | STRUCT | TUPLE |
    CPOINTER | CSTRING | RAW_ARRAY | VARRAY | GENERIC | REF | BOX | THIS | FUNC

    public func toString(): String {
        match (this) {
            case INVALID =>     "Invalid"
            case INT8 =>        "Int8"
            case INT16 =>       "Int16"
            case INT32 =>       "Int32"
            case INT64 =>       "Int64"
            case INT_NATIVE =>  "IntNative"
            case UINT8 =>       "UInt8"
            case UINT16 =>      "UInt16"
            case UINT32 =>      "UInt32"
            case UINT64 =>      "UInt64"
            case UINT_NATIVE => "UIntNative"
            case FLOAT16 =>     "Float16"
            case FLOAT32 =>     "Float32"
            case FLOAT64 =>     "Float64"
            case BOOL =>        "Bool"
            case RUNE =>        "Rune"
            case UNIT =>        "Unit"
            case NOTHING =>     "Nothing"
            case CLASS =>       "Class"
            case ENUM =>        "Enum"
            case STRUCT =>      "Struct"
            case TUPLE =>       "Tuple"
            case CPOINTER =>    "CPointer"
            case CSTRING =>     "CString"
            case RAW_ARRAY =>   "RawArray"
            case VARRAY =>      "VArray"
            case GENERIC =>     "Generic"
            case REF =>         "Ref"
            case BOX =>         "Box"
            case THIS =>        "This"
            case FUNC =>        "Func"
        }
    }
}

sealed abstract class Type <: ToString & Hashable & Equatable<Type> {
    // member var
    private let _kind: TypeKind
    private var _typeArgs: ArrayList<Type>
    private var _hashCode: Int64 = 0

    protected prop kind: TypeKind {
        get() {
            return _kind
        }
    }
    public prop typeArgs: ArrayList<Type> {
        get() {
            return _typeArgs
        }
    }
    public func hashCode(): Int64 {
        _hashCode
    }
    
    // public method
    public open func toString(): String {
        kind.toString()
    }
    public func isSameTypeKind(other: Type): Bool {
        return this.kind == other.kind
    }
    public open operator func==(other: Type): Bool {
        return this._hashCode == other._hashCode && this.kind == other.kind && this.typeArgs == other.typeArgs
    }
    public func IsFloatType(): Bool {
        return kind == TypeKind.FLOAT16 || kind == TypeKind.FLOAT32 || kind == TypeKind.FLOAT64
    }
    public func IsIntType(): Bool {
        return kind == TypeKind.INT8 || kind == TypeKind.INT16 || kind == TypeKind.INT32 || kind == TypeKind.INT64 ||
            kind == TypeKind.UINT8 || kind == TypeKind.UINT16 || kind == TypeKind.UINT32 || kind == TypeKind.UINT64 ||
            kind == TypeKind.INT_NATIVE || kind == TypeKind.UINT_NATIVE
    }
    public func IsNumericType(): Bool {
        return IsFloatType() || IsIntType()
    }
    public func IsBoolType(): Bool {
        return kind == TypeKind.BOOL
    }
    public func IsRuneType(): Bool {
        return kind == TypeKind.RUNE
    }
    public func IsUnitType(): Bool {
        return kind == TypeKind.UNIT
    }
    public func IsNothingType(): Bool {
        return kind == TypeKind.NOTHING
    }
    public func IsClassType(): Bool {
        return kind == TypeKind.CLASS
    }
    public func IsEnumType(): Bool {
        return kind == TypeKind.ENUM
    }
    public func IsStructType(): Bool {
        return kind == TypeKind.STRUCT
    }
    public func IsTupleType(): Bool {
        return kind == TypeKind.TUPLE
    }
    public func IsCPointerType(): Bool {
        return kind == TypeKind.CPOINTER
    }
    public func IsCStringType(): Bool {
        return kind == TypeKind.CSTRING
    }
    public func IsRawArrayType(): Bool {
        return kind == TypeKind.RAW_ARRAY
    }
    public func IsVArrayType(): Bool {
        return kind == TypeKind.VARRAY
    }
    public func IsGenericType(): Bool {
        return kind == TypeKind.GENERIC
    }
    public func IsRefType(): Bool {
        return kind == TypeKind.REF
    }
    public func IsBoxType(): Bool {
        return kind == TypeKind.BOX
    }
    public func IsThisType(): Bool {
        return kind == TypeKind.THIS
    }
    public func IsFuncType(): Bool {
        return kind == TypeKind.FUNC
    }
    public func IsPrimitiveType(): Bool {
        return IsIntType() || IsFloatType() || IsBoolType() ||
            IsRuneType() || IsUnitType() || IsNothingType()
    }
    public func IsValueType(): Bool {
        return IsPrimitiveType() || IsEnumType() || IsTupleType() ||
            IsStructType() || IsVArrayType() || IsCPointerType() ||
            IsCStringType() || IsFuncType()
    }

    public func stripAllRefs(): Type {
        var baseTy: Type = this
        while (baseTy.IsRefType()) {
            baseTy = (baseTy as RefType).getOrThrow().getBaseType()
        }
        return baseTy
    }

    // internal method
    internal init(kind: TypeKind) {
        this._kind = kind
        this._typeArgs = ArrayList<Type>()
    }
    internal init(kind: TypeKind, args: ArrayList<Type>) {
        this._kind = kind
        this._typeArgs = args
    }
    internal func setHashCode(): Unit {
        _hashCode = toString().hashCode()
    }
}

public class BoxType <: Type & Equatable<BoxType> {
    public func toString(): String {
        return "Box<" + getBaseType().toString() + ">"
    }
    public func getBaseType(): Type {
        return typeArgs[0]
    }
    internal init(baseType: Type) {
        super(TypeKind.BOX, ArrayList<Type>([baseType]))
        setHashCode()
    }
    public operator func==(other: BoxType): Bool {
        return (this as Type) == (other as Type)
    }
}

sealed abstract class BuiltinType <: Type & Equatable<BuiltinType> {
    internal init(kind: TypeKind) {
        super(kind)
    }
    internal init(kind: TypeKind, typeArgs: ArrayList<Type>) {
        super(kind, typeArgs)
    }
    public operator func==(other: BuiltinType): Bool {
        return (this as Type) == (other as Type)
    }
}

public class BoolType <: BuiltinType & Equatable<BoolType> {
    internal init() {
        super(TypeKind.BOOL)
        setHashCode()
    }
    public operator func==(_: BoolType): Bool {
        return true
    }
}

public class CPointerType <: BuiltinType & Equatable<CPointerType> {
    public func toString(): String {
        return "CPointer<" + getElementType().toString() + ">"
    }
    public func getElementType(): Type {
        return typeArgs[0]
    }
    internal init(elementType: Type) {
        super(TypeKind.CPOINTER, ArrayList<Type>([elementType]))
        setHashCode()
    }
    public operator func==(other: CPointerType): Bool {
        return this.getElementType() == other.getElementType()
    }
}

public class CStringType <: BuiltinType & Equatable<CStringType> {
    internal init() {
        super(TypeKind.CSTRING)
        setHashCode()
    }
    public operator func==(_: CStringType): Bool {
        return true
    }
}

public class NothingType <: BuiltinType & Equatable<NothingType> {
    internal init() {
        super(TypeKind.NOTHING)
        setHashCode()
    }
    public operator func==(_: NothingType): Bool {
        return true
    }
}

sealed abstract class NumericType <: BuiltinType & Equatable<NumericType> {
    internal init(kind: TypeKind) {
        super(kind)
    }
    public operator func==(other: NumericType): Bool {
        return this.kind == other.kind
    }
}

public class FloatType <: NumericType & Equatable<FloatType> {
    internal init(kind: TypeKind) {
        super(kind)
        setHashCode()
        if (!IsFloatType()) {
            throw Exception("Create FloatType with wrong kind: " + kind.toString())
        }
    }
    public operator func==(other: FloatType): Bool {
        return this.kind == other.kind
    }
}

public class IntType <: NumericType & Equatable<IntType> {
    internal init(kind: TypeKind) {
        super(kind)
        setHashCode()
        if (!IsIntType()) {
            throw Exception("Create IntType with wrong kind: " + kind.toString())
        }
    }
    public func isSigned(): Bool {
        return kind == TypeKind.INT8 || kind == TypeKind.INT16 || kind == TypeKind.INT32 || kind == TypeKind.INT64 ||
            kind == TypeKind.INT_NATIVE
    }
    public operator func==(other: IntType): Bool {
        return this.kind == other.kind
    }
}

public class RawArrayType <: BuiltinType & Equatable<RawArrayType> {
    public func toString(): String {
        return "RawArray<" + getElementType().toString() + ">"
    }
    public func getElementType(): Type {
        return typeArgs[0]
    }
    internal init(elementType: Type) {
        super(TypeKind.RAW_ARRAY, ArrayList<Type>([elementType]))
        setHashCode()
    }
    public operator func==(other: RawArrayType): Bool {
        return this.getElementType() == other.getElementType()
    }
}

public class RuneType <: BuiltinType & Equatable<RuneType> {
    internal init() {
        super(TypeKind.RUNE)
        setHashCode()
    }
    public operator func==(_: RuneType): Bool {
        return true
    }
}

public class UnitType <: BuiltinType & Equatable<UnitType> {
    internal init() {
        super(TypeKind.UNIT)
        setHashCode()
    }
    public operator func==(_: UnitType): Bool {
        return true
    }
}

public class VArrayType <: BuiltinType & Equatable<VArrayType> {
    private let _size: Int64

    public func toString(): String {
        return "VArray<" + getElementType().toString() + "$" + size.toString() + ">"
    }
    public func getElementType(): Type {
        return typeArgs[0]
    }
    public prop size: Int64 {
        get() {
            return _size
        }
    }
    internal init(elementType: Type, size: Int64) {
        super(TypeKind.VARRAY, ArrayList<Type>([elementType]))
        this._size = size
        setHashCode()
    }
    public operator func==(other: VArrayType): Bool {
        return this.getElementType() == other.getElementType() && this.size == other.size
    }
}

private func typeArgsToString(start: String, typeArgs: ArrayList<Type>, end: String): String {
    var res = String()
    for (ty in typeArgs) {
        res += ty.toString()
        res += ", "
    }
    if (res.isEmpty()) {
        return res
    }
    return start + res.removeSuffix(", ") + end
}

sealed abstract class CustomType <: Type & Equatable<CustomType> {
    private var _def: CustomTypeDef

    public prop def: CustomTypeDef {
        get() {
            return _def
        }
    }

    public func toString(): String {
        return this.kind.toString() + "-" +
            _def.identifierWithoutPrefix + typeArgsToString("<", getInstantiatedTypeArgs(), ">")
    }
    public func getInstantiatedTypeArgs(): ArrayList<Type> {
        return typeArgs
    }
    internal init(kind: TypeKind, def: CustomTypeDef, genericTypeParams: ArrayList<Type>) {
        super(kind, genericTypeParams)
        this._def = def
    }
    public operator func==(other: CustomType): Bool {
        return this.kind == other.kind &&
            this._def == other._def &&
            this.typeArgs == other.typeArgs
    }
}

public class ClassType <: CustomType & Equatable<ClassType> {
    internal init(def: ClassDef, genericTypeParams: ArrayList<Type>) {
        super(TypeKind.CLASS, def, genericTypeParams)
        setHashCode()
    }
    public operator func==(other: ClassType): Bool {
        return this.def == other.def &&
            this.typeArgs == other.typeArgs
    }
}

public class StructType <: CustomType & Equatable<StructType> {
    internal init(def: StructDef, genericTypeParams: ArrayList<Type>) {
        super(TypeKind.STRUCT, def, genericTypeParams)
        setHashCode()
    }
    public operator func==(other: StructType): Bool {
        return this.def == other.def &&
            this.typeArgs == other.typeArgs
    }
}

public class EnumType <: CustomType & Equatable<EnumType> {
    internal init(def: EnumDef, genericTypeParams: ArrayList<Type>) {
        super(TypeKind.ENUM, def, genericTypeParams)
        setHashCode()
    }
    public operator func==(other: EnumType): Bool {
        return this.def == other.def &&
            this.typeArgs == other.typeArgs
    }
}

public class FuncType <: Type & Equatable<FuncType> {
    private let _hasVarArg: Bool
    private let _isCFunc: Bool

    public prop hasVarArg: Bool {
        get() {
            return _hasVarArg
        }
    }
    public prop isCFunc: Bool {
        get() {
            return _isCFunc
        }
    }
    public prop paramTypes: ArrayList<Type> {
        get() {
            return typeArgs[0..(typeArgs.size - 1)]
        }
    }
    public prop returnType: Type {
        get() {
            return typeArgs.last.getOrThrow()
        }
    }
    public func toString(): String {
        return typeArgsToString("(", paramTypes, ")") + " -> " + returnType.toString()
    }
    internal init(paramTypes: ArrayList<Type>, retType: Type, varArg: Bool, cFunc: Bool) {
        super(TypeKind.FUNC, paramTypes)
        this._hasVarArg = varArg
        this._isCFunc = cFunc
        typeArgs.add(retType)
        setHashCode()
    }
    public operator func==(other: FuncType): Bool {
        return this.paramTypes == other.paramTypes &&
            this.returnType == other.returnType &&
            this._hasVarArg == other._hasVarArg &&
            this._isCFunc == other._isCFunc
    }
}

public class GenericType <: Type & Equatable<GenericType> {
    private let _identifier: String
    private let _srcCodeIdentifier: String
    private var _upperBounds: ArrayList<Type> = ArrayList<Type>()

    public prop identifier: String {
        get() {
            return _identifier
        }
    }
    public prop srcCodeIdentifier: String {
        get() {
            return _srcCodeIdentifier
        }
    }
    public mut prop upperBounds: ArrayList<Type> {
        get() {
            return _upperBounds
        }
        set(v) {
            for (bound in v) {
                if (bound.stripAllRefs().IsValueType()) {
                    throw IllegalArgumentException("Generic type upper bound should NOT be value type!")
                }
            }
            _upperBounds = v
            sort(_upperBounds,
                by: { l, r =>
                    let lstring = l.toString()
                    let rstring = r.toString()
                    if (lstring == rstring) {
                        return Ordering.EQ
                    } else if (lstring < rstring) {
                        return Ordering.LT
                    } else {
                        return Ordering.GT
                    }
                },
                stable: true,
                descending: false
            )
        }
    }
    public func toString(): String {
        this.kind.toString() + "-" + this._identifier
    }
    internal init(identifier: String, srcCodeIdentifier: String) {
        super(TypeKind.GENERIC)
        this._identifier = identifier
        this._srcCodeIdentifier = srcCodeIdentifier
        setHashCode()
    }
    public operator func==(other: GenericType): Bool {
        return this._identifier == other.identifier &&
            this._srcCodeIdentifier == other.srcCodeIdentifier &&
            this._upperBounds == other.upperBounds
    }
}

internal class InvalidType <: Type & Equatable<InvalidType> {
    internal init() {
        super(TypeKind.INVALID)
    }
    public operator func==(_: InvalidType): Bool {
        return true
    }
}

public class RefType <: Type & Equatable<RefType> {
    public func getBaseType(): Type {
        return typeArgs[0]
    }
    internal init(baseType: Type) {
        super(TypeKind.REF, ArrayList<Type>([baseType]))
        setHashCode()
    }
    public operator func==(other: RefType): Bool {
        return this.getBaseType() == other.getBaseType()
    }
}

public class ThisType <: Type & Equatable<ThisType> {
    internal init() {
        super(TypeKind.THIS)
        setHashCode()
    }
    public operator func==(_: ThisType): Bool {
        return true
    }
}

public class TupleType <: Type & Equatable<TupleType> {
    public func toString(): String {
        this.kind.toString() + typeArgsToString("(", getElementTypes(), ")")
    }
    public func getElementTypes(): ArrayList<Type> {
        return typeArgs
    }
    internal init(elementType: ArrayList<Type>) {
        super(TypeKind.TUPLE, elementType)
        setHashCode()
    }
    public operator func==(other: TupleType): Bool {
        return this.getElementTypes() == other.getElementTypes()
    }
}
