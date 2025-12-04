/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

protected enum TypeKind <: ToString & Equatable<TypeKind> {
    INVALID |
    INT8 | INT16 | INT32 | INT64 | INT_NATIVE |
    UINT8 | UINT16 | UINT32 | UINT64 | UINT_NATIVE |
    FLOAT16 | FLOAT32 | FLOAT64 |
    BOOL | RUNE | UNIT | NOTHING |
    CLASS | ENUM | STRUCT | TUPLE |
    CPOINTER | CSTRING | RAW_ARRAY | VARRAY | GENERIC | REF | BOX | THIS | FUNC | VOID

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
            case VOID =>        "Void"
        }
    }

    public operator func==(other: TypeKind): Bool {
        match ((this, other)) {
            case (INT8, INT8) => true
            case (INT16, INT16) => true
            case (INT32, INT32) => true
            case (INT64, INT64) => true
            case (INT_NATIVE, INT_NATIVE) => true
            case (UINT8, UINT8) => true
            case (UINT16, UINT16) => true
            case (UINT32, UINT32) => true
            case (UINT64, UINT64) => true
            case (UINT_NATIVE, UINT_NATIVE) => true
            case (FLOAT16, FLOAT16) => true
            case (FLOAT32, FLOAT32) => true
            case (FLOAT64, FLOAT64) => true
            case (BOOL, BOOL) => true
            case (RUNE, RUNE) => true
            case (UNIT, UNIT) => true
            case (NOTHING, NOTHING) => true
            case (CLASS, CLASS) => true
            case (ENUM, ENUM) => true
            case (STRUCT, STRUCT) => true
            case (TUPLE, TUPLE) => true
            case (CPOINTER, CPOINTER) => true
            case (CSTRING, CSTRING) => true
            case (RAW_ARRAY, RAW_ARRAY) => true
            case (VARRAY, VARRAY) => true
            case (GENERIC, GENERIC) => true
            case (REF, REF) => true
            case (BOX, BOX) => true
            case (THIS, THIS) => true
            case (FUNC, FUNC) => true
            case _ => false
        }
    }
}

sealed abstract class Type <: ToString & Equatable<Type> {
    // member var
    internal let kind: TypeKind
    internal var typeArgs: ArrayList<Type>
    private var _hashCode: Int64 = 0

    // prop
    internal prop hashCode: Int64 {
        get() {
            _hashCode
        }
    }
    
    // public method
    public open func toString(): String {
        kind.toString()
    }
    public func isSameTypeKind(other: Type): Bool {
        return this.kind == other.kind
    }
    public operator func==(other: Type): Bool {
        return this._hashCode == other._hashCode
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

    // internal method
    internal init(kind: TypeKind) {
        this.kind = kind
        this.typeArgs = ArrayList<Type>()
    }
    internal init(kind: TypeKind, args: ArrayList<Type>) {
        this.kind = kind
        this.typeArgs = args
    }
    internal func setHashCode(): Unit {
        _hashCode = toString().hashCode()
    }
}

public class BoxType <: Type {
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
}

sealed abstract class BuiltinType <: Type {
    internal init(kind: TypeKind) {
        super(kind)
    }
    internal init(kind: TypeKind, typeArgs: ArrayList<Type>) {
        super(kind, typeArgs)
    }
}

public class BoolType <: BuiltinType {
    internal init() {
        super(TypeKind.BOOL)
        setHashCode()
    }
}

public class CPointerType <: BuiltinType {
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
}

public class CStringType <: BuiltinType {
    internal init() {
        super(TypeKind.CSTRING)
        setHashCode()
    }
}

public class NothingType <: BuiltinType {
    internal init() {
        super(TypeKind.NOTHING)
        setHashCode()
    }
}

sealed abstract class NumericType <: BuiltinType {
    internal init(kind: TypeKind) {
        super(kind)
    }
}

public class FloatType <: NumericType {
    internal init(kind: TypeKind) {
        super(kind)
        setHashCode()
        if (!IsFloatType()) {
            throw Exception("Create FloatType with wrong kind: " + kind.toString())
        }
    }
}

public class IntType <: NumericType {
    internal init(kind: TypeKind) {
        super(kind)
        setHashCode()
        if (!IsIntType()) {
            throw Exception("Create IntType with wrong kind: " + kind.toString())
        }
    }
}

public class RawArrayType <: BuiltinType {
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
}

public class RuneType <: BuiltinType {
    internal init() {
        super(TypeKind.RUNE)
        setHashCode()
    }
}

public class UnitType <: BuiltinType {
    internal init() {
        super(TypeKind.UNIT)
        setHashCode()
    }
}

public class VArrayType <: BuiltinType {
    private let size: Int64

    public func toString(): String {
        return "VArray<" + getElementType().toString() + "$" + size.toString() + ">"
    }
    public func getElementType(): Type {
        return typeArgs[0]
    }
    internal init(elementType: Type, size: Int64) {
        super(TypeKind.VARRAY, ArrayList<Type>([elementType]))
        this.size = size
        setHashCode()
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

sealed abstract class CustomType <: Type {
    internal var def: CustomTypeDef

    public func toString(): String {
        return this.kind.toString() + "-" +
            def.getIdentifierWithoutPrefix() + typeArgsToString("<", getInstantiatedTypeArgs(), ">")
    }
    public func getInstantiatedTypeArgs(): ArrayList<Type> {
        return typeArgs
    }
    internal init(kind: TypeKind, def: CustomTypeDef, genericTypeParams: ArrayList<Type>) {
        super(kind, genericTypeParams)
        this.def = def
    }
}

public class ClassType <: CustomType {
    internal init(def: ClassDef, genericTypeParams: ArrayList<Type>) {
        super(TypeKind.CLASS, def, genericTypeParams)
        setHashCode()
    }
}

public class StructType <: CustomType {
    internal init(def: StructDef, genericTypeParams: ArrayList<Type>) {
        super(TypeKind.STRUCT, def, genericTypeParams)
        setHashCode()
    }
}

public class EnumType <: CustomType {
    internal init(def: EnumDef, genericTypeParams: ArrayList<Type>) {
        super(TypeKind.ENUM, def, genericTypeParams)
        setHashCode()
    }
}

public class FuncType <: Type {
    private let hasVarArg: Bool
    private let isCFunc: Bool

    public func toString(): String {
        return typeArgsToString("(", getParamTypes(), ")") + " -> " + getReturnType().toString()
    }
    public func getParamTypes(): ArrayList<Type> {
        return typeArgs[0..(typeArgs.size - 1)]
    }
    public func getReturnType(): Type {
        return typeArgs.last.getOrThrow()
    }
    internal init(paramTypes: ArrayList<Type>, retType: Type, varArg: Bool, cFunc: Bool) {
        super(TypeKind.FUNC, paramTypes)
        typeArgs.add(retType)
        this.hasVarArg = varArg
        this.isCFunc = cFunc
        setHashCode()
    }
}

public class GenericType <: Type {
    private let identifier: String
    private let srcCodeIdentifier: String
    private var upperBounds: ArrayList<Type> = ArrayList<Type>()

    public func toString(): String {
        this.kind.toString() + "-" + this.identifier
    }
    internal init(identifier: String, srcCodeIdentifier: String) {
        super(TypeKind.GENERIC)
        this.identifier = identifier
        this.srcCodeIdentifier = srcCodeIdentifier
        setHashCode()
    }
}

internal class InvalidType <: Type {
    internal init() {
        super(TypeKind.INVALID)
    }
}

public class RefType <: Type {
    public func getBaseType(): Type {
        return typeArgs[0]
    }
    internal init(baseType: Type) {
        super(TypeKind.REF, ArrayList<Type>([baseType]))
        setHashCode()
    }
}

public class ThisType <: Type {
    internal init() {
        super(TypeKind.THIS)
        setHashCode()
    }
}

public class TupleType <: Type {
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
}

public class VoidType <: BuiltinType {
    internal init() {
        super(TypeKind.VOID)
        setHashCode()
    }
}