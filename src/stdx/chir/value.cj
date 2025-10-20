/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

public abstract class Value <: ToString & Hashable & Equatable<Value> {
    private var _identifier: String
    private var _type: Type
    
    public prop identifier: String {
        get() { _identifier }
        set(value) { _identifier = value }
    }
    
    public prop `type`: Type {
        get() { _type }
        set(value) { _type = value }
    }
    
    public Value(identifier: String, `type`: Type) {
        this._identifier = identifier
        this._type = `type`
    }

    public func toString(): String
    public open func hashCode() { identifier.hashCode() }
    public open func equals(other: Value): Bool { refEq(this, other) }
}

public abstract class LiteralValue <: Value {
    private var _expr: ?ConstantExpr = None
    
    public prop expr: ?ConstantExpr {
        get() { _expr }
        set(value) { _expr = value }
    }
    
    public LiteralValue(identifier: String, `type`: Type) { super(identifier, `type`) }
}

public class IntLiteral <: LiteralValue {
    private var _value: UInt64
    
    public prop value: UInt64 {
        get() { _value }
        set(value) { _value = value }
    }
    
    public IntLiteral(identifier: String, `type`: Type, value: UInt64) { 
        super(identifier, `type`) 
        this._value = value
    }
    
    public override func toString(): String {
        "${value}${getTypeSuffix()}"
    }
    func getTypeSuffix() {
        if (let pt: PrimitiveType <- `type`) {
            pt.getTypeSuffix()
        } else {
            ""
        }
    }
    public override func hashCode() { super.hashCode() ^ value.hashCode() }
    public override operator func==(other: Value): Bool {
        match (other) {
            case v: IntLiteral => value == v.value
            case _ => false
        }
    }
}

public open class GlobalVar <: Value {
    private var _initializer: ?ConstantExpr = None
    
    public prop initializer: ?ConstantExpr {
        get() { _initializer }
        set(value) { _initializer = value }
    }
    
    public GlobalVar(identifier: String, `type`: Type) { super(identifier, `type`) }
    
    public override func toString(): String {
        let s = StringBuilder()
        s.append("${identifier}: ${`type`}")
        if (let Some(`init`) <- initializer) {
            s.append(" = ${`init`}")
        }
        s.toString()
    }
    public override func hashCode() {
        var r = super.hashCode() ^ `type`.hashCode()
        r
    }
    public override operator func==(other: Value): Bool {
        match (other) {
            case v: GlobalVar => identifier == v.identifier
            case _ => false
        }
    }
}
