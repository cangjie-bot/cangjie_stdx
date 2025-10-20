/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

public abstract class Expression <: ToString {
    public var value = None<Value>
    public var `type` = None<Type>
    public func toString(): String
}

public class ConstantExpr <: Expression {
    public override func toString(): String {
        if (let Some(value) <- value) {
            "Constant(${value})"
        } else {
            unreachable()
        }
    }
    public func getValue() {
        match (value) {
            case Some(v) => (v as LiteralValue).getOrThrow()
            case None => None<LiteralValue>
        }
    }

    public init() {}
    public init(v: LiteralValue) {
        value = Some(v)
        `type` = Some(v.`type`)
    }
}
