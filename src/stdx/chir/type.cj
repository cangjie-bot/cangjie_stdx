/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

import std.collection.*
import std.deriving.*
import std.sort.*

/**
 * @brief Enumeration of all type kinds in the type system.
 * 
 * This enum represents the different categories of types that can exist
 * in the Cangjie type system, including primitive types, composite types,
 * and special types.
 */
@Derive[Equatable]
internal enum TypeKind <: ToString {
    INVALID |
    INT8 | INT16 | INT32 | INT64 | INT_NATIVE |
    UINT8 | UINT16 | UINT32 | UINT64 | UINT_NATIVE |
    FLOAT16 | FLOAT32 | FLOAT64 |
    BOOL | RUNE | UNIT | NOTHING |
    CLASS | ENUM | STRUCT | TUPLE |
    CPOINTER | CSTRING | RAW_ARRAY | VARRAY | GENERIC | REF | BOX | THIS | FUNC

    internal func isCType(): Bool {
        match (this) {
            case INT8 | INT16 | INT32 | INT64 | INT_NATIVE |
                UINT8 | UINT16 | UINT32 | UINT64 | UINT_NATIVE |
                FLOAT16 | FLOAT32 | FLOAT64 |
                BOOL | RUNE | UNIT | CPOINTER | CSTRING => true
            case _ => false
        }
    }
    /**
     * @brief Converts the type kind to its string representation.
     * @return A string representation of the type kind.
     */
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

/**
 * @brief Abstract base class representing a type in the type system.
 * 
 * This class provides the foundation for all types in Cangjie, including
 * primitive types, composite types, and special types. It implements
 * equality comparison, hashing, and string conversion.
 */
sealed abstract class Type <: ToString & Hashable & Equatable<Type> {
    internal let _kind: TypeKind
    internal var _typeArgs: ArrayList<Type>
    internal var _hashCode: Int64 = 0

    /**
     * @brief Checks if this type is equal to another type.
     * @param other The type to compare with.
     * @return true if the types have the same kind and type arguments, false otherwise.
     */
    public open operator func==(other: Type): Bool {
        return isSameTypeKindAndArgs(other)
    }

    /**
     * @brief Gets the type arguments of this type.
     * @return An array of type arguments.
     */
    public prop typeArgs: Array<Type> {
        get() {
            return _typeArgs.toArray()
        }
    }

    /**
     * @brief Gets the hash code of this type.
     * @return The hash code as an Int64.
     */
    public func hashCode(): Int64 {
        return _hashCode
    }

    /**
     * @brief Prints the string representation of this type to standard output.
     */
    public func dump() {
        println(toString())
    }

    /**
     * @brief Converts this type to its string representation.
     * @return A string representation of the type.
     */
    public open func toString(): String {
        return _kind.toString()
    }
    
    /**
     * @brief Checks if this type is a floating-point type.
     * @return true if the type is Float16, Float32, or Float64, false otherwise.
     */
    public func isFloatType(): Bool {
        return _kind == TypeKind.FLOAT16 || _kind == TypeKind.FLOAT32 || _kind == TypeKind.FLOAT64
    }

    /**
     * @brief Checks if this type is an integer type (signed or unsigned).
     * @return true if the type is any integer type, false otherwise.
     */
    public func isIntType(): Bool {
        return _kind == TypeKind.INT8 || _kind == TypeKind.INT16 || _kind == TypeKind.INT32 || _kind == TypeKind.INT64 ||
            _kind == TypeKind.UINT8 || _kind == TypeKind.UINT16 || _kind == TypeKind.UINT32 || _kind == TypeKind.UINT64 ||
            _kind == TypeKind.INT_NATIVE || _kind == TypeKind.UINT_NATIVE
    }

    /**
     * @brief Checks if this type is a signed integer type.
     * @return true if the type is a signed integer type, false otherwise.
     */
    public func isSignedIntType(): Bool {
        return _kind == TypeKind.INT8 || _kind == TypeKind.INT16 || _kind == TypeKind.INT32 || _kind == TypeKind.INT64 ||
            _kind == TypeKind.INT_NATIVE
    }

    /**
     * @brief Checks if this type is an unsigned integer type.
     * @return true if the type is an unsigned integer type, false otherwise.
     */
    public func isUnsignedIntType(): Bool {
        return _kind == TypeKind.UINT8 || _kind == TypeKind.UINT16 || _kind == TypeKind.UINT32 || _kind == TypeKind.UINT64 ||
            _kind == TypeKind.UINT_NATIVE
    }

    /**
     * @brief Checks if this type is a numeric type (integer or floating-point).
     * @return true if the type is numeric, false otherwise.
     */
    public func isNumericType(): Bool {
        return isFloatType() || isIntType()
    }

    /**
     * @brief Checks if this type is the boolean type.
     * @return true if the type is Bool, false otherwise.
     */
    public func isBoolType(): Bool {
        return _kind == TypeKind.BOOL
    }

    /**
     * @brief Checks if this type is the rune type.
     * @return true if the type is Rune, false otherwise.
     */
    public func isRuneType(): Bool {
        return _kind == TypeKind.RUNE
    }

    /**
     * @brief Checks if this type is the unit type.
     * @return true if the type is Unit, false otherwise.
     */
    public func isUnitType(): Bool {
        return _kind == TypeKind.UNIT
    }

    /**
     * @brief Checks if this type is the nothing type.
     * @return true if the type is Nothing, false otherwise.
     */
    public func isNothingType(): Bool {
        return _kind == TypeKind.NOTHING
    }

    /**
     * @brief Checks if this type is a built-in type.
     * @return true if the type is a built-in type, false otherwise.
     */
    public func isBuiltinType(): Bool {
        return _kind == TypeKind.INT8 || _kind == TypeKind.INT16 || _kind == TypeKind.INT32 || _kind == TypeKind.INT64 ||
            _kind == TypeKind.INT_NATIVE || _kind == TypeKind.UINT8 || _kind == TypeKind.UINT16 || _kind == TypeKind.UINT32 ||
            _kind == TypeKind.UINT64 || _kind == TypeKind.UINT_NATIVE || _kind == TypeKind.FLOAT16 || _kind == TypeKind.FLOAT32 ||
            _kind == TypeKind.FLOAT64 || _kind == TypeKind.BOOL || _kind == TypeKind.RUNE || _kind == TypeKind.UNIT ||
            _kind == TypeKind.NOTHING || _kind == TypeKind.RAW_ARRAY || _kind == TypeKind.VARRAY || _kind == TypeKind.CPOINTER ||
            _kind == TypeKind.CSTRING
    }

    /**
     * @brief Checks if this type is a reference type.
     * @return true if the type is a reference type, false otherwise.
     */
    public func isRefType(): Bool {
        return _kind == TypeKind.REF
    }

    /**
     * @brief Checks if this type is a primitive type.
     * @return true if the type is primitive (int, float, bool, rune, unit, or nothing), false otherwise.
     */
    public func isPrimitiveType(): Bool {
        return isIntType() || isFloatType() || isBoolType() || isRuneType() || isUnitType() || isNothingType()
    }

    /**
     * @brief Strips all reference wrappers from this type.
     * 
     * Recursively removes all Ref type wrappers until a non-reference type is reached.
     * @return The base type after removing all reference wrappers.
     */
    public func stripAllRefs(): Type {
        var baseTy: Type = this
        while (baseTy.isRefType()) {
            baseTy = (baseTy as RefType).getOrThrow().baseType
        }
        return baseTy
    }

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

    internal func isSameTypeKindAndArgs(other: Type): Bool {
        return this._kind == other._kind && this._typeArgs == other._typeArgs
    }

    internal func isSameTypeKindAs(other: Type): Bool {
        return this._kind == other._kind
    }
}

/**
 * @brief Abstract base class for built-in types.
 * 
 * This class represents types that are built into the language,
 * such as primitive numeric types, boolean, unit, etc.
 */
sealed abstract class BuiltinType <: Type & Equatable<BuiltinType> {
    /**
     * @brief Checks if this built-in type is equal to another built-in type.
     * @param other The built-in type to compare with.
     * @return true if the types are equal, false otherwise.
     */
    public operator func==(other: BuiltinType): Bool {
        return isSameTypeKindAndArgs(other)
    }

    internal init(kind: TypeKind) {
        super(kind)
    }

    internal init(kind: TypeKind, typeArgs: ArrayList<Type>) {
        super(kind, typeArgs)
    }
}

/**
 * @brief Represents the boolean type in the type system.
 * 
 * This is a singleton type representing the built-in boolean type.
 */
public class BoolType <: BuiltinType & Equatable<BoolType> {
    private static let _boolType = BoolType()

    /**
     * @brief Gets the singleton instance of BoolType.
     * @return The BoolType instance.
     */
    public static func get(): BoolType {
        return _boolType
    }

    /**
     * @brief Checks if this BoolType is equal to another BoolType.
     * @param _ The other BoolType to compare with (unused, always returns true).
     * @return Always returns true since all BoolType instances are equal.
     */
    public operator func==(_: BoolType): Bool {
        return true
    }

    private init() {
        super(TypeKind.BOOL)
        setHashCode()
    }
}

/**
 * @brief Represents the nothing type in the type system.
 * 
 * This type represents the bottom type, used for expressions that never return.
 */
public class NothingType <: BuiltinType & Equatable<NothingType> {
    private static let _nothingType = NothingType()

    /**
     * @brief Gets the singleton instance of NothingType.
     * @return The NothingType instance.
     */
    public static func get(): NothingType {
        return _nothingType
    }

    /**
     * @brief Checks if this NothingType is equal to another NothingType.
     * @param _ The other NothingType to compare with (unused, always returns true).
     * @return Always returns true since all NothingType instances are equal.
     */
    public operator func==(_: NothingType): Bool {
        return true
    }

    private init() {
        super(TypeKind.NOTHING)
        setHashCode()
    }
}

/**
 * @brief Abstract base class for numeric types.
 * 
 * This class represents types that are numeric, including both
 * integer and floating-point types.
 */
sealed abstract class NumericType <: BuiltinType & Equatable<NumericType> {
    /**
     * @brief Checks if this numeric type is equal to another numeric type.
     * @param other The numeric type to compare with.
     * @return true if the types are equal, false otherwise.
     */
    public operator func==(other: NumericType): Bool {
        return isSameTypeKindAndArgs(other)
    }

    internal init(kind: TypeKind) {
        super(kind)
    }
}

/**
 * @brief Represents floating-point types in the type system.
 * 
 * This class represents the three floating-point types: Float16, Float32, and Float64.
 */
public class FloatType <: NumericType & Equatable<FloatType> {
    private static let _float16Type = FloatType(TypeKind.FLOAT16)
    private static let _float32Type = FloatType(TypeKind.FLOAT32)
    private static let _float64Type = FloatType(TypeKind.FLOAT64)

    /**
     * @brief Gets the Float16 type instance.
     * @return The Float16 type.
     */
    public static func getF16(): FloatType {
        return _float16Type
    }

    /**
     * @brief Gets the Float32 type instance.
     * @return The Float32 type.
     */
    public static func getF32(): FloatType {
        return _float32Type
    }

    /**
     * @brief Gets the Float64 type instance.
     * @return The Float64 type.
     */
    public static func getF64(): FloatType {
        return _float64Type
    }

    /**
     * @brief Checks if this FloatType is equal to another FloatType.
     * @param other The FloatType to compare with.
     * @return true if the types are equal, false otherwise.
     */
    public operator func==(other: FloatType): Bool {
        return isSameTypeKindAndArgs(other)
    }

    private init(kind: TypeKind) {
        super(kind)
        setHashCode()
        if (!isFloatType()) {
            throw Exception("Create FloatType with wrong kind: " + kind.toString())
        }
    }
}

/**
 * @brief Represents integer types in the type system.
 * 
 * This class represents both signed and unsigned integer types of various sizes.
 */
public class IntType <: NumericType & Equatable<IntType> {
    private static let _int8Type = IntType(TypeKind.INT8)
    private static let _int16Type = IntType(TypeKind.INT16)
    private static let _int32Type = IntType(TypeKind.INT32)
    private static let _int64Type = IntType(TypeKind.INT64)
    private static let _intNativeType = IntType(TypeKind.INT_NATIVE)
    private static let _uint8Type = IntType(TypeKind.UINT8)
    private static let _uint16Type = IntType(TypeKind.UINT16)
    private static let _uint32Type = IntType(TypeKind.UINT32)
    private static let _uint64Type = IntType(TypeKind.UINT64)
    private static let _uintNativeType = IntType(TypeKind.UINT_NATIVE)

    /**
     * @brief Gets the Int8 type instance.
     * @return The Int8 type.
     */
    public static func getI8(): IntType {
        return _int8Type
    }

    /**
     * @brief Gets the Int16 type instance.
     * @return The Int16 type.
     */
    public static func getI16(): IntType {
        return _int16Type
    }

    /**
     * @brief Gets the Int32 type instance.
     * @return The Int32 type.
     */
    public static func getI32(): IntType {
        return _int32Type
    }

    /**
     * @brief Gets the Int64 type instance.
     * @return The Int64 type.
     */
    public static func getI64(): IntType {
        return _int64Type
    }

    /**
     * @brief Gets the IntNative type instance.
     * @return The IntNative type.
     */
    public static func getINative(): IntType {
        return _intNativeType
    }

    /**
     * @brief Gets the UInt8 type instance.
     * @return The UInt8 type.
     */
    public static func getU8(): IntType {
        return _uint8Type
    }

    /**
     * @brief Gets the UInt16 type instance.
     * @return The UInt16 type.
     */
    public static func getU16(): IntType {
        return _uint16Type
    }

    /**
     * @brief Gets the UInt32 type instance.
     * @return The UInt32 type.
     */
    public static func getU32(): IntType {
        return _uint32Type
    }

    /**
     * @brief Gets the UInt64 type instance.
     * @return The UInt64 type.
     */
    public static func getU64(): IntType {
        return _uint64Type
    }

    /**
     * @brief Gets the UIntNative type instance.
     * @return The UIntNative type.
     */
    public static func getUNative(): IntType {
        return _uintNativeType
    }

    /**
     * @brief Checks if this IntType is equal to another IntType.
     * @param other The IntType to compare with.
     * @return true if the types are equal, false otherwise.
     */
    public operator func==(other: IntType): Bool {
        return isSameTypeKindAndArgs(other)
    }

    /**
     * @brief Checks if this integer type is signed.
     * @return true if the type is signed, false if it is unsigned.
     */
    public func isSigned(): Bool {
        return _kind == TypeKind.INT8 || _kind == TypeKind.INT16 || _kind == TypeKind.INT32 || _kind == TypeKind.INT64 ||
            _kind == TypeKind.INT_NATIVE
    }

    private init(kind: TypeKind) {
        super(kind)
        setHashCode()
        if (!isIntType()) {
            throw Exception("Create IntType with wrong kind: " + _kind.toString())
        }
    }
}

/**
 * @brief Represents the rune type in the type system.
 * 
 * This type represents a character type.
 */
public class RuneType <: BuiltinType & Equatable<RuneType> {
    private static let _runeType = RuneType()

    /**
     * @brief Gets the singleton instance of RuneType.
     * @return The RuneType instance.
     */
    public static func get(): RuneType {
        return _runeType
    }

    /**
     * @brief Checks if this RuneType is equal to another RuneType.
     * @param _ The other RuneType to compare with (unused, always returns true).
     * @return Always returns true since all RuneType instances are equal.
     */
    public operator func==(_: RuneType): Bool {
        return true
    }

    private init() {
        super(TypeKind.RUNE)
        setHashCode()
    }
}

/**
 * @brief Represents the unit type in the type system.
 * 
 * This type represents the absence of a meaningful value, similar to void in C.
 */
public class UnitType <: BuiltinType & Equatable<UnitType> {
    private static let _unitType = UnitType()

    /**
     * @brief Gets the singleton instance of UnitType.
     * @return The UnitType instance.
     */
    public static func get(): UnitType {
        return _unitType
    }

    /**
     * @brief Checks if this UnitType is equal to another UnitType.
     * @param _ The other UnitType to compare with (unused, always returns true).
     * @return Always returns true since all UnitType instances are equal.
     */
    public operator func==(_: UnitType): Bool {
        return true
    }

    private init() {
        super(TypeKind.UNIT)
        setHashCode()
    }
}

internal class InvalidType <: Type & Equatable<InvalidType> {
    private static let _invalidType = InvalidType()

    public static func get(): InvalidType {
        return _invalidType
    }

    private init() {
        super(TypeKind.INVALID)
    }

    public operator func==(_: InvalidType): Bool {
        return true
    }
}

/**
 * @brief Represents a reference type in the type system.
 * 
 * This type wraps another type to represent a reference to that type.
 * The class maintains a cache of all reference types to ensure uniqueness.
 */
public class RefType <: Type & Equatable<RefType> {
    private static var _allRefTypes = HashMap<RefType, RefType>()

    /**
     * @brief Gets or creates a RefType for the given base type.
     * 
     * This method ensures that only one RefType instance exists for each base type.
     * @param baseType The base type to create a reference to.
     * @return The RefType instance for the given base type.
     */
    public static func get(baseType: Type): RefType {
        let temp = RefType(baseType)
        let res = _allRefTypes.get(temp)
        if (res.isNone()) {
            _allRefTypes.add(temp, temp)
            return temp
        }
        return res.getOrThrow()
    }

    /**
     * @brief Gets the base type that this reference type refers to.
     * @return The base type.
     */
    public prop baseType: Type {
        get() {
            return _typeArgs[0]
        }
    }

    /**
     * @brief Converts this RefType to its string representation.
     * @return A string representation of the reference type (base type followed by '&').
     */
    public func toString(): String {
        return baseType.toString() + "&"
    }

    /**
     * @brief Checks if this RefType is equal to another RefType.
     * @param other The RefType to compare with.
     * @return true if the types are equal, false otherwise.
     */
    public operator func==(other: RefType): Bool {
        return isSameTypeKindAndArgs(other)
    }

    private init(baseType: Type) {
        super(TypeKind.REF, ArrayList<Type>([baseType]))
        setHashCode()
    }
}