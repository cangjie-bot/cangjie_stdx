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
protected enum ValueKind <: ToString {
    GLOBAL_VAR | LOCAL_VAR | PARAMETER | FUNC | BLOCK | BLOCK_GROUP | LITERAL | MEMBER_VAR

    public func toString(): String {
        match (this) {
            case GLOBAL_VAR  => "GlobalVar"
            case LOCAL_VAR   => "LocalVar"
            case PARAMETER   => "Parameter"
            case FUNC        => "Func"
            case BLOCK       => "Block"
            case BLOCK_GROUP => "BlockGroup"
            case LITERAL     => "Literal"
            case MEMBER_VAR  => "MemberVar"
        }
    }
}

@Derive[Equatable]
protected enum FuncKind <: ToString {
    DEFAULT | GETTER | SETTER | LAMBDA |
    CLASS_CONSTRUCTOR | PRIMAL_CLASS_CONSTRUCTOR | STRUCT_CONSTRUCTOR | PRIMAL_STRUCT_CONSTRUCTOR |
    GLOBALVAR_INIT | FINALIZER | MAIN_ENTRY | ANNOFACTORY_FUNC | MACRO_FUNC | DEFAULT_PARAMETER_FUNC | INSTANCEVAR_INIT

    public func toString(): String {
        match (this) {
            case DEFAULT => "Default"
            case GETTER => "Getter"
            case SETTER => "Setter"
            case LAMBDA => "Lambda"
            case CLASS_CONSTRUCTOR => "ClassConstructor"
            case PRIMAL_CLASS_CONSTRUCTOR => "PrimaClassConstructor"
            case STRUCT_CONSTRUCTOR => "StructConstructor"
            case PRIMAL_STRUCT_CONSTRUCTOR => "PrimaStructConstructor"
            case GLOBALVAR_INIT => "GlobalVarInit"
            case FINALIZER => "Finalizer"
            case MAIN_ENTRY => "MainEntry"
            case ANNOFACTORY_FUNC => "AnnoFactoryFunc"
            case MACRO_FUNC => "MacroFunc"
            case DEFAULT_PARAMETER_FUNC => "DefaultParameterFunc"
            case INSTANCEVAR_INIT => "InstanceVarInit"
        }
    }
}

@Derive[Equatable]
internal enum LiteralKind <: ToString {
    BOOL | RUNE | INT | FLOAT | STRING | UNIT | NULL

    public func toString(): String {
        match (this) {
            case BOOL => "Bool"
            case RUNE => "Rune"
            case INT => "Int"
            case FLOAT => "Float"
            case STRING => "String"
            case UNIT => "Unit"
            case NULL => "Null"
        }
    }
}

sealed abstract class Value <: Base & ToString & Hashable & Equatable<Value> {
    internal let kind: ValueKind
    internal let _type: Type
    internal var _identifier: String
    internal var _hashCode: Int64 = 0
    private var _users = ArrayList<Expression>()

    public prop ty: Type {
        get() {
            return _type
        }
    }
    public mut prop identifier: String {
        get() {
            return _identifier
        }
        set(value) {
            _identifier = value
        }
    }
    public prop users: ArrayList<Expression> {
        get() {
            return _users
        }
    }
    public func hashCode(): Int64 {
        return _hashCode
    }

    public func isBlock(): Bool {
        return kind == ValueKind.BLOCK
    }
    public func isBlockGroup(): Bool {
        return kind == ValueKind.BLOCK_GROUP
    }
    public func isLocalVar(): Bool {
        return kind == ValueKind.LOCAL_VAR
    }
    public func isParameter(): Bool {
        return kind == ValueKind.PARAMETER
    }
    public func isFunc(): Bool {
        return kind == ValueKind.FUNC
    }
    public func isLiteral(): Bool {
        return kind == ValueKind.LITERAL
    }
    public func isGlobalVar(): Bool {
        return kind == ValueKind.GLOBAL_VAR
    }
    public func isFunction(): Bool {
        return kind == ValueKind.FUNC
    }
    public func isLiteralValue(): Bool {
        return kind == ValueKind.LITERAL
    }

    protected open func calculateHashCode(): Int64

    internal init(kind: ValueKind, identifier: String) {
        this.kind = kind
        this._type = g_invalidType
        this._identifier = identifier
    }
    internal init(kind: ValueKind, ty: Type, identifier: String) {
        this.kind = kind
        this._type = ty
        this._identifier = identifier
    }
}

public class Block <: Value {
    private var _owner: BlockGroup
    private var _exprs = ArrayList<Expression>()
    private var _predecessors = ArrayList<Block>()
    private var _exceptions: ?ArrayList<ClassType> = None

    public mut prop owner: BlockGroup {
        get() {
            return _owner
        }
        set(v) {
            _owner = v
        }
    }

    public prop exprs: ArrayList<Expression> {
        get() {
            return _exprs
        }
    }

    public prop predecessors: ArrayList<Block> {
        get() {
            return _predecessors
        }
    }

    public prop exceptions: ?ArrayList<ClassType> {
        get() {
            return _exceptions
        }
    }

    public prop topLevelFunc: Function {
        get() {
            return _owner.topLevelFunc
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected override func calculateHashCode(): Int64 {
        return (_owner.topLevelFunc.identifier + "_BG" + _owner.identifier + "_B" + identifier).hashCode()
    }

    public operator func==(other: Value): Bool {
        let o = (other as Block).getOrThrow()
        return this.identifier == o.identifier &&
            this.owner.identifier == o.owner.identifier &&
            this.topLevelFunc.identifier == o.topLevelFunc.identifier
    }

    internal init(identifier: String, owner: BlockGroup) {
        super(ValueKind.BLOCK, identifier)
        this._owner = owner
        this._hashCode = calculateHashCode()
    }
}

public class BlockGroup <: Value {
    // TODO: 能不能不用Option
    private var _entryBlock: ?Block = None
    private var _blocks = ArrayList<Block>()
    // owner is lambda(LocalVar) or global function(Function)
    private var _owner: Value

    public prop entryBlock: Block {
        get() {
            return _entryBlock.getOrThrow()
        }
    }

    public prop blocks: ArrayList<Block> {
        get() {
            return _blocks
        }
    }

    public mut prop owner: Value {
        get() {
            return _owner
        }
        set(v) {
            _owner = v
        }
    }

    public prop topLevelFunc: Function {
        get() {
            if (_owner.isFunction()) {
                return (_owner as Function).getOrThrow()
            } else {
                return (_owner as LocalVar).getOrThrow().topLevelFunc
            }
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as BlockGroup).getOrThrow()
        return this.identifier == o.identifier &&
            this.topLevelFunc.identifier == o.topLevelFunc.identifier
    }

    protected override func calculateHashCode(): Int64 {
        return (topLevelFunc.identifier + "_BG" + identifier).hashCode()
    }

    internal init(identifier: String, owner: Value) {
        super(ValueKind.BLOCK_GROUP, identifier)
        this._owner = owner
        this._hashCode = calculateHashCode()
    }
}

sealed abstract class GlobalSymbol <: Value {
    internal let _rawMangledName: String
    internal let _srcCodeIdentifier: String
    internal let _packageName: String
    internal var _declaredParent: ?CustomTypeDef = None

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

    public prop declaredParent: ?CustomTypeDef {
        get() {
            return _declaredParent
        }
    }

    protected prop rawMangledName: String {
        get() {
            return _rawMangledName
        }
    }

    public operator func==(other: Value): Bool {
        let o = (other as GlobalSymbol).getOrThrow()
        return this.identifier == o.identifier
    }

    protected override func calculateHashCode(): Int64 {
        return identifier.hashCode()
    }

    internal init(kind: ValueKind, ty: Type, identifier: String, srcName: String, pkgName: String, rawMangledName: String) {
        super(kind, ty, identifier)
        this._srcCodeIdentifier = srcName
        this._packageName = pkgName
        this._rawMangledName = rawMangledName
    }
}

public class GlobalVar <: GlobalSymbol {
    private let _initializer: ?Value = None

    public prop initializer: ?Value {
        get() {
            return _initializer
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public func isSrcCodeImported(): Bool {
        return isImported() && !_initializer.isNone()
    }

    internal init(ty: Type, identifier: String, srcName: String, pkgName: String, rawMangledName: String) {
        super(ValueKind.GLOBAL_VAR, ty, identifier, srcName, pkgName, rawMangledName)
        this._hashCode = calculateHashCode()
    }
}

public class Function <: GlobalSymbol {
    private var _parameters = ArrayList<Parameter>()
    private var _genericTypeParams = ArrayList<GenericType>()
    private var _body: ?BlockGroup = None
    private var _retValue: ?LocalVar = None
    private var _localId: UInt64 = 0
    private var _blockId: UInt64 = 0
    private var _blockGroupId: UInt64 = 0
    private var _genericDecl: ?Function = None
    private var _funcKind: FuncKind = FuncKind.DEFAULT
    private var _isFastNative: Bool = false
    private var _isCFFIWrapper: Bool = false
    private var _oriLambdaFuncTy: ?Type = None
    private var _oriLambdaGenericTypeParams: ?ArrayList<GenericType> = None
    private var _paramDftValHostFunc: ?Function = None

    public prop parameters: ArrayList<Parameter> {
        get() {
            return _parameters
        }
    }

    public prop paramDftValHostFunc: ?Function {
        get() {
            return _paramDftValHostFunc
        }
    }

    public mut prop isFastNative: Bool {
        get() {
            return _isFastNative
        }
        set(v) {
            _isFastNative = v
        }
    }

    public mut prop isCFFIWrapper: Bool {
        get() {
            return _isCFFIWrapper
        }
        set(v) {
            _isCFFIWrapper = v
        }
    }

    public mut prop oriLambdaFuncTy: ?Type {
        get() {
            return _oriLambdaFuncTy
        }
        set(v) {
            _oriLambdaFuncTy = v
        }
    }

    public mut prop oriLambdaGenericTypeParams: ?ArrayList<GenericType> {
        get() {
            return _oriLambdaGenericTypeParams
        }
        set(v) {
            _oriLambdaGenericTypeParams = v
        }
    }

    public mut prop genericDecl: ?Function {
        get() {
            return _genericDecl
        }
        set(v) {
            _genericDecl = v
        }
    }

    protected mut prop funcKind: FuncKind {
        get() {
            return _funcKind
        }
        set(v) {
            _funcKind = v
        }
    }

    public prop genericTypeParams: ArrayList<GenericType> {
        get() {
            return _genericTypeParams
        }
    }

    protected prop localId: UInt64 {
        get() {
            return _localId
        }
    }

    protected prop blockId: UInt64 {
        get() {
            return _blockId
        }
    }

    protected prop blockGroupId: UInt64 {
        get() {
            return _blockGroupId
        }
    }

    public prop body: BlockGroup {
        get() {
            return _body.getOrThrow()
        }
    }

    public prop retValue: LocalVar {
        get() {
            return _retValue.getOrThrow()
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public func isSrcCodeImported(): Bool {
        return isImported() && hasBody()
    }

    public func isDeclaredInCurPackage(): Bool {
        return !isImported()
    }

    public func hasBody(): Bool {
        return !_body.isNone()
    }

    internal init(ty: FuncType, identifier: String, srcName: String, pkgName: String, rawMangledName: String) {
        super(ValueKind.FUNC, ty, identifier, srcName, pkgName, rawMangledName)
        this._hashCode = calculateHashCode()
    }

    internal func GenerateLocalId(): UInt64 {
        let temp = _localId
        _localId++
        return temp
    }
}

sealed abstract class LiteralValue <: Value {
    private let literalKind: LiteralKind

    internal init(ty: Type, literalKind: LiteralKind) {
        super(ValueKind.LITERAL, ty, String.empty)
        this.literalKind = literalKind
    }
}

public class BoolLiteral <: LiteralValue {
    private let _value: Bool

    public prop value: Bool {
        get() {
            return _value
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as BoolLiteral).getOrThrow()
        return this.value == o.value
    }

    protected override func calculateHashCode(): Int64 {
        return _value.toString().hashCode()
    }

    internal init(ty: BoolType, value: Bool) {
        super(ty, LiteralKind.BOOL)
        this._value = value
        this._hashCode = calculateHashCode()
    }
}

public class RuneLiteral <: LiteralValue {
    private let _value: Rune

    public prop value: Rune {
        get() {
            return _value
        }
    }

    public operator func==(other: Value): Bool {
        let o = (other as RuneLiteral).getOrThrow()
        return this.value == o.value
    }

    internal init(ty: RuneType, value: Rune) {
        super(ty, LiteralKind.RUNE)
        this._value = value
        this._hashCode = calculateHashCode()
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected override func calculateHashCode(): Int64 {
        return _value.toString().hashCode()
    }
}

public class IntLiteral <: LiteralValue {
    private let _value: UInt64
    public prop unsignedValue: UInt64 {
        get() {
            return _value
        }
    }
    public prop signedValue: Int64 {
        get() {
            return Int64(_value)
        }
    }

    public func isSigned(): Bool {
        return (ty as IntType).getOrThrow().isSigned()
    }

    internal init(ty: IntType, value: UInt64) {
        super(ty, LiteralKind.INT)
        this._value = value
        this._hashCode = calculateHashCode()
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as IntLiteral).getOrThrow()
        return this.unsignedValue == o.unsignedValue && this.ty == o.ty
    }

    protected override func calculateHashCode(): Int64 {
        return (ty.toString() + "_" + _value.toString()).hashCode()
    }
}

public class FloatLiteral <: LiteralValue {
    private let _value: Float64
    public prop value: Float64 {
        get() {
            return _value
        }
    }
    internal init(ty: Type, value: Float64) {
        super(ty, LiteralKind.FLOAT)
        this._value = value
        this._hashCode = calculateHashCode()
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as FloatLiteral).getOrThrow()
        return this.value == o.value && this.ty == o.ty
    }

    protected override func calculateHashCode(): Int64 {
        return (ty.toString() + "_" + _value.toString()).hashCode()
    }
}

public class StringLiteral <: LiteralValue {
    private let _value: String
    public prop value: String {
        get() {
            return _value
        }
    }
    internal init(ty: Type, value: String) {
        super(ty, LiteralKind.STRING)
        this._value = value
        this._hashCode = calculateHashCode()
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as StringLiteral).getOrThrow()
        return this.value == o.value && this.ty == o.ty
    }

    protected override func calculateHashCode(): Int64 {
        return (ty.toString() + "_" + _value.toString()).hashCode()
    }
}

public class UnitLiteral <: LiteralValue {
    internal init(ty: UnitType) {
        super(ty, LiteralKind.UNIT)
        this._hashCode = calculateHashCode()
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as UnitLiteral).getOrThrow()
        return this.ty == o.ty
    }

    protected override func calculateHashCode(): Int64 {
        return ty.toString().hashCode()
    }
}

public class NullLiteral <: LiteralValue {
    internal init(ty: Type) {
        super(ty, LiteralKind.NULL)
        this._hashCode = calculateHashCode()
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as NullLiteral).getOrThrow()
        return this.ty == o.ty
    }

    protected override func calculateHashCode(): Int64 {
        return ty.toString().hashCode()
    }
}

public class LocalVar <: Value {
    private let _expr: Expression
    private var _isRetValue = false

    public prop expr: Expression {
        get() {
            return _expr
        }
    }

    public prop isRetValue: Bool {
        get() {
            return _isRetValue
        }
    }

    public prop topLevelFunc: Function {
        get() {
            return _expr.topLevelFunc
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as LocalVar).getOrThrow()
        return this.topLevelFunc.identifier == o.topLevelFunc.identifier &&
            this.identifier == o.identifier
    }

    protected override func calculateHashCode(): Int64 {
        return (topLevelFunc.identifier + "_LV" + identifier).hashCode()
    }

    internal init(ty: Type, identifier: String, expr: Expression) {
        super(ValueKind.LOCAL_VAR, ty, identifier)
        this._expr = expr
        this._hashCode = calculateHashCode()
    }
}

public class MemberVar <: Value {
    private var _owner: CustomTypeDef

    public mut prop owner: CustomTypeDef {
        get() {
            return _owner
        }
        set(v) {
            _owner = v
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as MemberVar).getOrThrow()
        return this.owner.identifier == o.owner.identifier &&
            this.identifier == o.identifier
    }

    protected override func calculateHashCode(): Int64 {
        return (_owner.identifier + "_MV" + identifier).hashCode()
    }

    internal init(ty: Type, identifier: String, owner: CustomTypeDef) {
        super(ValueKind.MEMBER_VAR, ty, identifier)
        this._owner = owner
        this._hashCode = calculateHashCode()
    }
}

public class Parameter <: Value {
    private var _owner: Value

    public mut prop owner: Value {
        get() {
            return _owner
        }
        set(v) {
            _owner = v
        }
    }

    public prop topLevelFunc: Function {
        get() {
            if (_owner.isFunction()) {
                return (_owner as Function).getOrThrow()
            } else {
                return (_owner as LocalVar).getOrThrow().topLevelFunc
            }
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public operator func==(other: Value): Bool {
        let o = (other as Parameter).getOrThrow()
        return this.topLevelFunc.identifier == o.topLevelFunc.identifier &&
            this.identifier == o.identifier
    }

    protected override func calculateHashCode(): Int64 {
        return (topLevelFunc.identifier + "_P" + identifier).hashCode()
    }

    internal init(ty: Type, identifier: String, owner: Value) {
        super(ValueKind.PARAMETER, ty, identifier)
        this._owner = owner
        this._hashCode = calculateHashCode()
    }
}