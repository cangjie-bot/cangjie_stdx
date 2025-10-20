/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

public abstract class Value <: ToString & Hashable & Equatable<Value> {
    public Value(public var identifier: String, public var `type`: Type) {}

    public func toString(): String
    public open func hashCode() { identifier.hashCode() }
    public open func equals(other: Value): Bool { refEq(this, other) }
}

public abstract class LiteralValue <: Value {
    public LiteralValue(identifier: String, `type`: Type) { super(identifier, `type`) }
    public var expr: ?ConstantExpr = None
}

public class IntLiteral <: LiteralValue {
    public IntLiteral(identifier: String, `type`: Type, public var value: UInt64) { super(identifier, `type`) }
    
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
    public GlobalVar(identifier: String, `type`: Type) { super(identifier, `type`) }

    public var initializer = None<ConstantExpr>
    
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
