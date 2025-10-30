/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.ArrayList

class SyntaxNodeImplCreator {
    private init() {}

    // import
    static func createParameterListImpl(parameters: Array<Parameter>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..parameters.size) {
            parts.add(parameters[i].nodeImpl)
            if (i < parameters.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParameterList, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createImportListImpl(contents: ImportContent, kind: ImportKind, modifier: Option<Modifier>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        if (let Some(m) <- modifier) {
            parts.add(m.nodeImpl)
            parts.add(builder.buildSpace(1))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ImportToken))
        parts.add(builder.buildSpace(1))
        parts.add(contents.nodeImpl)
        match (kind) {
            case ImportKind.All | ImportKind.Alias | ImportKind.Multi | ImportKind.Single => ()
            case _ => throw Exception("Init ImportList: ImportKind error")
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportSpec, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createImportSingleImpl(prefixes: Array<String>, identifier: String, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportSingle, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createImportAliasImpl(prefixes: Array<String>, identifier: String, alias: String, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            if (i < prefixes.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
            }
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AsToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, alias))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportAlias, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createImportAllImpl(prefixes: Array<String>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.MulToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportAll, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createImportMultiImpl(prefixes: Array<String>, contents: Array<ImportContent>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..contents.size) {
            parts.add(contents[i].nodeImpl)
            if (i < contents.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportMulti, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // expr
    static func createForInExprImpl(body: Block, expr: Expr, pattern: Pattern, patternGuard: Option<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (pattern.nodeImpl.kind != SyntaxNodeKind.WildcardPattern && pattern.nodeImpl.kind != SyntaxNodeKind.VarBindingPattern && pattern.nodeImpl.kind != SyntaxNodeKind.TuplePattern && pattern.nodeImpl.kind != SyntaxNodeKind.EnumPattern) {
            throw Exception("Init ForInExpr: invalid pattern")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ForToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(pattern.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.InToken))
        parts.add(builder.buildSpace(1))
        parts.add(expr.nodeImpl)
        if (let Some(p) <- patternGuard) {
            parts.add(builder.buildSpace(1))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WhereToken))
            parts.add(builder.buildSpace(1))
            parts.add(p.nodeImpl)
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        parts.add(builder.buildSpace(1))
        parts.add(body.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ForInExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createReturnExprImpl(retVal: Option<Expr>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ReturnToken))
        if (let Some(v) <- retVal) {
            parts.add(builder.buildSpace(1))
            parts.add(v.nodeImpl)
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ReturnExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createVArrayExprImpl(argument: Argument, vArrayType: VArrayType, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(vArrayType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(argument.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VArrayExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createUnaryExprImpl(opKind: UnaryOpKind, operand: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        match (opKind) {
            case UnaryOpKind.Not => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.NotToken))
            case UnaryOpKind.Sub => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.SubToken))
            case _ => throw Exception("Init UnaryExpr: opKind error")
        }
        parts.add(operand.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.UnaryExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createQuoteExprImpl(tokensOrRefExpr: Array<QuoteExprContent>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.QuoteToken))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..tokensOrRefExpr.size) {
            match (tokensOrRefExpr[i]) {
                case QuoteExprContent.TokenPart(t) => parts.add(t.nodeImpl)
                case QuoteExprContent.QuoteInterpolation(q) => parts.add(q.nodeImpl)
                case _ => throw Exception("Init QuoteExpr: QuoteExprContent error")
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.QuoteExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createQuoteTokenImpl(content: Tokens, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        // TODO: is this right ?
        let tokenArray = ArrayList<SyntaxNodeImpl>()
        for (tok in content) {
            parts.add(builder.buildTokenTerminal(tok.kind, tok.value))
            if (tok.kind != TokenKind.NL) {
                parts.add(builder.buildSpace(1))
            }
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.QuoteTokenExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createQuoteInterpolationExprImpl(expr: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(expr.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.QuoteInterpolationExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createTrailingClosureExprImpl(callee: Expr, arguments: Array<Argument>, trailingLambdaExpr: Lambda, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init TrailingClosureExpr: invalid callee")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(callee.nodeImpl)
        if (!arguments.isEmpty()) {
            parts.add(builder.buildSpace(1))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            for (i in 0..arguments.size) {
                parts.add(arguments[i].nodeImpl)
                if (i < arguments.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }
        parts.add(builder.buildSpace(1))
        parts.add(trailingLambdaExpr.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TrailingClosureExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createMacroExpandExprImpl(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init MacroExpandExpr: invalid calleeMacro")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
        parts.add(calleeMacro.nodeImpl)
        if (macroAttrs.size != 0) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            let attrArray = ArrayList<SyntaxNodeImpl>()
            for (tok in macroAttrs) {
                attrArray.add(builder.buildTokenTerminal(tok.kind, tok.value))
            }
            parts.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }
        match (macroInputs) {
            case MacroExpandInput.WithParens(toks) =>
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                let attrArray = ArrayList<SyntaxNodeImpl>()
                for (tok in toks) {
                    attrArray.add(builder.buildTokenTerminal(tok.kind, tok.value))
                }
                parts.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            case MacroExpandInput.WithoutParens(decl) =>
                parts.add(builder.buildNewline(1))
                parts.add(decl.nodeImpl)
            case _ => throw Exception("Init MacroExpandExpr: macroInputs error")
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MacroExpandExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createBinaryExprImpl(lhs: Expr, opKind: BinaryOpKind, rhs: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(lhs.nodeImpl)
        parts.add(builder.buildSpace(1))
        // 根据 opKind 映射到对应 token
        let opToken = match (opKind) {
            case BinaryOpKind.Add => SyntaxNodeKind.AddToken
            case BinaryOpKind.And => SyntaxNodeKind.AndToken
            case BinaryOpKind.BitAnd => SyntaxNodeKind.BitAndToken
            case BinaryOpKind.BitOr => SyntaxNodeKind.BitOrToken
            case BinaryOpKind.BitXor => SyntaxNodeKind.BitXorToken
            case BinaryOpKind.Coalescing => SyntaxNodeKind.CoalescingToken
            case BinaryOpKind.Composition => SyntaxNodeKind.CompositionToken
            case BinaryOpKind.Div => SyntaxNodeKind.DivToken
            case BinaryOpKind.Equal => SyntaxNodeKind.EqualToken
            case BinaryOpKind.Exp => SyntaxNodeKind.ExpToken
            case BinaryOpKind.Ge => SyntaxNodeKind.GeToken
            case BinaryOpKind.Gt => SyntaxNodeKind.GtToken
            case BinaryOpKind.Le => SyntaxNodeKind.LeToken
            case BinaryOpKind.LShift => SyntaxNodeKind.LShiftToken
            case BinaryOpKind.Lt => SyntaxNodeKind.LtToken
            case BinaryOpKind.Mod => SyntaxNodeKind.ModToken
            case BinaryOpKind.Mul => SyntaxNodeKind.MulToken
            case BinaryOpKind.NotEq => SyntaxNodeKind.NotEqToken
            case BinaryOpKind.Or => SyntaxNodeKind.OrToken
            case BinaryOpKind.Pipeline => SyntaxNodeKind.PipelineToken
            case BinaryOpKind.RShift => SyntaxNodeKind.RShiftToken
            case BinaryOpKind.Sub => SyntaxNodeKind.SubToken
            case _ => throw Exception("Init BinaryExpr: invalid opKind")
        }
        parts.add(builder.buildBasicTerminal(opToken))
        parts.add(builder.buildSpace(1))
        parts.add(rhs.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.BinaryExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // RangeExpr: start .. end : step   or   start ..= end : step
    static func createRangeExprImpl(start: Option<Expr>, kind: RangeKind, end: Option<Expr>, step: Option<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        if (let Some(s) <- start) {
            parts.add(s.nodeImpl)
        }
        let rangeToken = match (kind) {
            case RangeKind.RangeOp => SyntaxNodeKind.RangeOpToken
            case RangeKind.ClosedRangeOp => SyntaxNodeKind.ClosedRangeOpToken
            case _ => throw Exception("Init RangeExpr: invalid RangeKind")
        }
        parts.add(builder.buildBasicTerminal(rangeToken))
        if (let Some(e) <- end) {
            parts.add(e.nodeImpl)
        }
        if (let Some(st) <- step) {
            parts.add(builder.buildSpace(1))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            parts.add(builder.buildSpace(1))
            parts.add(st.nodeImpl)
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.RangeExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createIncOrDecExprImpl(kind: IncOrDecOpKind, operand: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(operand.nodeImpl)
        match (kind) {
            case IncOrDecOpKind.Incr => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.IncrToken))
            case IncOrDecOpKind.Decr => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DecrToken))
            case _ => throw Exception("Init IncOrDecExpr: invalid opKind")
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.IncOrDecExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createParenExprImpl(subExpr: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(subExpr.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParenExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createCallExprImpl(callee: Expr, arguments: Array<Argument>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(callee.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..arguments.size) {
            parts.add(arguments[i].nodeImpl)
            if (i < arguments.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.CallExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createIsExprImpl(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.IsToken))
        parts.add(builder.buildSpace(1))
        parts.add(targetTypeAnnotation.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.IsExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createAsExprImpl(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AsToken))
        parts.add(builder.buildSpace(1))
        parts.add(targetTypeAnnotation.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.AsExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createTypeConvExprImpl(targetTypeAnnotation: AtomicType, srcVal: Expr, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(targetTypeAnnotation.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TypeConvExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createMatchCaseImpl(patterns: Array<Pattern>, patternGuardCond: Option<Expr>, caseCond: Option<Expr>,
        body: Array<SyntaxTreeNode>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CaseToken))
        parts.add(builder.buildSpace(1))
        if (!patterns.isEmpty()) {
            for (i in 0..patterns.size) {
                parts.add(patterns[i].nodeImpl)
                if (i < patterns.size - 1) {
                    parts.add(builder.buildSpace(1))
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildSpace(1))
            if (let Some(pcond) <- patternGuardCond) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WhereToken))
                parts.add(builder.buildSpace(1))
                parts.add(pcond.nodeImpl)
                parts.add(builder.buildSpace(1))
            }
        } else if (let Some(cond) <- caseCond) {
            parts.add(cond.nodeImpl)
            parts.add(builder.buildSpace(1))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DoubleArrowToken))
        parts.add(builder.buildSpace(1))
        let matchCaseBody = ArrayList<SyntaxNodeImpl>()
        for (i in 0..body.size) {
            if (!body[i].nodeImpl.kind.isExpr() && body[i].nodeImpl.kind != SyntaxNodeKind.FuncDecl && body[i].nodeImpl.kind != SyntaxNodeKind.VarDecl) {
                throw Exception("Init MatchCase: invalid body")
            }
            matchCaseBody.add(body[i].nodeImpl)
            if (i < body.size - 1) {
                matchCaseBody.add(builder.buildNewline(1))
            }
        }
        parts.add(builder.buildNonTerminal(SyntaxNodeKind.MatchCaseBody, matchCaseBody.toArray()))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MatchCase, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createCatchPatternImpl(pattern: Pattern, exceptionType: Array<TypeAnnotation>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(pattern.nodeImpl)
        if (!exceptionType.isEmpty()) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            parts.add(builder.buildSpace(1))
            for (i in 0..exceptionType.size) {
                parts.add(exceptionType[i].nodeImpl)
                if (i < exceptionType.size - 1) {
                    parts.add(builder.buildSpace(1))
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
                    parts.add(builder.buildSpace(1))
                }
            }
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.CatchPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createBreakExprImpl(comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BreakToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.BreakExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createContinueExprImpl(comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ContinueToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ContinueExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createCallExprImpl(callee: Expr, args: Array<Expr>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init CallExpr: invalid callee")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(callee.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        if (!args.isEmpty()) {
            for (i in 0..args.size) {
                parts.add(args[i].nodeImpl)
                if (i < args.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.CallExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createDisjunctionConditionImpl(cond: Array<ConjunctionCondition>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..cond.size) {
            parts.add(cond[i].nodeImpl)
            if (i < cond.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.OrToken))
                parts.add(builder.buildSpace(1))
            }
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.DisjunctionCondition, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createConjunctionConditionImpl(cond: Array<AtomicCondition>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..cond.size) {
            match (cond[i]) {
                case AtomicCondition.Expression(expr) => parts.add(expr.nodeImpl)
                case AtomicCondition.LetPatternCondition(letPattern) => parts.add(letPattern.nodeImpl)
                case AtomicCondition.ParenConditionConstructor(parenCondition) => parts.add(parenCondition.nodeImpl)
                case _ => throw Exception("Init ConjunctionCondition: invalid condition")
            }
            if (i < cond.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AndToken))
                parts.add(builder.buildSpace(1))
            }
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ConjunctionCondition, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createParenConditionImpl(cond: DisjunctionCondition, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(cond.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParenCondition, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createLetPatternImpl(expr: Expr, patterns: Array<Pattern>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LetToken))
        parts.add(builder.buildSpace(1))
        for (i in 0..patterns.size) {
            parts.add(patterns[i].nodeImpl)
            if (i < patterns.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BitOrToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BackArrowToken))
        parts.add(builder.buildSpace(1))
        parts.add(expr.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.LetPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createStrInterpolationContentImpl(interpolationBlock: Block, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(interpolationBlock.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.InterpolationExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createConstPatternImpl(litConstExpr: LitConstExpr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(litConstExpr.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ConstPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createVarPatternImpl(name: String, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VarBindingPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // EnumPattern: case Year(n) => ...
    static func createEnumPatternImpl(enumConstructor: SymbolRef, enumType: Option<CompositeType>,
        subPatterns: Array<Pattern>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()

        // 构造 enumType 前缀（如 p1.p0.E<Int64>）
        if (let Some(e) <- enumType) {
            parts.add(e.nodeImpl)
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        // 构造构造器标识符
        parts.add(enumConstructor.nodeImpl)
        if (!subPatterns.isEmpty()) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            for (i in 0..subPatterns.size) {
                parts.add(subPatterns[i].nodeImpl)
                if (i < subPatterns.size - 1) {
                    parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    parts.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.EnumPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createVarOrEnumPatternImpl(identifier: String, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VarOrEnumPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // TypePattern: case x: T => ...
    static func createTypePatternImpl(subPattern: Pattern, patternType: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(subPattern.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        parts.add(builder.buildSpace(1))
        parts.add(patternType.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TypePattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // TuplePattern: case (a, b) => ...
    static func createTuplePatternImpl(subPatterns: Array<Pattern>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..subPatterns.size) {
            parts.add(subPatterns[i].nodeImpl)
            if (i < subPatterns.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TuplePattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // WildcardPattern: case _ => ...
    static func createWildcardPatternImpl(comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WildcardToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.WildcardPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createAtomicTypeImpl(kind: AtomicTypeKind, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let tokenKind = match (kind) {
            case AtomicTypeKind.BoolType => SyntaxNodeKind.BooleanToken
            case AtomicTypeKind.Float16Type => SyntaxNodeKind.Float16Token
            case AtomicTypeKind.Float32Type => SyntaxNodeKind.Float32Token
            case AtomicTypeKind.Float64Type => SyntaxNodeKind.Float64Token
            case AtomicTypeKind.Int8Type => SyntaxNodeKind.Int8Token
            case AtomicTypeKind.Int16Type => SyntaxNodeKind.Int16Token
            case AtomicTypeKind.Int32Type => SyntaxNodeKind.Int32Token
            case AtomicTypeKind.Int64Type => SyntaxNodeKind.Int64Token
            case AtomicTypeKind.IntnativeType => SyntaxNodeKind.IntNativeToken
            case AtomicTypeKind.UInt8Type => SyntaxNodeKind.UInt8Token
            case AtomicTypeKind.UInt16Type => SyntaxNodeKind.UInt16Token
            case AtomicTypeKind.UInt32Type => SyntaxNodeKind.UInt32Token
            case AtomicTypeKind.UInt64Type => SyntaxNodeKind.UInt64Token
            case AtomicTypeKind.UIntNativeType => SyntaxNodeKind.UIntNativeToken
            case AtomicTypeKind.RuneType => SyntaxNodeKind.RuneToken
            case AtomicTypeKind.UnitType => SyntaxNodeKind.UnitToken
            case AtomicTypeKind.NothingType => SyntaxNodeKind.NothingToken
            case AtomicTypeKind.ThisType => SyntaxNodeKind.ThisTypeToken
            case _ => throw Exception("Init AtomicType: invalid AtomicTypeKind")
        }
        parts.add(builder.buildBasicTerminal(tokenKind))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.PrimitiveType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createTupleTypeImpl(elements: Array<TypeAnnotation>, labels: Array<String>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (elements.size != labels.size && labels.size != 0) {
            throw Exception("Init TupleType: number of elements and labels mismatch")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..elements.size) {
            if (labels.size != 0) {
                parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, labels[i]))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
                parts.add(builder.buildSpace(1))
            }
            parts.add(elements[i].nodeImpl)
            if (i < elements.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TupleType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createFuncTypeImpl(paramTypes: Array<TypeAnnotation>, labels: Array<String>, retType: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (paramTypes.size != labels.size) {
            throw Exception("Init FuncType: number of parameter types and labels mismatch")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        // 每个 label 有对应的 type
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..labels.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, labels[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            parts.add(builder.buildSpace(1))
            parts.add(paramTypes[i].nodeImpl)
            if (i < labels.size - 1) {
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                parts.add(builder.buildSpace(1))
            }
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ArrowToken))
        parts.add(builder.buildSpace(1))
        parts.add(retType.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.FuncType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createCompositeTypeImpl(name: String, prefixes: Array<String>, typeArguments: Array<TypeAnnotation>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        if (!typeArguments.isEmpty()) {
            let subParts = ArrayList<SyntaxNodeImpl>()
            subParts.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
            for (i in 0..typeArguments.size) {
                subParts.add(typeArguments[i].nodeImpl)
                if (i < typeArguments.size - 1) {
                    subParts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    subParts.add(builder.buildSpace(1))
                }
            }
            subParts.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))
            parts.add(builder.buildNonTerminal(SyntaxNodeKind.TypeArguments, subParts.toArray()))
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.CompositeType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createVArrayTypeImpl(elementType: TypeAnnotation, size: Int64, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.VArrayToken))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        parts.add(elementType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.ValuedLiteral, size.toString()))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VArrayType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createParenTypeImpl(subType: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(subType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParenType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    static func createPrefixTypeImpl(base: TypeAnnotation, prefixOp: PrefixTypeOpKind, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        match (prefixOp) {
            case PrefixTypeOpKind.Quest => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.QuestToken))
            case _ => throw Exception("Init PrefixType: unknown prefixOp type")
        }
        parts.add(base.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.OptionType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }
}
