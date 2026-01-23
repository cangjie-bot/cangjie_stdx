/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

protected func serializePkg(node: SyntaxTreeNode) {
    var arr = Array<UInt8>()
    var fb = Builder(0)
    let syntaxNodeImplList = if (let Some(node) <- (node.nodeImpl as NonTerminal)) {
        node.children
    } else {
        throw Exception("node is not NonTerminal!")
    }
    let childrenType = serializeChildrenType(fb, syntaxNodeImplList)
    let children = serializeChildren(fb, syntaxNodeImplList)

    let pkgNodeImpl = NodeFormat_NonTerminal.createNonTerminal(
        fb, 
        node.nodeImpl.id,
        NodeFormat_NodeImplKind.NodeImplKind_PACKAGE,
        childrenType,
        children)
        
    fb.finish(pkgNodeImpl)
    arr = fb.finishedBytes()
}

private func serializeChildrenType(fb: Builder, syntaxNodeImplList: Array<SyntaxNodeImpl>) {
    fb.startVector(2, syntaxNodeImplList.size, 2)
    for (i in syntaxNodeImplList.size - 1..=0) {
        match (syntaxNodeImplList[i]) {
            case nt: NonTerminal => 
                fb.prependUInt8(EnumNodeFormat_SyntaxNodeImplValues(NodeFormat_SyntaxNodeImpl.SyntaxNodeImpl_NONTERMINAL))
            case vt: ValuedTerminal => 
                fb.prependUInt8(EnumNodeFormat_SyntaxNodeImplValues(NodeFormat_SyntaxNodeImpl.SyntaxNodeImpl_VALUEDTERMINAL))
            case vt: RepeatedTerminal => 
                fb.prependUInt8(EnumNodeFormat_SyntaxNodeImplValues(NodeFormat_SyntaxNodeImpl.SyntaxNodeImpl_REPEATEDTERMINAL))
            case t: Terminal => 
                fb.prependUInt8(EnumNodeFormat_SyntaxNodeImplValues(NodeFormat_SyntaxNodeImpl.SyntaxNodeImpl_TERMINAL))
            case _ => fb.prependUInt8(EnumNodeFormat_SyntaxNodeImplValues(NodeFormat_SyntaxNodeImpl.SyntaxNodeImpl_NONE))
        }
    }
    return fb.endVector(syntaxNodeImplList.size)
}

private func serializeChildren(fb: Builder, syntaxNodeImplList: Array<SyntaxNodeImpl>): UInt32 {
    fb.startVector(4, syntaxNodeImplList.size, 4)
    for (i in syntaxNodeImplList.size - 1..=0) {
        match (syntaxNodeImplList[i]) {
            case nt: NonTerminal => 
                fb.prependUOffsetT(serializeNonTerminal(fb, nt))
            case vt: ValuedTerminal => 
                fb.prependUOffsetT(serializeValuedTerminal(fb, vt))
            case rt: RepeatedTerminal => 
                fb.prependUOffsetT(serializeRepeatedTerminal(fb, rt))
            case t: Terminal => 
                fb.prependUOffsetT(serializeTerminal(fb, t))
            case _ => throw Exception("serializeChildren error")
        }
    }
    return fb.endVector(syntaxNodeImplList.size)
}

private func serializeNonTerminal(fb: Builder, nt: NonTerminal): UInt32  {
    let childrenType = serializeChildrenType(fb, nt.children)
    let children = serializeChildren(fb, nt.children)
    return NodeFormat_NonTerminal.createNonTerminal(
        fb, 
        nt.id,
        syntaxNodeKindToNodeImplKind(nt.kind),
        childrenType,
        children)
}

private func serializeValuedTerminal(fb: Builder, vt: ValuedTerminal): UInt32  {
    let value = fb.createString(vt.value)
    return NodeFormat_ValuedTerminal.createValuedTerminal(
        fb, 
        vt.id,
        syntaxNodeKindToNodeImplKind(vt.kind),
        value)
}

private func serializeRepeatedTerminal(fb: Builder, rt: RepeatedTerminal): UInt32  {
    return NodeFormat_RepeatedTerminal.createRepeatedTerminal(
        fb, 
        rt.id,
        syntaxNodeKindToNodeImplKind(rt.kind),
        rt.repeat)
}

private func serializeTerminal(fb: Builder, t: Terminal): UInt32  {
    return NodeFormat_Terminal.createTerminal(
        fb, 
        t.id,
        syntaxNodeKindToNodeImplKind(t.kind))
}

private func syntaxNodeKindToNodeImplKind(kind: SyntaxNodeKind): NodeFormat_NodeImplKind {
    match (kind) {
        case SyntaxNodeKind.File => return NodeFormat_NodeImplKind.NodeImplKind_FILE
        case SyntaxNodeKind.Package => return NodeFormat_NodeImplKind.NodeImplKind_PACKAGE
        case SyntaxNodeKind.FeaturesDirective => return NodeFormat_NodeImplKind.NodeImplKind_FEATURESDIRECTIVE
        case SyntaxNodeKind.FeaturesSet => return NodeFormat_NodeImplKind.NodeImplKind_FEATURESSET
        case SyntaxNodeKind.FeatureId => return NodeFormat_NodeImplKind.NodeImplKind_FEATUREID
        case SyntaxNodeKind.PackageSpec => return NodeFormat_NodeImplKind.NodeImplKind_PACKAGESPEC
        case SyntaxNodeKind.PackagePrefixes => return NodeFormat_NodeImplKind.NodeImplKind_PACKAGEPREFIXES
        case SyntaxNodeKind.CatchPattern => return NodeFormat_NodeImplKind.NodeImplKind_CATCHPATTERN
        case SyntaxNodeKind.Argument => return NodeFormat_NodeImplKind.NodeImplKind_ARGUMENT
        case SyntaxNodeKind.Annotation => return NodeFormat_NodeImplKind.NodeImplKind_ANNOTATION
        case SyntaxNodeKind.AnnotationList => return NodeFormat_NodeImplKind.NodeImplKind_ANNOTATIONLIST
        case SyntaxNodeKind.TypeArguments => return NodeFormat_NodeImplKind.NodeImplKind_TYPEARGUMENTS
        case SyntaxNodeKind.ModifierList => return NodeFormat_NodeImplKind.NodeImplKind_MODIFIERLIST
        case SyntaxNodeKind.ParameterList => return NodeFormat_NodeImplKind.NodeImplKind_PARAMETERLIST
        case SyntaxNodeKind.GenericConstraints => return NodeFormat_NodeImplKind.NodeImplKind_GENERICCONSTRAINTS
        case SyntaxNodeKind.GenericConstraint => return NodeFormat_NodeImplKind.NodeImplKind_GENERICCONSTRAINT
        case SyntaxNodeKind.MatchCase => return NodeFormat_NodeImplKind.NodeImplKind_MATCHCASE
        case SyntaxNodeKind.MatchCaseBody => return NodeFormat_NodeImplKind.NodeImplKind_MATCHCASEBODY
        case SyntaxNodeKind.Pattern => return NodeFormat_NodeImplKind.NodeImplKind_PATTERN
        case SyntaxNodeKind.Body => return NodeFormat_NodeImplKind.NodeImplKind_BODY
        case SyntaxNodeKind.DisjunctionCondition => return NodeFormat_NodeImplKind.NodeImplKind_DISJUNCTIONCONDITION
        case SyntaxNodeKind.ConjunctionCondition => return NodeFormat_NodeImplKind.NodeImplKind_CONJUNCTIONCONDITION
        case SyntaxNodeKind.ParenCondition => return NodeFormat_NodeImplKind.NodeImplKind_PARENCONDITION
        case SyntaxNodeKind.LetPattern => return NodeFormat_NodeImplKind.NodeImplKind_LETPATTERN
        case SyntaxNodeKind.AtomicCondition => return NodeFormat_NodeImplKind.NodeImplKind_ATOMICCONDITION
        case SyntaxNodeKind.TokenList => return NodeFormat_NodeImplKind.NodeImplKind_TOKENLIST
        case SyntaxNodeKind.Comment => return NodeFormat_NodeImplKind.NodeImplKind_COMMENT
        case SyntaxNodeKind.CommentGroup => return NodeFormat_NodeImplKind.NodeImplKind_COMMENTGROUP
        case SyntaxNodeKind.CommentGroupList => return NodeFormat_NodeImplKind.NodeImplKind_COMMENTGROUPLIST
        case SyntaxNodeKind.Modifier => return NodeFormat_NodeImplKind.NodeImplKind_MODIFIER
        case SyntaxNodeKind.GenericParam => return NodeFormat_NodeImplKind.NodeImplKind_GENERICPARAM
        case SyntaxNodeKind.ImportSpec => return NodeFormat_NodeImplKind.NodeImplKind_IMPORTSPEC
        case SyntaxNodeKind.ImportAlias => return NodeFormat_NodeImplKind.NodeImplKind_IMPORTALIAS
        case SyntaxNodeKind.ImportAll => return NodeFormat_NodeImplKind.NodeImplKind_IMPORTALL
        case SyntaxNodeKind.ImportMulti => return NodeFormat_NodeImplKind.NodeImplKind_IMPORTMULTI
        case SyntaxNodeKind.ImportSingle => return NodeFormat_NodeImplKind.NodeImplKind_IMPORTSINGLE
        case SyntaxNodeKind.PrimitiveType => return NodeFormat_NodeImplKind.NodeImplKind_PRIMITIVETYPE
        case SyntaxNodeKind.RefType => return NodeFormat_NodeImplKind.NodeImplKind_REFTYPE
        case SyntaxNodeKind.FuncType => return NodeFormat_NodeImplKind.NodeImplKind_FUNCTYPE
        case SyntaxNodeKind.ThisType => return NodeFormat_NodeImplKind.NodeImplKind_THISTYPE
        case SyntaxNodeKind.ParenType => return NodeFormat_NodeImplKind.NodeImplKind_PARENTYPE
        case SyntaxNodeKind.QualifiedType => return NodeFormat_NodeImplKind.NodeImplKind_QUALIFIEDTYPE
        case SyntaxNodeKind.OptionType => return NodeFormat_NodeImplKind.NodeImplKind_OPTIONTYPE
        case SyntaxNodeKind.OptionalType => return NodeFormat_NodeImplKind.NodeImplKind_OPTIONALTYPE
        case SyntaxNodeKind.VArrayType => return NodeFormat_NodeImplKind.NodeImplKind_VARRAYTYPE
        case SyntaxNodeKind.TupleType => return NodeFormat_NodeImplKind.NodeImplKind_TUPLETYPE
        case SyntaxNodeKind.CompositeType => return NodeFormat_NodeImplKind.NodeImplKind_COMPOSITETYPE
        case SyntaxNodeKind.MainDecl => return NodeFormat_NodeImplKind.NodeImplKind_MAINDECL
        case SyntaxNodeKind.VarDecl => return NodeFormat_NodeImplKind.NodeImplKind_VARDECL
        case SyntaxNodeKind.FuncDecl => return NodeFormat_NodeImplKind.NodeImplKind_FUNCDECL
        case SyntaxNodeKind.FuncParam => return NodeFormat_NodeImplKind.NodeImplKind_FUNCPARAM
        case SyntaxNodeKind.LambdaParam => return NodeFormat_NodeImplKind.NodeImplKind_LAMBDAPARAM
        case SyntaxNodeKind.Block => return NodeFormat_NodeImplKind.NodeImplKind_BLOCK
        case SyntaxNodeKind.TypeAlias => return NodeFormat_NodeImplKind.NodeImplKind_TYPEALIAS
        case SyntaxNodeKind.ClassDecl => return NodeFormat_NodeImplKind.NodeImplKind_CLASSDECL
        case SyntaxNodeKind.PropGetterOrSetter => return NodeFormat_NodeImplKind.NodeImplKind_PROPGETTERORSETTER
        case SyntaxNodeKind.PropDecl => return NodeFormat_NodeImplKind.NodeImplKind_PROPDECL
        case SyntaxNodeKind.StaticInit => return NodeFormat_NodeImplKind.NodeImplKind_STATICINIT
        case SyntaxNodeKind.StructDecl => return NodeFormat_NodeImplKind.NodeImplKind_STRUCTDECL
        case SyntaxNodeKind.InterfaceDecl => return NodeFormat_NodeImplKind.NodeImplKind_INTERFACEDECL
        case SyntaxNodeKind.ExtendDecl => return NodeFormat_NodeImplKind.NodeImplKind_EXTENDDECL
        case SyntaxNodeKind.EnumDecl => return NodeFormat_NodeImplKind.NodeImplKind_ENUMDECL
        case SyntaxNodeKind.EnumConstructor => return NodeFormat_NodeImplKind.NodeImplKind_ENUMCONSTRUCTOR
        case SyntaxNodeKind.MacroDecl => return NodeFormat_NodeImplKind.NodeImplKind_MACRODECL
        case SyntaxNodeKind.MacroExpandDecl => return NodeFormat_NodeImplKind.NodeImplKind_MACROEXPANDDECL
        case SyntaxNodeKind.MacroExpandParam => return NodeFormat_NodeImplKind.NodeImplKind_MACROEXPANDPARAM
        case SyntaxNodeKind.ValuedLiteral => return NodeFormat_NodeImplKind.NodeImplKind_VALUEDLITERAL
        case SyntaxNodeKind.UnitLiteral => return NodeFormat_NodeImplKind.NodeImplKind_UNITLITERAL
        case SyntaxNodeKind.RuneLiteral => return NodeFormat_NodeImplKind.NodeImplKind_RUNELITERAL
        case SyntaxNodeKind.LineStringLiteral => return NodeFormat_NodeImplKind.NodeImplKind_LINESTRINGLITERAL
        case SyntaxNodeKind.MultiLineStringLiteral => return NodeFormat_NodeImplKind.NodeImplKind_MULTILINESTRINGLITERAL
        case SyntaxNodeKind.MultiLineRawStringLiteral => return NodeFormat_NodeImplKind.NodeImplKind_MULTILINERAWSTRINGLITERAL
        case SyntaxNodeKind.ArrayLiteral => return NodeFormat_NodeImplKind.NodeImplKind_ARRAYLITERAL
        case SyntaxNodeKind.TupleLiteral => return NodeFormat_NodeImplKind.NodeImplKind_TUPLELITERAL
        case SyntaxNodeKind.AssignExpr => return NodeFormat_NodeImplKind.NodeImplKind_ASSIGNEXPR
        case SyntaxNodeKind.VArrayExpr => return NodeFormat_NodeImplKind.NodeImplKind_VARRAYEXPR
        case SyntaxNodeKind.MemberAccess => return NodeFormat_NodeImplKind.NodeImplKind_MEMBERACCESS
        case SyntaxNodeKind.UnaryExpr => return NodeFormat_NodeImplKind.NodeImplKind_UNARYEXPR
        case SyntaxNodeKind.BinaryExpr => return NodeFormat_NodeImplKind.NodeImplKind_BINARYEXPR
        case SyntaxNodeKind.CallExpr => return NodeFormat_NodeImplKind.NodeImplKind_CALLEXPR
        case SyntaxNodeKind.RefExpr => return NodeFormat_NodeImplKind.NodeImplKind_REFEXPR
        case SyntaxNodeKind.IsExpr => return NodeFormat_NodeImplKind.NodeImplKind_ISEXPR
        case SyntaxNodeKind.AsExpr => return NodeFormat_NodeImplKind.NodeImplKind_ASEXPR
        case SyntaxNodeKind.ParenExpr => return NodeFormat_NodeImplKind.NodeImplKind_PARENEXPR
        case SyntaxNodeKind.ReturnExpr => return NodeFormat_NodeImplKind.NodeImplKind_RETURNEXPR
        case SyntaxNodeKind.IncOrDecExpr => return NodeFormat_NodeImplKind.NodeImplKind_INCORDECEXPR
        case SyntaxNodeKind.RangeExpr => return NodeFormat_NodeImplKind.NodeImplKind_RANGEEXPR
        case SyntaxNodeKind.TypeConvExpr => return NodeFormat_NodeImplKind.NodeImplKind_TYPECONVEXPR
        case SyntaxNodeKind.OptionalExpr => return NodeFormat_NodeImplKind.NodeImplKind_OPTIONALEXPR
        case SyntaxNodeKind.BreakExpr => return NodeFormat_NodeImplKind.NodeImplKind_BREAKEXPR
        case SyntaxNodeKind.ContinueExpr => return NodeFormat_NodeImplKind.NodeImplKind_CONTINUEEXPR
        case SyntaxNodeKind.SubscriptExpr => return NodeFormat_NodeImplKind.NodeImplKind_SUBSCRIPTEXPR
        case SyntaxNodeKind.Lambda => return NodeFormat_NodeImplKind.NodeImplKind_LAMBDA
        case SyntaxNodeKind.MatchExpr => return NodeFormat_NodeImplKind.NodeImplKind_MATCHEXPR
        case SyntaxNodeKind.TryCatch => return NodeFormat_NodeImplKind.NodeImplKind_TRYCATCH
        case SyntaxNodeKind.ThrowExpr => return NodeFormat_NodeImplKind.NodeImplKind_THROWEXPR
        case SyntaxNodeKind.SynchronizedExpr => return NodeFormat_NodeImplKind.NodeImplKind_SYNCHRONIZEDEXPR
        case SyntaxNodeKind.SpawnExpr => return NodeFormat_NodeImplKind.NodeImplKind_SPAWNEXPR
        case SyntaxNodeKind.IfExpr => return NodeFormat_NodeImplKind.NodeImplKind_IFEXPR
        case SyntaxNodeKind.WhileExpr => return NodeFormat_NodeImplKind.NodeImplKind_WHILEEXPR
        case SyntaxNodeKind.DoWhileExpr => return NodeFormat_NodeImplKind.NodeImplKind_DOWHILEEXPR
        case SyntaxNodeKind.ForInExpr => return NodeFormat_NodeImplKind.NodeImplKind_FORINEXPR
        case SyntaxNodeKind.JumpExpr => return NodeFormat_NodeImplKind.NodeImplKind_JUMPEXPR
        case SyntaxNodeKind.LambdaExpr => return NodeFormat_NodeImplKind.NodeImplKind_LAMBDAEXPR
        case SyntaxNodeKind.TryExpr => return NodeFormat_NodeImplKind.NodeImplKind_TRYEXPR
        case SyntaxNodeKind.InterpolationExpr => return NodeFormat_NodeImplKind.NodeImplKind_INTERPOLATIONEXPR
        case SyntaxNodeKind.QuoteTokenExpr => return NodeFormat_NodeImplKind.NodeImplKind_QUOTETOKENEXPR
        case SyntaxNodeKind.QuoteExpr => return NodeFormat_NodeImplKind.NodeImplKind_QUOTEEXPR
        case SyntaxNodeKind.QuoteInterpolationExpr => return NodeFormat_NodeImplKind.NodeImplKind_QUOTEINTERPOLATIONEXPR
        case SyntaxNodeKind.TrailingClosureExpr => return NodeFormat_NodeImplKind.NodeImplKind_TRAILINGCLOSUREEXPR
        case SyntaxNodeKind.UnsafeExpr => return NodeFormat_NodeImplKind.NodeImplKind_UNSAFEEXPR
        case SyntaxNodeKind.MacroExpandExpr => return NodeFormat_NodeImplKind.NodeImplKind_MACROEXPANDEXPR
        case SyntaxNodeKind.ExceptTypePattern => return NodeFormat_NodeImplKind.NodeImplKind_EXCEPTTYPEPATTERN
        case SyntaxNodeKind.WildcardPattern => return NodeFormat_NodeImplKind.NodeImplKind_WILDCARDPATTERN
        case SyntaxNodeKind.ConstPattern => return NodeFormat_NodeImplKind.NodeImplKind_CONSTPATTERN
        case SyntaxNodeKind.VarBindingPattern => return NodeFormat_NodeImplKind.NodeImplKind_VARBINDINGPATTERN
        case SyntaxNodeKind.VarOrEnumPattern => return NodeFormat_NodeImplKind.NodeImplKind_VARORENUMPATTERN
        case SyntaxNodeKind.TuplePattern => return NodeFormat_NodeImplKind.NodeImplKind_TUPLEPATTERN
        case SyntaxNodeKind.TypePattern => return NodeFormat_NodeImplKind.NodeImplKind_TYPEPATTERN
        case SyntaxNodeKind.EnumPattern => return NodeFormat_NodeImplKind.NodeImplKind_ENUMPATTERN
        case SyntaxNodeKind.Token => return NodeFormat_NodeImplKind.NodeImplKind_TOKEN
        case SyntaxNodeKind.DotToken => return NodeFormat_NodeImplKind.NodeImplKind_DOTTOKEN
        case SyntaxNodeKind.CommaToken => return NodeFormat_NodeImplKind.NodeImplKind_COMMATOKEN
        case SyntaxNodeKind.LParenToken => return NodeFormat_NodeImplKind.NodeImplKind_LPARENTOKEN
        case SyntaxNodeKind.RParenToken => return NodeFormat_NodeImplKind.NodeImplKind_RPARENTOKEN
        case SyntaxNodeKind.LSquareToken => return NodeFormat_NodeImplKind.NodeImplKind_LSQUARETOKEN
        case SyntaxNodeKind.RSquareToken => return NodeFormat_NodeImplKind.NodeImplKind_RSQUARETOKEN
        case SyntaxNodeKind.LCurlToken => return NodeFormat_NodeImplKind.NodeImplKind_LCURLTOKEN
        case SyntaxNodeKind.RCurlToken => return NodeFormat_NodeImplKind.NodeImplKind_RCURLTOKEN
        case SyntaxNodeKind.ExpToken => return NodeFormat_NodeImplKind.NodeImplKind_EXPTOKEN
        case SyntaxNodeKind.MulToken => return NodeFormat_NodeImplKind.NodeImplKind_MULTOKEN
        case SyntaxNodeKind.ModToken => return NodeFormat_NodeImplKind.NodeImplKind_MODTOKEN
        case SyntaxNodeKind.DivToken => return NodeFormat_NodeImplKind.NodeImplKind_DIVTOKEN
        case SyntaxNodeKind.AddToken => return NodeFormat_NodeImplKind.NodeImplKind_ADDTOKEN
        case SyntaxNodeKind.SubToken => return NodeFormat_NodeImplKind.NodeImplKind_SUBTOKEN
        case SyntaxNodeKind.IncrToken => return NodeFormat_NodeImplKind.NodeImplKind_INCRTOKEN
        case SyntaxNodeKind.DecrToken => return NodeFormat_NodeImplKind.NodeImplKind_DECRTOKEN
        case SyntaxNodeKind.AndToken => return NodeFormat_NodeImplKind.NodeImplKind_ANDTOKEN
        case SyntaxNodeKind.OrToken => return NodeFormat_NodeImplKind.NodeImplKind_ORTOKEN
        case SyntaxNodeKind.CoalescingToken => return NodeFormat_NodeImplKind.NodeImplKind_COALESCINGTOKEN
        case SyntaxNodeKind.PipelineToken => return NodeFormat_NodeImplKind.NodeImplKind_PIPELINETOKEN
        case SyntaxNodeKind.CompositionToken => return NodeFormat_NodeImplKind.NodeImplKind_COMPOSITIONTOKEN
        case SyntaxNodeKind.NotToken => return NodeFormat_NodeImplKind.NodeImplKind_NOTTOKEN
        case SyntaxNodeKind.BitAndToken => return NodeFormat_NodeImplKind.NodeImplKind_BITANDTOKEN
        case SyntaxNodeKind.BitOrToken => return NodeFormat_NodeImplKind.NodeImplKind_BITORTOKEN
        case SyntaxNodeKind.BitXorToken => return NodeFormat_NodeImplKind.NodeImplKind_BITXORTOKEN
        case SyntaxNodeKind.BitNotToken => return NodeFormat_NodeImplKind.NodeImplKind_BITNOTTOKEN
        case SyntaxNodeKind.LShiftToken => return NodeFormat_NodeImplKind.NodeImplKind_LSHIFTTOKEN
        case SyntaxNodeKind.RShiftToken => return NodeFormat_NodeImplKind.NodeImplKind_RSHIFTTOKEN
        case SyntaxNodeKind.ColonToken => return NodeFormat_NodeImplKind.NodeImplKind_COLONTOKEN
        case SyntaxNodeKind.SemiToken => return NodeFormat_NodeImplKind.NodeImplKind_SEMITOKEN
        case SyntaxNodeKind.AssignToken => return NodeFormat_NodeImplKind.NodeImplKind_ASSIGNTOKEN
        case SyntaxNodeKind.AddAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_ADDASSIGNTOKEN
        case SyntaxNodeKind.SubAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_SUBASSIGNTOKEN
        case SyntaxNodeKind.MulAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_MULASSIGNTOKEN
        case SyntaxNodeKind.ExpAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_EXPASSIGNTOKEN
        case SyntaxNodeKind.DivAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_DIVASSIGNTOKEN
        case SyntaxNodeKind.ModAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_MODASSIGNTOKEN
        case SyntaxNodeKind.AndAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_ANDASSIGNTOKEN
        case SyntaxNodeKind.OrAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_ORASSIGNTOKEN
        case SyntaxNodeKind.BitAndAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_BITANDASSIGNTOKEN
        case SyntaxNodeKind.BitOrAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_BITORASSIGNTOKEN
        case SyntaxNodeKind.BitXorAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_BITXORASSIGNTOKEN
        case SyntaxNodeKind.LShiftAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_LSHIFTASSIGNTOKEN
        case SyntaxNodeKind.RShiftAssignToken => return NodeFormat_NodeImplKind.NodeImplKind_RSHIFTASSIGNTOKEN
        case SyntaxNodeKind.ArrowToken => return NodeFormat_NodeImplKind.NodeImplKind_ARROWTOKEN
        case SyntaxNodeKind.BackArrowToken => return NodeFormat_NodeImplKind.NodeImplKind_BACKARROWTOKEN
        case SyntaxNodeKind.DoubleArrowToken => return NodeFormat_NodeImplKind.NodeImplKind_DOUBLEARROWTOKEN
        case SyntaxNodeKind.RangeOpToken => return NodeFormat_NodeImplKind.NodeImplKind_RANGEOPTOKEN
        case SyntaxNodeKind.ClosedRangeOpToken => return NodeFormat_NodeImplKind.NodeImplKind_CLOSEDRANGEOPTOKEN
        case SyntaxNodeKind.EllipsisToken => return NodeFormat_NodeImplKind.NodeImplKind_ELLIPSISTOKEN
        case SyntaxNodeKind.HashToken => return NodeFormat_NodeImplKind.NodeImplKind_HASHTOKEN
        case SyntaxNodeKind.AtToken => return NodeFormat_NodeImplKind.NodeImplKind_ATTOKEN
        case SyntaxNodeKind.QuestToken => return NodeFormat_NodeImplKind.NodeImplKind_QUESTTOKEN
        case SyntaxNodeKind.LtToken => return NodeFormat_NodeImplKind.NodeImplKind_LTTOKEN
        case SyntaxNodeKind.GtToken => return NodeFormat_NodeImplKind.NodeImplKind_GTTOKEN
        case SyntaxNodeKind.LeToken => return NodeFormat_NodeImplKind.NodeImplKind_LETOKEN
        case SyntaxNodeKind.GeToken => return NodeFormat_NodeImplKind.NodeImplKind_GETOKEN
        case SyntaxNodeKind.IsToken => return NodeFormat_NodeImplKind.NodeImplKind_ISTOKEN
        case SyntaxNodeKind.AsToken => return NodeFormat_NodeImplKind.NodeImplKind_ASTOKEN
        case SyntaxNodeKind.NotEqToken => return NodeFormat_NodeImplKind.NodeImplKind_NOTEQTOKEN
        case SyntaxNodeKind.EqualToken => return NodeFormat_NodeImplKind.NodeImplKind_EQUALTOKEN
        case SyntaxNodeKind.WildcardToken => return NodeFormat_NodeImplKind.NodeImplKind_WILDCARDTOKEN
        case SyntaxNodeKind.Int8Token => return NodeFormat_NodeImplKind.NodeImplKind_INT8TOKEN
        case SyntaxNodeKind.Int16Token => return NodeFormat_NodeImplKind.NodeImplKind_INT16TOKEN
        case SyntaxNodeKind.Int32Token => return NodeFormat_NodeImplKind.NodeImplKind_INT32TOKEN
        case SyntaxNodeKind.Int64Token => return NodeFormat_NodeImplKind.NodeImplKind_INT64TOKEN
        case SyntaxNodeKind.IntNativeToken => return NodeFormat_NodeImplKind.NodeImplKind_INTNATIVETOKEN
        case SyntaxNodeKind.UInt8Token => return NodeFormat_NodeImplKind.NodeImplKind_UINT8TOKEN
        case SyntaxNodeKind.UInt16Token => return NodeFormat_NodeImplKind.NodeImplKind_UINT16TOKEN
        case SyntaxNodeKind.UInt32Token => return NodeFormat_NodeImplKind.NodeImplKind_UINT32TOKEN
        case SyntaxNodeKind.UInt64Token => return NodeFormat_NodeImplKind.NodeImplKind_UINT64TOKEN
        case SyntaxNodeKind.UIntNativeToken => return NodeFormat_NodeImplKind.NodeImplKind_UINTNATIVETOKEN
        case SyntaxNodeKind.Float16Token => return NodeFormat_NodeImplKind.NodeImplKind_FLOAT16TOKEN
        case SyntaxNodeKind.Float32Token => return NodeFormat_NodeImplKind.NodeImplKind_FLOAT32TOKEN
        case SyntaxNodeKind.Float64Token => return NodeFormat_NodeImplKind.NodeImplKind_FLOAT64TOKEN
        case SyntaxNodeKind.RuneToken => return NodeFormat_NodeImplKind.NodeImplKind_RUNETOKEN
        case SyntaxNodeKind.BooleanToken => return NodeFormat_NodeImplKind.NodeImplKind_BOOLEANTOKEN
        case SyntaxNodeKind.NothingToken => return NodeFormat_NodeImplKind.NodeImplKind_NOTHINGTOKEN
        case SyntaxNodeKind.UnitToken => return NodeFormat_NodeImplKind.NodeImplKind_UNITTOKEN
        case SyntaxNodeKind.StructToken => return NodeFormat_NodeImplKind.NodeImplKind_STRUCTTOKEN
        case SyntaxNodeKind.EnumToken => return NodeFormat_NodeImplKind.NodeImplKind_ENUMTOKEN
        case SyntaxNodeKind.VArrayToken => return NodeFormat_NodeImplKind.NodeImplKind_VARRAYTOKEN
        case SyntaxNodeKind.ThisTypeToken => return NodeFormat_NodeImplKind.NodeImplKind_THISTYPETOKEN
        case SyntaxNodeKind.FeaturesToken => return NodeFormat_NodeImplKind.NodeImplKind_FEATURESTOKEN
        case SyntaxNodeKind.PackageToken => return NodeFormat_NodeImplKind.NodeImplKind_PACKAGETOKEN
        case SyntaxNodeKind.ImportToken => return NodeFormat_NodeImplKind.NodeImplKind_IMPORTTOKEN
        case SyntaxNodeKind.ClassToken => return NodeFormat_NodeImplKind.NodeImplKind_CLASSTOKEN
        case SyntaxNodeKind.InterfaceToken => return NodeFormat_NodeImplKind.NodeImplKind_INTERFACETOKEN
        case SyntaxNodeKind.FuncToken => return NodeFormat_NodeImplKind.NodeImplKind_FUNCTOKEN
        case SyntaxNodeKind.MacroToken => return NodeFormat_NodeImplKind.NodeImplKind_MACROTOKEN
        case SyntaxNodeKind.QuoteToken => return NodeFormat_NodeImplKind.NodeImplKind_QUOTETOKEN
        case SyntaxNodeKind.DollarToken => return NodeFormat_NodeImplKind.NodeImplKind_DOLLARTOKEN
        case SyntaxNodeKind.LetToken => return NodeFormat_NodeImplKind.NodeImplKind_LETTOKEN
        case SyntaxNodeKind.VarToken => return NodeFormat_NodeImplKind.NodeImplKind_VARTOKEN
        case SyntaxNodeKind.ConstToken => return NodeFormat_NodeImplKind.NodeImplKind_CONSTTOKEN
        case SyntaxNodeKind.TypeToken => return NodeFormat_NodeImplKind.NodeImplKind_TYPETOKEN
        case SyntaxNodeKind.InitToken => return NodeFormat_NodeImplKind.NodeImplKind_INITTOKEN
        case SyntaxNodeKind.ThisToken => return NodeFormat_NodeImplKind.NodeImplKind_THISTOKEN
        case SyntaxNodeKind.SuperToken => return NodeFormat_NodeImplKind.NodeImplKind_SUPERTOKEN
        case SyntaxNodeKind.IfToken => return NodeFormat_NodeImplKind.NodeImplKind_IFTOKEN
        case SyntaxNodeKind.ElseToken => return NodeFormat_NodeImplKind.NodeImplKind_ELSETOKEN
        case SyntaxNodeKind.CaseToken => return NodeFormat_NodeImplKind.NodeImplKind_CASETOKEN
        case SyntaxNodeKind.TryToken => return NodeFormat_NodeImplKind.NodeImplKind_TRYTOKEN
        case SyntaxNodeKind.CatchToken => return NodeFormat_NodeImplKind.NodeImplKind_CATCHTOKEN
        case SyntaxNodeKind.FinallyToken => return NodeFormat_NodeImplKind.NodeImplKind_FINALLYTOKEN
        case SyntaxNodeKind.ForToken => return NodeFormat_NodeImplKind.NodeImplKind_FORTOKEN
        case SyntaxNodeKind.DoToken => return NodeFormat_NodeImplKind.NodeImplKind_DOTOKEN
        case SyntaxNodeKind.WhileToken => return NodeFormat_NodeImplKind.NodeImplKind_WHILETOKEN
        case SyntaxNodeKind.ThrowToken => return NodeFormat_NodeImplKind.NodeImplKind_THROWTOKEN
        case SyntaxNodeKind.ReturnToken => return NodeFormat_NodeImplKind.NodeImplKind_RETURNTOKEN
        case SyntaxNodeKind.ContinueToken => return NodeFormat_NodeImplKind.NodeImplKind_CONTINUETOKEN
        case SyntaxNodeKind.BreakToken => return NodeFormat_NodeImplKind.NodeImplKind_BREAKTOKEN
        case SyntaxNodeKind.InToken => return NodeFormat_NodeImplKind.NodeImplKind_INTOKEN
        case SyntaxNodeKind.NotInToken => return NodeFormat_NodeImplKind.NodeImplKind_NOTINTOKEN
        case SyntaxNodeKind.MatchToken => return NodeFormat_NodeImplKind.NodeImplKind_MATCHTOKEN
        case SyntaxNodeKind.WhereToken => return NodeFormat_NodeImplKind.NodeImplKind_WHERETOKEN
        case SyntaxNodeKind.ExtendToken => return NodeFormat_NodeImplKind.NodeImplKind_EXTENDTOKEN
        case SyntaxNodeKind.WithToken => return NodeFormat_NodeImplKind.NodeImplKind_WITHTOKEN
        case SyntaxNodeKind.PropToken => return NodeFormat_NodeImplKind.NodeImplKind_PROPTOKEN
        case SyntaxNodeKind.GetToken => return NodeFormat_NodeImplKind.NodeImplKind_GETTOKEN
        case SyntaxNodeKind.SetToken => return NodeFormat_NodeImplKind.NodeImplKind_SETTOKEN
        case SyntaxNodeKind.StaticToken => return NodeFormat_NodeImplKind.NodeImplKind_STATICTOKEN
        case SyntaxNodeKind.PublicToken => return NodeFormat_NodeImplKind.NodeImplKind_PUBLICTOKEN
        case SyntaxNodeKind.PrivateToken => return NodeFormat_NodeImplKind.NodeImplKind_PRIVATETOKEN
        case SyntaxNodeKind.InternalToken => return NodeFormat_NodeImplKind.NodeImplKind_INTERNALTOKEN
        case SyntaxNodeKind.ProtectedToken => return NodeFormat_NodeImplKind.NodeImplKind_PROTECTEDTOKEN
        case SyntaxNodeKind.OverrideToken => return NodeFormat_NodeImplKind.NodeImplKind_OVERRIDETOKEN
        case SyntaxNodeKind.RedefToken => return NodeFormat_NodeImplKind.NodeImplKind_REDEFTOKEN
        case SyntaxNodeKind.AbstractToken => return NodeFormat_NodeImplKind.NodeImplKind_ABSTRACTTOKEN
        case SyntaxNodeKind.SealedToken => return NodeFormat_NodeImplKind.NodeImplKind_SEALEDTOKEN
        case SyntaxNodeKind.OpenToken => return NodeFormat_NodeImplKind.NodeImplKind_OPENTOKEN
        case SyntaxNodeKind.ForeignToken => return NodeFormat_NodeImplKind.NodeImplKind_FOREIGNTOKEN
        case SyntaxNodeKind.InoutToken => return NodeFormat_NodeImplKind.NodeImplKind_INOUTTOKEN
        case SyntaxNodeKind.MutToken => return NodeFormat_NodeImplKind.NodeImplKind_MUTTOKEN
        case SyntaxNodeKind.UnsafeToken => return NodeFormat_NodeImplKind.NodeImplKind_UNSAFETOKEN
        case SyntaxNodeKind.OperatorToken => return NodeFormat_NodeImplKind.NodeImplKind_OPERATORTOKEN
        case SyntaxNodeKind.SpawnToken => return NodeFormat_NodeImplKind.NodeImplKind_SPAWNTOKEN
        case SyntaxNodeKind.SynchronizedToken => return NodeFormat_NodeImplKind.NodeImplKind_SYNCHRONIZEDTOKEN
        case SyntaxNodeKind.UpperBoundToken => return NodeFormat_NodeImplKind.NodeImplKind_UPPERBOUNDTOKEN
        case SyntaxNodeKind.MainToken => return NodeFormat_NodeImplKind.NodeImplKind_MAINTOKEN
        case SyntaxNodeKind.IdentToken => return NodeFormat_NodeImplKind.NodeImplKind_IDENTTOKEN
        case SyntaxNodeKind.PackageIdentifierToken => return NodeFormat_NodeImplKind.NodeImplKind_PACKAGEIDENTIFIERTOKEN
        case SyntaxNodeKind.IntegerLiteralToken => return NodeFormat_NodeImplKind.NodeImplKind_INTEGERLITERALTOKEN
        case SyntaxNodeKind.FloatLiteralToken => return NodeFormat_NodeImplKind.NodeImplKind_FLOATLITERALTOKEN
        case SyntaxNodeKind.CommentToken => return NodeFormat_NodeImplKind.NodeImplKind_COMMENTTOKEN
        case SyntaxNodeKind.NewlineToken => return NodeFormat_NodeImplKind.NodeImplKind_NEWLINETOKEN
        case SyntaxNodeKind.EndToken => return NodeFormat_NodeImplKind.NodeImplKind_ENDTOKEN
        case SyntaxNodeKind.SentinelToken => return NodeFormat_NodeImplKind.NodeImplKind_SENTINELTOKEN
        case SyntaxNodeKind.RunePrefixToken => return NodeFormat_NodeImplKind.NodeImplKind_RUNEPREFIXTOKEN
        case SyntaxNodeKind.DoubleQuoteToken => return NodeFormat_NodeImplKind.NodeImplKind_DOUBLEQUOTETOKEN
        case SyntaxNodeKind.SingleQuoteToken => return NodeFormat_NodeImplKind.NodeImplKind_SINGLEQUOTETOKEN
        case SyntaxNodeKind.JStringLiteralToken => return NodeFormat_NodeImplKind.NodeImplKind_JSTRINGLITERALTOKEN
        case SyntaxNodeKind.MultilineStringToken => return NodeFormat_NodeImplKind.NodeImplKind_MULTILINESTRINGTOKEN
        case SyntaxNodeKind.MultilineRawStringToken => return NodeFormat_NodeImplKind.NodeImplKind_MULTILINERAWSTRINGTOKEN
        case SyntaxNodeKind.BooleanLiteralToken => return NodeFormat_NodeImplKind.NodeImplKind_BOOLEANLITERALTOKEN
        case SyntaxNodeKind.DollarIdentifierToken => return NodeFormat_NodeImplKind.NodeImplKind_DOLLARIDENTIFIERTOKEN
        case SyntaxNodeKind.AnnotationToken => return NodeFormat_NodeImplKind.NodeImplKind_ANNOTATIONTOKEN
        case SyntaxNodeKind.AtExclToken => return NodeFormat_NodeImplKind.NodeImplKind_ATEXCLTOKEN
        case SyntaxNodeKind.CommonToken => return NodeFormat_NodeImplKind.NodeImplKind_COMMONTOKEN
        case SyntaxNodeKind.PlatformToken => return NodeFormat_NodeImplKind.NodeImplKind_PLATFORMTOKEN
        case SyntaxNodeKind.HandleToken => return NodeFormat_NodeImplKind.NodeImplKind_HANDLETOKEN
        case SyntaxNodeKind.PerformToken => return NodeFormat_NodeImplKind.NodeImplKind_PERFORMTOKEN
        case SyntaxNodeKind.ResumeToken => return NodeFormat_NodeImplKind.NodeImplKind_RESUMETOKEN
        case SyntaxNodeKind.ThrowingToken => return NodeFormat_NodeImplKind.NodeImplKind_THROWINGTOKEN
        case SyntaxNodeKind.TripleSingleQuoteToken => return NodeFormat_NodeImplKind.NodeImplKind_TRIPLESINGLEQUOTETOKEN
        case SyntaxNodeKind.TripleDoubleQuoteToken => return NodeFormat_NodeImplKind.NodeImplKind_TRIPLEDOUBLEQUOTETOKEN
        case SyntaxNodeKind.SpaceToken => return NodeFormat_NodeImplKind.NodeImplKind_SPACETOKEN
        case SyntaxNodeKind.StringLiteralToken => return NodeFormat_NodeImplKind.NodeImplKind_STRINGLITERALTOKEN
        case SyntaxNodeKind.Invalid => return NodeFormat_NodeImplKind.NodeImplKind_INVALID
        case _ => return NodeFormat_NodeImplKind.NodeImplKind_INVALID
    }
}