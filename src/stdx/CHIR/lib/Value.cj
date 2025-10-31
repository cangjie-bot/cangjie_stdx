/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

internal enum ValueKind <: ToString & Equatable<ValueKind> {
    GLOBAL_VAR | LOCAL_VAR | PARAMETER | FUNC | BLOCK | BLOCK_GROUP | LITERAL | MEMBER_VAR

    public operator func==(other: ValueKind): Bool {
        match ((this, other)) {
            case (GLOBAL_VAR, GLOBAL_VAR) => true
            case (LOCAL_VAR, LOCAL_VAR) => true
            case (PARAMETER, PARAMETER) => true
            case (FUNC, FUNC) => true
            case (BLOCK, BLOCK) => true
            case (BLOCK_GROUP, BLOCK_GROUP) => true
            case (LITERAL, LITERAL) => true
            case (MEMBER_VAR, MEMBER_VAR) => true
            case _ => false
        }
    }

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

internal enum LiteralKind <: Equatable<LiteralKind> {
    BOOL | RUNE | INT | FLOAT | STRING | UNIT | NULL

    public operator func==(other: LiteralKind): Bool {
        match ((this, other)) {
            case (BOOL, BOOL) => true
            case (RUNE, RUNE) => true
            case (INT, INT) => true
            case (FLOAT, FLOAT) => true
            case (STRING, STRING) => true
            case (UNIT, UNIT) => true
            case (NULL, NULL) => true
            case _ => false
        }
    }
}

sealed abstract class Value <: Base & ToString {
    internal let kind: ValueKind
    internal let _type: Type
    internal let _identifier: String
    private var _users = ArrayList<Expression>()

    public prop ty: Type {
        get() {
            return _type
        }
    }
    public prop identifier: String {
        get() {
            return _identifier
        }
    }
    public prop users: ArrayList<Expression> {
        get() {
            return _users
        }
    }
    public open prop topLevelFunc: Function {
        get() {
            throw Exception("topLevelFunc is not supported for this value: " + kind.toString())
        }
    }
    public func IsBlock(): Bool {
        return kind == ValueKind.BLOCK
    }
    public func IsBlockGroup(): Bool {
        return kind == ValueKind.BLOCK_GROUP
    }
    public func IsLocalVar(): Bool {
        return kind == ValueKind.LOCAL_VAR
    }
    public func IsParameter(): Bool {
        return kind == ValueKind.PARAMETER
    }
    public func IsFunc(): Bool {
        return kind == ValueKind.FUNC
    }
    public func IsLiteral(): Bool {
        return kind == ValueKind.LITERAL
    }
    public func IsGlobalVar(): Bool {
        return kind == ValueKind.GLOBAL_VAR
    }
    public func IsFunction(): Bool {
        return kind == ValueKind.FUNC
    }
    public func IsLiteralValue(): Bool {
        return kind == ValueKind.LITERAL
    }
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
    private let _owner: BlockGroup
    private var _exprs = ArrayList<Expression>()
    private var _predecessors = ArrayList<Block>()
    private var _exceptions: ?ArrayList<ClassType> = None

    public prop owner: BlockGroup {
        get() {
            return _owner
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

    internal init(identifier: String, owner: BlockGroup) {
        super(ValueKind.BLOCK, identifier)
        this._owner = owner
    }
}

public class BlockGroup <: Value {
    // TODO: 能不能不用Option
    private var _entryBlock: ?Block = None
    private var _blocks = ArrayList<Block>()
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

    public prop owner: Value {
        get() {
            return _owner
        }
    }

    public prop topLevelFunc: Function {
        get() {
            if (_owner.IsFunction()) {
                return (_owner as Function).getOrThrow()
            }
            return _owner.topLevelFunc
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    internal init(identifier: String, owner: Value) {
        super(ValueKind.BLOCK_GROUP, identifier)
        this._owner = owner
    }
}

sealed abstract class GlobalValue <: Value {
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

    internal init(kind: ValueKind, ty: Type, identifier: String, srcName: String, pkgName: String) {
        super(kind, ty, identifier)
        this._srcCodeIdentifier = srcName
        this._packageName = pkgName
    }
}

public class GlobalVar <: GlobalValue {
    private let _initializer: ?Value = None

    public prop initializer: Value {
        get() {
            return _initializer.getOrThrow()
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public func isSrcCodeImported(): Bool {
        return isImported() && !_initializer.isNone()
    }

    internal init(ty: Type, identifier: String, srcName: String, pkgName: String) {
        super(ValueKind.GLOBAL_VAR, ty, identifier, srcName, pkgName)
    }
}

public class Function <: GlobalValue {
    private var _parameters = ArrayList<Parameter>()
    private var _genericTypeParams = ArrayList<GenericType>()
    private var _body: ?BlockGroup = None
    private var _retValue: ?LocalVar = None
    private var localId: UInt64 = 0
    private var blockId: UInt64 = 0
    private var blockGroupId: UInt64 = 0

    public prop parameters: ArrayList<Parameter> {
        get() {
            return _parameters
        }
    }

    public prop genericTypeParams: ArrayList<GenericType> {
        get() {
            return _genericTypeParams
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

    internal init(ty: FuncType, identifier: String, srcName: String, pkgName: String) {
        super(ValueKind.FUNC, ty, identifier, srcName, pkgName)
    }

    internal func GenerateLocalId(): UInt64 {
        let temp = localId
        localId++
        return temp
    }
}

public class LiteralValue <: Value {
    private let literalKind: LiteralKind

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    internal init(ty: Type, literalKind: LiteralKind) {
        super(ValueKind.LITERAL, ty, String.empty)
        this.literalKind = literalKind
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

    internal init(ty: Type, identifier: String, expr: Expression) {
        super(ValueKind.LOCAL_VAR, ty, identifier)
        this._expr = expr
    }
}

public class MemberVar <: Value {
    private var _owner: CustomTypeDef

    public prop owner: CustomTypeDef {
        get() {
            return _owner
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    internal init(ty: Type, identifier: String, owner: CustomTypeDef) {
        super(ValueKind.MEMBER_VAR, ty, identifier)
        this._owner = owner
    }
}

public class Parameter <: Value {
    private var _owner: Value

    public prop owner: Value {
        get() {
            return _owner
        }
    }

    public prop topLevelFunc: Function {
        get() {
            if (_owner.IsFunction()) {
                return (_owner as Function).getOrThrow()
            }
            return _owner.topLevelFunc
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    internal init(ty: Type, identifier: String, owner: Value) {
        super(ValueKind.PARAMETER, ty, identifier)
        this._owner = owner
    }
}