/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

protected enum ExprKind {
    // terminator
    GOTO | BRANCH | MULTI_BRANCH | EXIT |
    APPLY_WITH_EXCEPTION | INVOKE_WITH_EXCEPTION | INTRINSIC_WITH_EXCEPTION |
    RAISE_WITH_EXCEPTION | SPAWN_WITH_EXCEPTION | TYPE_CAST_WITH_EXCEPTION |
    ALLOCATE_WITH_EXCEPTION | RAW_ARRAY_ALLOCATE_WITH_EXCEPTION |

    // unary expr
    NEG | NOT | BIT_NOT |

    // binary expr
    ADD | SUB | MUL | DIV | MOD | EXP |
    L_SHIFT | R_SHIFT | BIT_AND | BIT_OR | BIT_XOR |
    LT | GT | LE | GE | EQUAL | NOT_EQUAL |
    AND | OR |

    // memory expr
    ALLOCATE | LOAD | STORE | GET_ELEMENT_REF | STORE_ELEMENT_REF | FIELD |

    // array
    RAW_ARRAY_ALLOCATE | RAW_ARRAY_LITERAL_INIT | RAW_ARRAY_INIT_BY_VALUE |
    VARRAY | VARRAY_BUILDER |

    // others
    CONSTANT | DEBUG | TUPLE | INSTANCE_OF | TYPE_CAST | GET_EXCEPTION | SPAWN | LAMBDA | GET_INSTANTIATE_VALUE |
    APPLY | INVOKE | INTRINSIC | GET_RTTI | GET_RTTI_STATIC

    protected func IsTerminator(): Bool {
        match (this) {
            case GOTO | BRANCH | MULTI_BRANCH | EXIT |
            APPLY_WITH_EXCEPTION | INVOKE_WITH_EXCEPTION | INTRINSIC_WITH_EXCEPTION |
            RAISE_WITH_EXCEPTION | SPAWN_WITH_EXCEPTION | TYPE_CAST_WITH_EXCEPTION |
            ALLOCATE_WITH_EXCEPTION | RAW_ARRAY_ALLOCATE_WITH_EXCEPTION => true
            case _ => false
        }
    }

    protected func IsUnary(): Bool {
        match (this) {
            case NEG | NOT | BIT_NOT => true
            case _ => false
        }
    }

    protected func IsBinary(): Bool {
        match (this) {
            case ADD | SUB | MUL | DIV | MOD | EXP |
            L_SHIFT | R_SHIFT | BIT_AND | BIT_OR | BIT_XOR |
            LT | GT | LE | GE | EQUAL | NOT_EQUAL |
            AND | OR => true
            case _ => false
        }
    }
}

protected enum OverflowStrategy {
    NA | WRAPPING | THROWING | SATURATING
}

protected enum IntrinsicKind {
    INOUT
}

sealed abstract class Expression <: Base & ToString & Hashable {
    internal let kind: ExprKind
    internal var _operands: ArrayList<Value>
    internal var _blockGroups = ArrayList<BlockGroup>()
    internal var _owner: Block
    internal var _result: ?LocalVar = None

    public func hashCode(): Int64 {
        return _result.getOrThrow().hashCode()
    }

    public prop operands: ArrayList<Value> {
        get() {
            return _operands
        }
    }

    public prop blockGroups: ArrayList<BlockGroup> {
        get() {
            return _blockGroups
        }
    }

    public prop owner: Block {
        get() {
            return _owner
        }
    }

    public prop result: LocalVar {
        get() {
            return _result.getOrThrow()
        }
    }

    public prop topLevelFunc: Function {
        get() {
            return _owner.topLevelFunc
        }
    }

    public func IsTerminator(): Bool {
        if (kind.IsTerminator()) {
            return true
        }
        if (kind.IsUnary() || kind.IsBinary()) {
            return operands[-1].IsBlock()
        }
        return false
    }

    protected init(kind: ExprKind, operands: ArrayList<Value>, owner: Block) {
        this.kind = kind
        this._operands = operands
        this._owner = owner
    }

    protected init(kind: ExprKind, owner: Block) {
        this.kind = kind
        this._operands = ArrayList<Value>()
        this._owner = owner
    }
}

public class UnaryExpression <: Expression {
    private let _overflow: OverflowStrategy

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(kind: ExprKind, op: Value, overflow: OverflowStrategy, owner: Block) {
        super(kind, ArrayList<Value>([op]), owner)
        this._overflow = overflow
    }

    protected init(kind: ExprKind, op: Value, owner: Block) {
        super(kind, ArrayList<Value>([op]), owner)
        this._overflow = OverflowStrategy.NA
    }

    protected init(kind: ExprKind, op: Value, owner: Block, normal: Block, err: Block) {
        super(kind, ArrayList<Value>([op]), owner)
        this._overflow = OverflowStrategy.THROWING
        _operands.add(normal)
        _operands.add(err)
    }
}

public class BinaryExpression <: Expression {
    private let _overflow: OverflowStrategy

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(kind: ExprKind, leftOp: Value, rightOp: Value, overflow: OverflowStrategy, owner: Block) {
        super(kind, ArrayList<Value>([leftOp, rightOp]), owner)
        this._overflow = overflow
    }

    protected init(kind: ExprKind, leftOp: Value, rightOp: Value, owner: Block) {
        super(kind, ArrayList<Value>([leftOp, rightOp]), owner)
        this._overflow = OverflowStrategy.NA
    }

    protected init(kind: ExprKind, leftOp: Value, rightOp: Value, owner: Block, normal: Block, err: Block) {
        super(kind, ArrayList<Value>([leftOp, rightOp]), owner)
        this._overflow = OverflowStrategy.THROWING
        _operands.add(normal)
        _operands.add(err)
    }
}

public class Constant <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(val: LiteralValue, owner: Block) {
        super(ExprKind.CONSTANT, ArrayList<Value>([val]), owner)
    }
}

public class Allocate <: Expression {
    private let _ty: Type

    public prop ty: Type {
        get() {
            return _ty
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(ty: Type, owner: Block) {
        super(ExprKind.ALLOCATE, owner)
        this._ty = ty
    }

    protected init(ty: Type, owner: Block, normal: Block, err: Block) {
        super(ExprKind.ALLOCATE_WITH_EXCEPTION, owner)
        _operands.add(normal)
        _operands.add(err)
        this._ty = ty
    }
}

public class Load <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(location: Value, owner: Block) {
        super(ExprKind.LOAD, ArrayList<Value>([location]), owner)
    }
}

public class Store <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(val: Value, location: Value, owner: Block) {
        super(ExprKind.STORE, ArrayList<Value>([val, location]), owner)
    }
}

public class GetElementRef <: Expression {
    private let _path: ArrayList<UInt64>

    public prop path: ArrayList<UInt64> {
        get() {
            return _path
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(location: Value, path: ArrayList<UInt64>, owner: Block) {
        super(ExprKind.GET_ELEMENT_REF, ArrayList<Value>([location]), owner)
        this._path = path
    }
}

public class StoreElementRef <: Expression {
    private let _path: ArrayList<UInt64>

    public prop path: ArrayList<UInt64> {
        get() {
            return _path
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(val: Value, location: Value, path: ArrayList<UInt64>, owner: Block) {
        super(ExprKind.STORE_ELEMENT_REF, ArrayList<Value>([val, location]), owner)
        this._path = path
    }
}

public struct FuncCallContext {
    public FuncCallContext(let args: ArrayList<Value>, let instTypeArgs: ArrayList<Type>, let thisType: Type) {

    }
}

public struct InvokeCallContext {
    public InvokeCallContext(let caller: Value, let srcVirtualFunc: Function, let funcCallCtx: FuncCallContext) {

    }
}

sealed abstract class FuncCall <: Expression {
    internal let _instantiatedTypeArgs: ArrayList<Type>
    internal let _thisType: Type

    public prop instantiatedTypeArgs: ArrayList<Type> {
        get() {
            return _instantiatedTypeArgs
        }
    }

    public prop thisType: Type {
        get() {
            return _thisType
        }
    }

    protected init(kind: ExprKind, funcCallCtx: FuncCallContext, owner: Block) {
        super(kind, funcCallCtx.args, owner)
        this._instantiatedTypeArgs = funcCallCtx.instTypeArgs
        this._thisType = funcCallCtx.thisType
    }
}

public class Apply <: FuncCall {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(callee: Value, funcCallCtx: FuncCallContext, owner: Block) {
        super(ExprKind.APPLY, funcCallCtx, owner)
        _operands.add(callee, at: 0)
    }

    protected init(callee: Value, funcCallCtx: FuncCallContext, owner: Block, normal: Block, err: Block) {
        super(ExprKind.APPLY_WITH_EXCEPTION, funcCallCtx, owner)
        _operands.add(callee, at: 0)
        _operands.add(normal)
        _operands.add(err)
    }
}

public class Intrinsic <: FuncCall {
    private let _calleeKind: IntrinsicKind

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(calleeKind: IntrinsicKind, funcCallCtx: FuncCallContext, owner: Block) {
        super(ExprKind.INTRINSIC, funcCallCtx, owner)
        this._calleeKind = calleeKind
    }

    protected init(calleeKind: IntrinsicKind, funcCallCtx: FuncCallContext, owner: Block, normal: Block, err: Block) {
        super(ExprKind.INTRINSIC_WITH_EXCEPTION, funcCallCtx, owner)
        this._calleeKind = calleeKind
        _operands.add(normal)
        _operands.add(err)
    }
}

public class Invoke <: FuncCall {
    internal let _srcVirtualFunc: Function

    public prop methodName: String {
        get() {
            return _srcVirtualFunc.srcCodeIdentifier
        }
    }

    public prop methodType: FuncType {
        get() {
            return (_srcVirtualFunc.ty as FuncType).getOrThrow()
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(callContext: InvokeCallContext, owner: Block) {
        super(ExprKind.INVOKE, callContext.funcCallCtx, owner)
        _operands.add(callContext.caller, at: 0)
        this._srcVirtualFunc = callContext.srcVirtualFunc
    }

    protected init(callContext: InvokeCallContext, owner: Block, normal: Block, err: Block) {
        super(ExprKind.INVOKE_WITH_EXCEPTION, callContext.funcCallCtx, owner)
        _operands.add(callContext.caller, at: 0)
        _operands.add(normal)
        _operands.add(err)
        this._srcVirtualFunc = callContext.srcVirtualFunc
    }
}

public class GetRTTI <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(val: Value, owner: Block) {
        super(ExprKind.GET_RTTI, ArrayList<Value>([val]), owner)
    }
}

public class GetRTTIStatic <: Expression {
    private let _ty: Type

    public prop ty: Type {
        get() {
            return _ty
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(ty: Type, owner: Block) {
        super(ExprKind.GET_RTTI_STATIC, owner)
        this._ty = ty
    }
}

public class TypeCast <: Expression {
    internal let _targetTy: Type
    private let _overflow: OverflowStrategy

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public prop targetTy: Type {
        get() {
            return _targetTy
        }
    }

    protected init(srcVal: Value, targetTy: Type, owner: Block) {
        super(ExprKind.TYPE_CAST, ArrayList<Value>([srcVal]), owner)
        this._targetTy = targetTy
        this._overflow = OverflowStrategy.NA
    }
    protected init(srcVal: Value, targetTy: Type, overflow: OverflowStrategy, owner: Block) {
        super(ExprKind.TYPE_CAST, ArrayList<Value>([srcVal]), owner)
        this._targetTy = targetTy
        this._overflow = overflow
    }
    protected init(srcVal: Value, targetTy: Type, owner: Block, normal: Block, err: Block) {
        super(ExprKind.TYPE_CAST_WITH_EXCEPTION, ArrayList<Value>([srcVal]), owner)
        _operands.add(normal)
        _operands.add(err)
        this._targetTy = targetTy
        this._overflow = OverflowStrategy.THROWING
    }
}

public class InstanceOf <: Expression {
    private let _targetTy: Type

    public prop targetTy: Type {
        get() {
            return _targetTy
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(srcVal: Value, targetTy: Type, owner: Block) {
        super(ExprKind.INSTANCE_OF, ArrayList<Value>([srcVal]), owner)
        this._targetTy = targetTy
    }
}

public class Tuple <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(elements: ArrayList<Value>, owner: Block) {
        super(ExprKind.TUPLE, elements, owner)
    }
}

public class Field <: Expression {
    internal let _path: ArrayList<UInt64>

    public prop path: ArrayList<UInt64> {
        get() {
            return _path
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(location: Value, path: ArrayList<UInt64>, owner: Block) {
        super(ExprKind.FIELD, ArrayList<Value>([location]), owner)
        this._path = path
    }
}

public class RawArrayAllocate <: Expression {
    private let _elementType: Type

    public prop elementType: Type {
        get() {
            return _elementType
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(elementType: Type, size: Value, owner: Block) {
        super(ExprKind.RAW_ARRAY_ALLOCATE, ArrayList<Value>([size]), owner)
        this._elementType = elementType
    }

    protected init(elementType: Type, size: Value, owner: Block, normal: Block, err: Block) {
        super(ExprKind.RAW_ARRAY_ALLOCATE_WITH_EXCEPTION, ArrayList<Value>([size]), owner)
        _operands.add(normal)
        _operands.add(err)
        this._elementType = elementType
    }
}

public class RawArrayLiteralInit <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(memory: Value, elements: ArrayList<Value>, owner: Block) {
        super(ExprKind.RAW_ARRAY_LITERAL_INIT, elements, owner)
        _operands.add(memory, at: 0)
    }
}

public class RawArrayInitByValue <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(memory: Value, size: Value, initVal: Value, owner: Block) {
        super(ExprKind.RAW_ARRAY_INIT_BY_VALUE, ArrayList<Value>([memory, size, initVal]), owner)
    }
}

public class VArrayExpr <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(elements: ArrayList<Value>, owner: Block) {
        super(ExprKind.VARRAY, elements, owner)
    }
}

public class VArrayBuilder <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(size: Value, initVal: Value, initFunc: Value, owner: Block) {
        super(ExprKind.VARRAY_BUILDER, ArrayList<Value>([size, initVal, initFunc]), owner)
    }
}

public class GetException <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    protected init(owner: Block) {
        super(ExprKind.GET_EXCEPTION, owner)
    }
}

public class Lambda <: Expression {
    private let _identifier: String
    private let _srcCodeIdentifier: String
    private let _funcType: FuncType
    private var _parameters = ArrayList<Parameter>()
    private let isLocalFunc = false
    private var _genericTypeParams = ArrayList<GenericType>()
    private var _paramDftValHostFunc: ?Lambda = None

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

    public prop funcType: FuncType {
        get() {
            return _funcType
        }
    }

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

    public prop paramDftValHostFunc: Lambda {
        get() {
            return _paramDftValHostFunc.getOrThrow()
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(ty: FuncType, identifier: String, srcName: String, owner: Block) {
        super(ExprKind.LAMBDA, owner)
        this._identifier = identifier
        this._srcCodeIdentifier = srcName
        this._funcType = ty
    }
}

public class Debug <: Expression {
    private let _srcCodeIdentifier: String

    public prop srcCodeIdentifier: String {
        get() {
            return _srcCodeIdentifier
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(location: Value, srcName: String, owner: Block) {
        super(ExprKind.DEBUG, ArrayList<Value>([location]), owner)
        this._srcCodeIdentifier = srcName
    }
}

public class Spawn <: Expression {
    private let _executeClosure: ?Function = None

    public prop executeClosure: Function {
        get() {
            return _executeClosure.getOrThrow()
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(lambda: Value, owner: Block) {
        super(ExprKind.SPAWN, ArrayList<Value>([lambda]), owner)
    }

    protected init(lambda: Value, arg: Value, owner: Block) {
        super(ExprKind.SPAWN, ArrayList<Value>([lambda, arg]), owner)
    }

    protected init(lambda: Value, owner: Block, normal: Block, err: Block) {
        super(ExprKind.SPAWN_WITH_EXCEPTION, ArrayList<Value>([lambda]), owner)
        _operands.add(normal)
        _operands.add(err)
    }

    protected init(lambda: Value, arg: Value, owner: Block, normal: Block, err: Block) {
        super(ExprKind.SPAWN_WITH_EXCEPTION, ArrayList<Value>([lambda, arg]), owner)
        _operands.add(normal)
        _operands.add(err)
    }
}

public class GetInstantiateValue <: Expression {
    private let _instantiateTypes: ArrayList<Type>

    public prop instantiateTypes: ArrayList<Type> {
        get() {
            return _instantiateTypes
        }
    }

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    protected init(val: Value, instantiateTypes: ArrayList<Type>, owner: Block) {
        super(ExprKind.GET_INSTANTIATE_VALUE, ArrayList<Value>([val]), owner)
        this._instantiateTypes = instantiateTypes
    }
}

public class GoTo <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    internal init(target: Block, owner: Block) {
        super(ExprKind.GOTO, owner)
        _operands.add(target)
    }
}

public class Branch <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    internal init(condition: Value, trueTarget: Block, falseTarget: Block, owner: Block) {
        super(ExprKind.BRANCH, ArrayList<Value>([condition]), owner)
        _operands.add(trueTarget)
        _operands.add(falseTarget)
    }
}

public class MultiBranch <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    internal init(condition: Value, targets: ArrayList<Block>, owner: Block) {
        super(ExprKind.MULTI_BRANCH, ArrayList<Value>([condition]), owner)
        _operands.add(all: ArrayList<Value>(targets.size, { i => targets[i] }))
    }
}

public class Exit <: Expression {
    // TODO: 后面实现
    public func toString(): String {
        String()
    }
    internal init(owner: Block) {
        super(ExprKind.EXIT, owner)
    }
}