/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.{ArrayList, ArrayStack}

// The base of NonTerminal (Non-Leaf node) and Terminal (Leaf node)
abstract class SyntaxNodeImpl {
    let kind: SyntaxNodeKind
    let virtualParent: Option<SyntaxNodeImpl> = None

    init(kind: SyntaxNodeKind) {
        this.kind = kind
    }

    prop offset: Offset {
        get() {
            return getOffset()
        }
    }

    protected func toString(): String

    protected func getOffset(): Offset
}

// NonTerminal: Non-Leaf node
class NonTerminal <: SyntaxNodeImpl {
    let children: Array<SyntaxNodeImpl>

    init(kind: SyntaxNodeKind, children: Array<SyntaxNodeImpl>) {
        super(kind)
        this.children = children
    }

    protected func toString(): String {
        let stack = ArrayStack<SyntaxNodeImpl>()
        stack.add(this)
        let sb = StringBuilder()
        while (let Some(node) <- stack.remove()) {
            match (node) {
                case nt: NonTerminal =>
                    let size = nt.children.size
                    for (i in (size - 1)..=0 : -1) {
                        stack.add(nt.children[i])
                    }
                case t: Terminal => sb.append(t.toString())
                case _ => "Unknown"
            }
        }
        sb.toString()
    }

    protected func getOffset(): Offset {
        let offset = Offset()
        for (child in children) {
            offset.moveNode(child)
        }
        return offset
    }
}

// Terminal: Leaf node
open class Terminal <: SyntaxNodeImpl {
    init(kind: SyntaxNodeKind) {
        super(kind)
    }

    protected open func toString(): String {
        kind.toString()
    }

    protected open func getOffset(): Offset {
        return Offset(0, Int32(toString().size))
    }
}

@When[os != "Windows"]
const NEWLINE = "\n"
@When[os == "Windows"]
const NEWLINE = "\r\n"
@When[os != "Windows"]
const SEPARATOR = "/"
@When[os == "Windows"]
const SEPARATOR = "\\"

// Including space, newline, tab, # token with repeat times
class RepeatedTerminal <: Terminal {
    let repeat: Int64

    init(kind: SyntaxNodeKind, repeat: Int64) {
        super(kind)
        this.repeat = repeat
    }

    protected func toString(): String {
        match (this.kind) {
            case SyntaxNodeKind.SpaceToken => " " * repeat
            case SyntaxNodeKind.NewlineToken => NEWLINE * repeat
            case SyntaxNodeKind.HashToken => "#" * repeat
            case _ => ""
        }
    }

    protected func getOffset(): Offset {
        match (this.kind) {
            case SyntaxNodeKind.NewlineToken => return Offset(Int32(repeat), 1)
            case _ => return Offset(0, Int32(repeat))
        }
    }
}

class ValuedTerminal <: Terminal {
    let value: String

    init(kind: SyntaxNodeKind, value: String) {
        super(kind)
        this.value = value
    }

    protected func toString(): String {
        value
    }

    protected func getOffset(): Offset {
        var offset = Offset()
        var strSplit = value.split(NEWLINE)
        if (strSplit.size > 1) {
            offset.line += Int32(strSplit.size) - 1
            offset.column = Int32(strSplit[strSplit.size - 1].toRuneArray().size + 1)
        } else {
            offset.column += Int32(value.toRuneArray().size)
        }
        return offset
    }
}

class TokenTerminal <: Terminal {
    let tokenKind: TokenKind
    let value: String
    let hasEscape: Bool

    init(tokenKind: TokenKind, value: String, hasEscape!: Bool = false) {
        super(SyntaxNodeKind.Token)
        this.tokenKind = tokenKind
        this.value = value
        this.hasEscape = hasEscape
    }

    protected func toString(): String {
        if (hasEscape) {
            "\\" + value
        } else {
            value
        }
    }
}

// Optimization Points only create one Terminal when create same class
// The builder of SyntaxNodeImpl node
/**
 * The builder of SyntaxNodeImpl node.
 *
 * Optimization Points:
 *     1. Cache some terminals
 */
class SyntaxNodeBuilder {
    private static let invalid = Terminal(SyntaxNodeKind.Invalid)

    func buildBasicTerminal(kind: SyntaxNodeKind): Terminal {
        Terminal(kind)
    }

    func buildInvalidTerminal(): Terminal {
        SyntaxNodeBuilder.invalid
    }

    func buildNewline(repeat: Int64): RepeatedTerminal {
        RepeatedTerminal(SyntaxNodeKind.NewlineToken, repeat)
    }

    func buildSpace(repeat: Int64): RepeatedTerminal {
        RepeatedTerminal(SyntaxNodeKind.SpaceToken, repeat)
    }

    func buildHash(repeat: Int64): RepeatedTerminal {
        RepeatedTerminal(SyntaxNodeKind.HashToken, repeat)
    }

    func buildValuedTerminal(kind: SyntaxNodeKind, value: String): ValuedTerminal {
        ValuedTerminal(kind, value)
    }

    func buildTokenTerminal(kind: TokenKind, value: String, hasEscape!: Bool = false): TokenTerminal {
        TokenTerminal(kind, value, hasEscape: hasEscape)
    }

    func buildNonTerminal(kind: SyntaxNodeKind, children: Array<SyntaxNodeImpl>): NonTerminal {
        NonTerminal(kind, children)
    }

    func buildQuote(isSingle: Bool): Terminal {
        if (isSingle) {
            buildBasicTerminal(SyntaxNodeKind.SingleQuoteToken)
        } else {
            buildBasicTerminal(SyntaxNodeKind.DoubleQuoteToken)
        }
    }

    func buildTripleQuote(isSingle: Bool): Terminal {
        if (isSingle) {
            buildBasicTerminal(SyntaxNodeKind.TripleSingleQuoteToken)
        } else {
            buildBasicTerminal(SyntaxNodeKind.TripleDoubleQuoteToken)
        }
    }

    func buildRuneLiteral(value: ValuedTerminal, isSingle: Bool): NonTerminal {
        let ret = ArrayList<SyntaxNodeImpl>()
        let quoteToken = buildQuote(isSingle)
        let prefix = buildBasicTerminal(SyntaxNodeKind.RunePrefixToken)
        ret.add(all: [prefix, quoteToken, value, quoteToken])
        buildNonTerminal(SyntaxNodeKind.RuneLiteral, ret.toArray())
    }

    func buildMultiLineRawStringLiteral(value: ValuedTerminal, delimiterNum: Int64, isSingle: Bool): NonTerminal {
        let ret = ArrayList<SyntaxNodeImpl>()
        let quoteToken = buildQuote(isSingle)
        let hashToken = buildHash(delimiterNum)
        ret.add(all: [hashToken, quoteToken, value, quoteToken, hashToken])
        buildNonTerminal(SyntaxNodeKind.MultiLineRawStringLiteral, ret.toArray())
    }
}
