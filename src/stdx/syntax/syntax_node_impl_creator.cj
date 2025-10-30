/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.collection.{ArrayList, ArrayStack}

class SyntaxNodeImplCreator {
    private init() {
    }

    static func createCommentGroup(comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        for (i in 0..comments.size) {
            ret.add(comments[i].nodeImpl)
            if (i < comments.size - 1) {
                ret.add(builder.buildNewline(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.CommentGroup, ret.toArray())
    }

    static func createCommentGroupList(comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(createCommentGroup(comments))

        builder.buildNonTerminal(SyntaxNodeKind.CommentGroupList, ret.toArray())
    }

    static func addCommentToNode(ret: ArrayList<SyntaxNodeImpl>, comments: Array<Comment>) {
        let builder = SyntaxNodeBuilder()
        let commentsPropInfos = ArrayList<PropInfo>()
        if (comments.size > 0) {
            // the CommentGroupList is placed to the beginning of the Node
            commentsPropInfos.add(PropInfo(0, Offset()))
            ret.add(createCommentGroupList(comments))
            ret.add(builder.buildNewline(1))
        }
        commentsPropInfos
    }

    static func createAnnotationImpl(
        arguments: Array<Argument>,
        identifier: String,
        opKind: AtOpKind,
        comments!: Array<Comment> = []
    ): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        match (opKind) {
            case AtOpKind.At => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
            case AtOpKind.AtExcl => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtExclToken))
            case _ => throw Exception("Init Annotation: opKind error")
        }
        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        if (arguments.size > 0) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            for (i in 0..arguments.size) {
                ret.add(arguments[i].nodeImpl)
                if (i < arguments.size - 1) {
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                    ret.add(builder.buildSpace(1))
                }
            }
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Annotation, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createArgumentImpl(identifier: Option<String>, isInOut: Bool, isNamed: Bool, value: Expr,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)
        if (let Some(name) <- identifier) {
            if (!isNamed) {
                throw Exception("InitException: the Argument has name, must be isNamed")
            }
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
        }

        if (isInOut) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InoutToken))
            ret.add(builder.buildSpace(1))
        }
        ret.add(value.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Argument, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createBlockImpl(nodes: Array<SyntaxTreeNode>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        for (node in nodes) {
            if (node.nodeImpl.kind != SyntaxNodeKind.Block && !node.nodeImpl.kind.isExpr()) {
                throw Exception("Init Block: invalid nodes")
            }
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildNewline(1))
        for (i in 0..nodes.size) {
            ret.add(builder.buildSpace(4))
            ret.add(nodes[i].nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.NewlineToken))
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Block, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createBodyImpl(memberDecls: Array<Decl>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildNewline(1))
        for (i in 0..memberDecls.size) {
            ret.add(builder.buildSpace(4))
            ret.add(memberDecls[i].nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.NewlineToken))
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Body, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createGenericConstraintImpl(typeArgument: TypeAnnotation, upperTypes: Array<TypeAnnotation>,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(typeArgument.nodeImpl)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
        for (i in 0..upperTypes.size) {
            ret.add(upperTypes[i].nodeImpl)
            if (i < upperTypes.size - 1) {
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                ret.add(builder.buildSpace(1))
            }
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.GenericConstraint, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createGenericConstraintsImpl(constraints: Array<GenericConstraint>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.WhereToken))
        ret.add(builder.buildSpace(1))
        for (i in 0..constraints.size) {
            ret.add(constraints[i].nodeImpl)
            if (i < constraints.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.GenericConstraints, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createModifierImpl(kind: ModifierKind, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        let modiToken = match (kind) {
            case ModifierKind.Abstract => SyntaxNodeKind.AbstractToken
            case ModifierKind.Internal => SyntaxNodeKind.InternalToken
            case ModifierKind.Mut => SyntaxNodeKind.MutToken
            case ModifierKind.Open => SyntaxNodeKind.OpenToken
            case ModifierKind.Operator => SyntaxNodeKind.OperatorToken
            case ModifierKind.Override => SyntaxNodeKind.OverrideToken
            case ModifierKind.Private => SyntaxNodeKind.PrivateToken
            case ModifierKind.Protected => SyntaxNodeKind.ProtectedToken
            case ModifierKind.Public => SyntaxNodeKind.PublicToken
            case ModifierKind.Redef => SyntaxNodeKind.RedefToken
            case ModifierKind.Sealed => SyntaxNodeKind.SealedToken
            case ModifierKind.Static => SyntaxNodeKind.StaticToken
            case ModifierKind.Unsafe => SyntaxNodeKind.UnsafeToken
            case ModifierKind.Const => SyntaxNodeKind.ConstToken
            case _ => throw Exception("InitException: This modifier kind is not supported for createModifierImpl.")
        }

        let nodeImpl = builder.buildBasicTerminal(modiToken)

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    // Decl
    static func createAnnotationList(annotations: Array<Annotation>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        for (i in 0..annotations.size) {
            ret.add(annotations[i].nodeImpl)
            if (i < annotations.size - 1) {
                ret.add(builder.buildNewline(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.AnnotationList, ret.toArray())
    }

    static func createModifierList(modifiers: Array<Modifier>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        for (i in 0..modifiers.size) {
            ret.add(modifiers[i].nodeImpl)
            if (i < modifiers.size - 1) {
                ret.add(builder.buildSpace(1))
            }
        }

        builder.buildNonTerminal(SyntaxNodeKind.ModifierList, ret.toArray())
    }

    static func createTyepArguments(genericParams: Array<GenericParam>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        for (i in 0..genericParams.size) {
            ret.add(genericParams[i].nodeImpl)
            if (i < genericParams.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))

        builder.buildNonTerminal(SyntaxNodeKind.TypeArguments, ret.toArray())
    }

    static func createClassDeclImpl(body: Body,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>, name: String,
        superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ClassToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        if (superTyAnnotations.size > 0) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
            ret.add(builder.buildSpace(1))
            for (i in 0..superTyAnnotations.size) {
                ret.add(superTyAnnotations[i].nodeImpl)
                if (i < superTyAnnotations.size - 1) {
                    ret.add(builder.buildSpace(1))
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                    ret.add(builder.buildSpace(1))
                }
            }
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ClassDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func isTokenInModifiers(modifiers: Array<Modifier>, modiKind: ModifierKind) {
        for (modifier in modifiers) {
            match (modifier.kind) {
                case modiKind => return true
                case _ => continue
            }
        }
        false
    }

    static func createFuncDeclImpl(body: Option<Block>,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>, kind: FuncKind,
        name: String, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        match (kind) {
            case FuncKind.Constructor =>
                if (isTokenInModifiers(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: the funcKind not correspond to modifiers")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InitToken))
            case FuncKind.Foreign =>
                throw Exception("InitException: the funcKind currently not supported for FuncDecl Init")
            case FuncKind.Normal =>
                if (isTokenInModifiers(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: the funcKind not correspond to modifiers")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FuncToken))
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.Operator =>
                if (!isTokenInModifiers(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: the funcKind not correspond to modifiers")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FuncToken))
                ret.add(builder.buildSpace(1))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.PrimaryConstructor =>
                if (isTokenInModifiers(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: the funcKind not correspond to modifiers")
                }
                if (genericParams.size > 0 || let Some(_) <- retTyAnnotation || let Some(_) <- genericConstraints) {
                    throw Exception("InitException: the params is not supported for PrimaryConstructor Init")
                }
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            case FuncKind.Finalizer =>
                if (isTokenInModifiers(modifiers, ModifierKind.Operator)) {
                    throw Exception("InitException: the funcKind not correspond to modifiers")
                }
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitNotToken))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InitToken))
            case _ => throw Exception("InitException: the funcKind is not supported for createFuncDeclImpl")
        }

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        ret.add(params.nodeImpl)

        if (let Some(typeAnno) <- retTyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(typeAnno.nodeImpl)
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        if (let Some(bd) <- body) {
            ret.add(builder.buildSpace(1))
            ret.add(bd.nodeImpl)
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.FuncDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createStructDeclImpl(body: Body,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>, name: String,
        superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.StructToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        if (superTyAnnotations.size > 0) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
            ret.add(builder.buildSpace(1))
            for (i in 0..superTyAnnotations.size) {
                ret.add(superTyAnnotations[i].nodeImpl)
                if (i < superTyAnnotations.size - 1) {
                    ret.add(builder.buildSpace(1))
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                    ret.add(builder.buildSpace(1))
                }
            }
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.StructDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createInterfaceDeclImpl(body: Body,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>, name: String,
        superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InterfaceToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        if (superTyAnnotations.size > 0) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
            ret.add(builder.buildSpace(1))
            for (i in 0..superTyAnnotations.size) {
                ret.add(superTyAnnotations[i].nodeImpl)
                if (i < superTyAnnotations.size - 1) {
                    ret.add(builder.buildSpace(1))
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                    ret.add(builder.buildSpace(1))
                }
            }
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.InterfaceDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createEnumDeclImpl(body: Body,
        genericConstraints: Option<GenericConstraints>, genericParams: Array<GenericParam>, isNonExhaustive: Bool,
        name: String, superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.EnumToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        if (superTyAnnotations.size > 0) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
            ret.add(builder.buildSpace(1))
            for (i in 0..superTyAnnotations.size) {
                ret.add(superTyAnnotations[i].nodeImpl)
                if (i < superTyAnnotations.size - 1) {
                    ret.add(builder.buildSpace(1))
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                    ret.add(builder.buildSpace(1))
                }
            }
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.EnumDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createPropDeclImpl(isMut: Bool,
        getter: Option<PropGetterOrSetter>, name: String, setter: Option<PropGetterOrSetter>,
        tyAnnotation: TypeAnnotation, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, 
        Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.PropToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        ret.add(builder.buildSpace(1))
        ret.add(tyAnnotation.nodeImpl)
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildNewline(1))

        if (let Some(get) <- getter) {
            ret.add(builder.buildSpace(4))
            ret.add(get.nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        if (let Some(set) <- setter) {
            ret.add(builder.buildSpace(4))
            ret.add(set.nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.PropDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createExtendDeclImpl(body: Body,
        extendedTyAnnotation: TypeAnnotation, genericConstraints: Option<GenericConstraints>,
        genericParams: Array<GenericParam>, superTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ExtendToken))

        if (genericParams.size > 0) {
            ret.add(createTyepArguments(genericParams))
        }

        ret.add(builder.buildSpace(1))
        ret.add(extendedTyAnnotation.nodeImpl)

        if (superTyAnnotations.size > 0) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UpperBoundToken))
            ret.add(builder.buildSpace(1))
            for (i in 0..superTyAnnotations.size) {
                ret.add(superTyAnnotations[i].nodeImpl)
                if (i < superTyAnnotations.size - 1) {
                    ret.add(builder.buildSpace(1))
                    ret.add(builder.buildBasicTerminal(SyntaxNodeKind.BitAndToken))
                    ret.add(builder.buildSpace(1))
                }
            }
        }

        if (let Some(constraints) <- genericConstraints) {
            ret.add(builder.buildSpace(1))
            ret.add(constraints.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ExtendDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMacroExpandDeclImpl(calleeMacro: Expr,
        macroAttrs: Tokens, macroInputs: MacroExpandInput, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init MacroExpandDecl: invalid calleeMacro")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
        ret.add(calleeMacro.nodeImpl)

        if (macroAttrs.size != 0) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            let attrArray = ArrayList<SyntaxNodeImpl>()
            for (i in 0..macroAttrs.size) {
                attrArray.add(builder.buildTokenTerminal(macroAttrs[i].kind, macroAttrs[i].value))
                if (i < macroAttrs.size - 1) {
                    attrArray.add(builder.buildSpace(1))
                }
            }
            ret.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }

        match (macroInputs) {
            case MacroExpandInput.WithoutParens(decl) =>
                ret.add(builder.buildNewline(1))
                ret.add(decl.nodeImpl)
            case MacroExpandInput.WithParens(toks) =>
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                let attrArray = ArrayList<SyntaxNodeImpl>()
                for (i in 0..toks.size) {
                    attrArray.add(builder.buildTokenTerminal(toks[i].kind, toks[i].value))
                    if (i < toks.size - 1) {
                        attrArray.add(builder.buildSpace(1))
                    }
                }
                ret.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            case _ => throw Exception("Init MacroExpandDecl: macroInputs error")
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MacroExpandDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createEnumConstructorImpl(name: String,
        paramTyAnnotations: Array<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..paramTyAnnotations.size) {
            ret.add(paramTyAnnotations[i].nodeImpl)
            if (i < paramTyAnnotations.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.EnumConstructor, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMacroDeclImpl(body: Block,
        name: String, params: ParameterList, retTyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MacroToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        ret.add(params.nodeImpl)

        if (let Some(tyAnno) <- retTyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnno.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MacroDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMainDeclImpl(body: Block,
        params: ParameterList, retTyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MainToken))
        ret.add(params.nodeImpl)

        if (let Some(tyAnno) <- retTyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnno.nodeImpl)
        }

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MainDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createStaticInitImpl(body: Block, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        if (!isTokenInModifiers(modifiers, ModifierKind.Static)) {
            throw Exception("InitException: the modifiers not correspond to StaticInit")
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InitToken))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.StaticInit, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createTypeAliasImpl(aliasName: String,
        originalTyAnnotation: TypeAnnotation, typeParameters: Array<GenericParam>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.TypeToken))
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, aliasName))

        if (typeParameters.size > 0) {
            ret.add(createTyepArguments(typeParameters))
        }

        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AssignToken))
        ret.add(builder.buildSpace(1))
        ret.add(originalTyAnnotation.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TypeAlias, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createVarDeclImpl(initializer: Option<Expr>,
        kind: VarKind, name: String, pattern: Pattern, tyAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (pattern.nodeImpl.kind != SyntaxNodeKind.WildcardPattern && pattern.nodeImpl.kind != SyntaxNodeKind.VarBindingPattern && pattern.nodeImpl.kind != SyntaxNodeKind.TuplePattern && pattern.nodeImpl.kind != SyntaxNodeKind.EnumPattern) {
            throw Exception("Init VarDecl: invalid pattern")
        }

        if (isTokenInModifiers(modifiers, ModifierKind.Const)) {
            throw Exception("InitException: the modifiers not correspond to VarDecl")
        }

        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        match (kind) {
            case VarKind.Var => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.VarToken))
            case VarKind.Let => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LetToken))
            case VarKind.Const => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ConstToken))
            case _ => throw Exception("ParseException: This kind is not var kind.")
        }

        ret.add(builder.buildSpace(1))

        ret.add(pattern.nodeImpl)

        if (let Some(tyAnno) <- tyAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnno.nodeImpl)
        }

        if (let Some(initEx) <- initializer) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AssignToken))
            ret.add(builder.buildSpace(1))
            ret.add(initEx.nodeImpl)
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VarDecl, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createFuncParamImpl(defaultValue: Option<Expr>, kind: Option<VarKind>, name: String, typeAnnotation: TypeAnnotation,
        annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        if (let Some(varKind) <- kind) {
            match (varKind) {
                case VarKind.Var => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.VarToken))
                case VarKind.Let => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LetToken))
                case _ => throw Exception("ParseException: The VarKind is not supported in FuncParam.")
            }
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        if (let Some(value) <- defaultValue) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.NotToken))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        ret.add(builder.buildSpace(1))

        ret.add(typeAnnotation.nodeImpl)

        if (let Some(value) <- defaultValue) {
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AssignToken))
            ret.add(builder.buildSpace(1))
            ret.add(value.nodeImpl)
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.FuncParam, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createGenericParamImpl(name: String, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [],
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.GenericParam, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMacroExpandParamImpl(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init MacroExpandParam: invalid calleeMacro")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
        ret.add(calleeMacro.nodeImpl)

        if (macroAttrs.size != 0) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            let attrArray = ArrayList<SyntaxNodeImpl>()
            for (i in 0..macroAttrs.size) {
                attrArray.add(builder.buildTokenTerminal(macroAttrs[i].kind, macroAttrs[i].value))
                if (i < macroAttrs.size - 1) {
                    attrArray.add(builder.buildSpace(1))
                }
            }
            ret.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }

        match (macroInputs) {
            case MacroExpandInput.WithoutParens(decl) =>
                ret.add(builder.buildSpace(1))
                ret.add(decl.nodeImpl)
            case MacroExpandInput.WithParens(toks) =>
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                let attrArray = ArrayList<SyntaxNodeImpl>()
                for (i in 0..toks.size) {
                    attrArray.add(builder.buildTokenTerminal(toks[i].kind, toks[i].value))
                    if (i < toks.size - 1) {
                        attrArray.add(builder.buildSpace(1))
                    }
                }
                ret.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            case _ => throw Exception("Init MacroExpandDecl: macroInputs error")
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MacroExpandParam, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createLitConstExprImpl(kind: LitConstKind, value: String, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        match (kind) {
            case LitConstKind.BoolLiteral => ret.add(
                builder.buildValuedTerminal(SyntaxNodeKind.BooleanLiteralToken, value))
            case LitConstKind.FloatLiteral => ret.add(
                builder.buildValuedTerminal(SyntaxNodeKind.FloatLiteralToken, value))
            case LitConstKind.IntergerLiteral => ret.add(
                builder.buildValuedTerminal(SyntaxNodeKind.IntegerLiteralToken, value))
            case LitConstKind.UnitLiteral =>
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                ret.add(builder.buildSpace(value.size - 2))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
                let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.UnitLiteral, ret.toArray())
                return (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None,
                    commentsPropInfos.toArray())
            case _ => throw Exception("InitException: this kind is not supported for LitConstExpr")
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ValuedLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func hasInterpolation(strPartExprs: Array<StrLiteralPart>): Bool {
        for (i in 0..strPartExprs.size) {
            match (strPartExprs[i]) {
                case StrInterpolation(_) => return true
                case _ => ()
            }
        }
        return false
    }

    static func createLitConstStrExprImpl(kind: LitConstKind, rawValue: String, delimiterNum: Int64,
        isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        let litToken = builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue)

        match (kind) {
            case LitConstKind.StringLiteral => SyntaxNodeKind.LineStringLiteral
            case _ => throw Exception("InitException: this kind is not supported for createLitConstStrExprImpl")
        }

        match (strKind) {
            case LitConstStrKind.StringLiteral => return createStringLiteralImpl(kind, rawValue, delimiterNum, isSingleQuote, strKind, strPartExprs, comments: comments)
            case LitConstStrKind.MultiLineString => return createMultiLineStringImpl(kind, rawValue, delimiterNum, isSingleQuote, strKind, strPartExprs, comments: comments)
            case LitConstStrKind.MultiLineRawString =>
                let quoteToken = builder.buildQuote(isSingleQuote)
                let hashToken = builder.buildHash(delimiterNum)
                ret.add(all: [hashToken, quoteToken, litToken, quoteToken, hashToken])
                let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MultiLineRawStringLiteral, ret.toArray())
                return (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None,
                    commentsPropInfos.toArray())

            case _ => throw Exception("InitException: this strKind is not supported for createLitConstStrExprImpl")
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.LineStringLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createStringLiteralImpl(kind: LitConstKind, rawValue: String, delimiterNum: Int64,
        isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        let quoteToken = builder.buildQuote(isSingleQuote)
        ret.add(quoteToken)
        if (strPartExprs.size > 0) {
            for (strPart in strPartExprs) {
                match (strPart) {
                    case StrInterpolation(strInterExpr) => ret.add(strInterExpr.nodeImpl)
                    case LitConstPart(litConstExpr) => ret.add(litConstExpr.nodeImpl)
                    case _ => throw Exception("InitException: this strPartExpr is not supported for createStringLiteralImpl")
                }
            }
        } else {
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue))
        }
        ret.add(quoteToken)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.LineStringLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMultiLineStringImpl(kind: LitConstKind, rawValue: String, delimiterNum: Int64,
        isSingleQuote: Bool, strKind: LitConstStrKind, strPartExprs: Array<StrLiteralPart>,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        let quoteToken = builder.buildTripleQuote(isSingleQuote)
        ret.add(quoteToken)
        ret.add(builder.buildNewline(1))
        if (strPartExprs.size > 0) {
            for (strPart in strPartExprs) {
                match (strPart) {
                    case StrInterpolation(strInterExpr) => ret.add(strInterExpr.nodeImpl)
                    case LitConstPart(litConstExpr) => ret.add(litConstExpr.nodeImpl)
                    case _ => throw Exception("InitException: this strPartExpr is not supported for createMultiLineStringImpl")
                }
            }
        } else {
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue))
        }
        ret.add(quoteToken)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MultiLineStringLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())

    }

    static func createLitConstRuneExprImpl(kind: LitConstKind, rawValue: String, isSingleQuote: Bool,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        match (kind) {
            case LitConstKind.RuneLiteral =>
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RunePrefixToken))
                ret.add(builder.buildQuote(isSingleQuote))
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.StringLiteralToken, rawValue))
                ret.add(builder.buildQuote(isSingleQuote))
            case _ => throw Exception("InitException: this kind is not supported for createLitConstRuneExprImpl")
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.RuneLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createArrayLiteralImpl(elements: Array<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
        for (i in 0..elements.size) {
            ret.add(elements[i].nodeImpl)
            if (i < elements.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ArrayLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createTupleLiteralImpl(elements: Array<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        for (i in 0..elements.size) {
            ret.add(elements[i].nodeImpl)
            if (i < elements.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TupleLiteral, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createSymbolRefTyepArguments(typeArguments: Array<TypeAnnotation>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        for (i in 0..typeArguments.size) {
            ret.add(typeArguments[i].nodeImpl)
            if (i < typeArguments.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))

        builder.buildNonTerminal(SyntaxNodeKind.TypeArguments, ret.toArray())
    }

    static func createSymbolRefImpl(name: String, typeArguments: Array<TypeAnnotation>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (typeArguments.size > 0) {
            ret.add(createSymbolRefTyepArguments(typeArguments))
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.RefExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMemberAccessImpl(base: Expr, field: SymbolRef, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(base.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        ret.add(field.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MemberAccess, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createOptionalExprImpl(base: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(base.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.QuestToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.OptionalExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createAssignExprImpl(assignOpKind_: AssignOpKind, lhs: Expr, rhs: Expr, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(lhs.nodeImpl)
        ret.add(builder.buildSpace(1))

        let opToken = match (assignOpKind_) {
            case AssignOpKind.AddAssign => SyntaxNodeKind.AddAssignToken
            case AssignOpKind.AndAssign => SyntaxNodeKind.AndAssignToken
            case AssignOpKind.Assign => SyntaxNodeKind.AssignToken
            case AssignOpKind.BitAndAssign => SyntaxNodeKind.BitAndAssignToken
            case AssignOpKind.BitOrAssign => SyntaxNodeKind.BitOrAssignToken
            case AssignOpKind.BitXorAssign => SyntaxNodeKind.BitXorAssignToken
            case AssignOpKind.DivAssign => SyntaxNodeKind.DivAssignToken
            case AssignOpKind.ExpAssign => SyntaxNodeKind.ExpAssignToken
            case AssignOpKind.LShiftAssign => SyntaxNodeKind.LShiftAssignToken
            case AssignOpKind.ModAssign => SyntaxNodeKind.ModAssignToken
            case AssignOpKind.MulAssign => SyntaxNodeKind.MulAssignToken
            case AssignOpKind.OrAssign => SyntaxNodeKind.OrAssignToken
            case AssignOpKind.RShiftAssign => SyntaxNodeKind.RShiftAssignToken
            case AssignOpKind.SubAssign => SyntaxNodeKind.SubAssignToken
            case _ => throw Exception("InitException: the AssignOpKind is not supported for createAssignExprImpl")
        }

        ret.add(builder.buildBasicTerminal(opToken))
        ret.add(builder.buildSpace(1))
        ret.add(rhs.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.AssignExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createUnsafeExprImpl(body: Block, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, 
        Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.UnsafeToken))
        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.UnsafeExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createSubscriptExprImpl(base: Expr, indexs: Array<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(base.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))

        for (i in 0..indexs.size) {
            ret.add(indexs[i].nodeImpl)
            if (i < indexs.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.SubscriptExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createLambdaImpl(body: Array<SyntaxTreeNode>, params: ParameterList, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        ret.add(builder.buildSpace(1))

        ret.add(params.nodeImpl)
        ret.add(builder.buildSpace(1))

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DoubleArrowToken))
        ret.add(builder.buildSpace(1))

        for (i in 0..body.size) {
            ret.add(body[i].nodeImpl)
            if (i < body.size - 1) {
                ret.add(builder.buildNewline(1))
            }
        }

        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Lambda, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMatchExprImpl(matchCases: Array<MatchCase>, selector: Option<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MatchToken))
        ret.add(builder.buildSpace(1))

        if (let Some(sel) <- selector) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(sel.nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            ret.add(builder.buildSpace(1))
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..matchCases.size) {
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildSpace(4))
            ret.add(matchCases[i].nodeImpl)
        }
        ret.add(builder.buildNewline(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MatchExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createTryCatchImpl(catchBlocks: Array<Block>, catchPatterns: Array<CatchPattern>,
        finallyBlock: Option<Block>, resourceSpec: Array<VarDecl>, tryBlock: Block, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.TryToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))

        for (i in 0..resourceSpec.size) {
            ret.add(resourceSpec[i].nodeImpl)
            if (i < resourceSpec.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildSpace(1))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(tryBlock.nodeImpl)

        for (i in 0..catchPatterns.size) {
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CatchToken))
            ret.add(builder.buildSpace(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(catchPatterns[i].nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            ret.add(builder.buildSpace(1))
            ret.add(catchBlocks[i].nodeImpl)
        }

        if (let Some(finalBlock) <- finallyBlock) {
            ret.add(builder.buildNewline(1))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.FinallyToken))
            ret.add(builder.buildSpace(1))
            ret.add(finalBlock.nodeImpl)
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TryExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createThrowExprImpl(throwVal: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ThrowToken))
        ret.add(builder.buildSpace(1))
        ret.add(throwVal.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ThrowExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createSynchronizedExprImpl(block: Block, structuredMutex: Expr, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SynchronizedToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(structuredMutex.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(block.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.SynchronizedExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createSpawnExprImpl(threadContext: Option<Expr>, trailingLambdaExpr: Lambda,
        comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SpawnToken))
        ret.add(builder.buildSpace(1))
        if (let Some(context) <- threadContext) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(context.nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }
        ret.add(builder.buildSpace(1))
        ret.add(trailingLambdaExpr.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.SpawnExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createIfExprImpl(condition: DisjunctionCondition, elseBlock: Option<Block>, elseIf: Option<IfExpr>,
        ifBlock: Block, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.IfToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(condition.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(ifBlock.nodeImpl)
        ret.add(builder.buildSpace(1))

        if (let Some(elseIfExpr) <- elseIf) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ElseToken))
            ret.add(builder.buildSpace(1))
            ret.add(elseIfExpr.nodeImpl)
        }

        if (let Some(elBlock) <- elseBlock) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ElseToken))
            ret.add(builder.buildSpace(1))
            ret.add(elBlock.nodeImpl)
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.IfExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createWhileExprImpl(body: Block, condition: DisjunctionCondition, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.WhileToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(condition.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        ret.add(builder.buildSpace(1))
        ret.add(body.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.WhileExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createDoWhileExprImpl(body: Block, condition: Expr, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DoToken))
        ret.add(builder.buildSpace(1))

        ret.add(body.nodeImpl)

        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.WhileToken))
        ret.add(builder.buildSpace(1))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        ret.add(condition.nodeImpl)
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.DoWhileExpr, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createLambdaParamImpl(name: String,
        typeAnnotation: Option<TypeAnnotation>, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, 
        Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))

        if (let Some(tyAnn) <- typeAnnotation) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildSpace(1))
            ret.add(tyAnn.nodeImpl)
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.LambdaParam, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createPropGetterOrSetterImpl(block: Block,
        identifier: Option<String>, isGetter: Bool, annotations!: Array<Annotation> = [], modifiers!: Array<Modifier> = [], comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (annotations.size != 0) {
            ret.add(createAnnotationList(annotations))
            ret.add(builder.buildNewline(1))
        }

        if (modifiers.size != 0) {
            ret.add(createModifierList(modifiers))
            ret.add(builder.buildSpace(1))
        }

        if (isGetter) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.GetToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        } else {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SetToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
            if (let Some(ident) <- identifier) {
                ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, ident))
            }
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        }

        ret.add(builder.buildSpace(1))
        ret.add(block.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.PropGetterOrSetter, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createPackageHeaderImpl(accessModifier: Option<Modifier>, isMacroPkg: Bool,
        packageNameIdentifiers: Array<String>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, 
        Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(ret, comments)

        if (let Some(modifier) <- accessModifier) {
            match (modifier.kind) {
                case ModifierKind.Internal => SyntaxNodeKind.InternalToken
                case ModifierKind.Protected => SyntaxNodeKind.ProtectedToken
                case ModifierKind.Public => SyntaxNodeKind.PublicToken
                case _ => throw Exception(
                    "InitException: This modifier kind is not supported for createPackageHeaderImpl.")
            }
            ret.add(modifier.nodeImpl)
            ret.add(builder.buildSpace(1))
        }

        if (isMacroPkg) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.MacroToken))
            ret.add(builder.buildSpace(1))
        }

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.PackageToken))
        ret.add(builder.buildSpace(1))

        for (i in 0..packageNameIdentifiers.size) {
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, packageNameIdentifiers[i]))
            if (i < packageNameIdentifiers.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
            }
        }

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.PackageSpec, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createCommentImpl(kind: CommentKind, content: String): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, 
        Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildTokenTerminal(TokenKind.COMMENT, content, hasEscape: false))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Comment, ret.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, Array<PropInfo>())
    }

    // import
    static func createParameterListImpl(parameters: Array<Parameter>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createImportListImpl(contents: ImportContent, kind: ImportKind, modifier: Option<Modifier>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createImportSingleImpl(prefixes: Array<String>, identifier: String, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportSingle, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createImportAliasImpl(prefixes: Array<String>, identifier: String, alias: String, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createImportAllImpl(prefixes: Array<String>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        for (i in 0..prefixes.size) {
            parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, prefixes[i]))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DotToken))
        }
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.MulToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ImportAll, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createImportMultiImpl(prefixes: Array<String>, contents: Array<ImportContent>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
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
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createReturnExprImpl(retVal: Option<Expr>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ReturnToken))
        if (let Some(v) <- retVal) {
            parts.add(builder.buildSpace(1))
            parts.add(v.nodeImpl)
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ReturnExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createVArrayExprImpl(argument: Argument, vArrayType: VArrayType, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(vArrayType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(argument.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VArrayExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createUnaryExprImpl(opKind: UnaryOpKind, operand: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        match (opKind) {
            case UnaryOpKind.Not => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.NotToken))
            case UnaryOpKind.Sub => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.SubToken))
            case _ => throw Exception("Init UnaryExpr: opKind error")
        }
        parts.add(operand.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.UnaryExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createQuoteExprImpl(tokensOrRefExpr: Array<QuoteExprContent>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createQuoteTokenImpl(content: Tokens, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        // TODO: is this right ?
        let tokenArray = ArrayList<SyntaxNodeImpl>()
        for (i in 0..content.size) {
            parts.add(builder.buildTokenTerminal(content[i].kind, content[i].value))
            if (i < content.size - 1 && content[i].kind != TokenKind.NL) {
                parts.add(builder.buildSpace(1))
            }
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.QuoteTokenExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createQuoteInterpolationExprImpl(expr: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(expr.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.QuoteInterpolationExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createTrailingClosureExprImpl(callee: Expr, arguments: Array<Argument>, trailingLambdaExpr: Lambda, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init TrailingClosureExpr: invalid callee")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMacroExpandExprImpl(calleeMacro: Expr, macroAttrs: Tokens, macroInputs: MacroExpandInput, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (calleeMacro.nodeImpl.kind != SyntaxNodeKind.MemberAccess && calleeMacro.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init MacroExpandExpr: invalid calleeMacro")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
        parts.add(calleeMacro.nodeImpl)
        if (macroAttrs.size != 0) {
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
            let attrArray = ArrayList<SyntaxNodeImpl>()
            for (i in 0..macroAttrs.size) {
                attrArray.add(builder.buildTokenTerminal(macroAttrs[i].kind, macroAttrs[i].value))
                if (i < macroAttrs.size - 1) {
                    attrArray.add(builder.buildSpace(1))
                }
            }
            parts.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
            parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        }
        match (macroInputs) {
            case MacroExpandInput.WithParens(toks) =>
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
                let attrArray = ArrayList<SyntaxNodeImpl>()
                for (i in 0..toks.size) {
                    attrArray.add(builder.buildTokenTerminal(toks[i].kind, toks[i].value))
                    if (i < toks.size - 1) {
                        attrArray.add(builder.buildSpace(1))
                    }
                }
                parts.add(builder.buildNonTerminal(SyntaxNodeKind.TokenList, attrArray.toArray()))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
            case MacroExpandInput.WithoutParens(decl) =>
                parts.add(builder.buildNewline(1))
                parts.add(decl.nodeImpl)
            case _ => throw Exception("Init MacroExpandExpr: macroInputs error")
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.MacroExpandExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createBinaryExprImpl(lhs: Expr, opKind: BinaryOpKind, rhs: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    // RangeExpr: start .. end : step   or   start ..= end : step
    static func createRangeExprImpl(start: Option<Expr>, kind: RangeKind, end: Option<Expr>, step: Option<Expr>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createIncOrDecExprImpl(kind: IncOrDecOpKind, operand: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(operand.nodeImpl)
        match (kind) {
            case IncOrDecOpKind.Incr => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.IncrToken))
            case IncOrDecOpKind.Decr => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DecrToken))
            case _ => throw Exception("Init IncOrDecExpr: invalid opKind")
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.IncOrDecExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createParenExprImpl(subExpr: Expr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(subExpr.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParenExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createCallExprImpl(callee: Expr, arguments: Array<Argument>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init CallExpr: invalid callee")
        }
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createIsExprImpl(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.IsToken))
        parts.add(builder.buildSpace(1))
        parts.add(targetTypeAnnotation.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.IsExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createAsExprImpl(srcVal: Expr, targetTypeAnnotation: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, 
        ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.AsToken))
        parts.add(builder.buildSpace(1))
        parts.add(targetTypeAnnotation.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.AsExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createTypeConvExprImpl(targetTypeAnnotation: AtomicType, srcVal: Expr, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(targetTypeAnnotation.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(srcVal.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TypeConvExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createMatchCaseImpl(patterns: Array<Pattern>, patternGuardCond: Option<Expr>, caseCond: Option<Expr>,
        body: Array<SyntaxTreeNode>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createCatchPatternImpl(pattern: Pattern, exceptionType: Array<TypeAnnotation>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createBreakExprImpl(comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.BreakToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.BreakExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createContinueExprImpl(comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ContinueToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ContinueExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createCallExprImpl(callee: Expr, args: Array<Expr>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (callee.nodeImpl.kind != SyntaxNodeKind.MemberAccess && callee.nodeImpl.kind != SyntaxNodeKind.RefExpr) {
            throw Exception("Init CallExpr: invalid callee")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createDisjunctionConditionImpl(cond: Array<ConjunctionCondition>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        for (i in 0..cond.size) {
            parts.add(cond[i].nodeImpl)
            if (i < cond.size - 1) {
                parts.add(builder.buildSpace(1))
                parts.add(builder.buildBasicTerminal(SyntaxNodeKind.OrToken))
                parts.add(builder.buildSpace(1))
            }
        }
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.DisjunctionCondition, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createConjunctionConditionImpl(cond: Array<AtomicCondition>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createParenConditionImpl(cond: DisjunctionCondition, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(cond.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParenCondition, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createLetPatternImpl(expr: Expr, patterns: Array<Pattern>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createStrInterpolationContentImpl(interpolationBlock: Block, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(interpolationBlock.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.InterpolationExpr, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createConstPatternImpl(litConstExpr: LitConstExpr, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(litConstExpr.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ConstPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createVarPatternImpl(name: String, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VarBindingPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    // EnumPattern: case Year(n) => ...
    static func createEnumPatternImpl(enumConstructor: SymbolRef, enumType: Option<CompositeType>,
        subPatterns: Array<Pattern>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)

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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createVarOrEnumPatternImpl(identifier: String, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, identifier))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VarOrEnumPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    // TypePattern: case x: T => ...
    static func createTypePatternImpl(subPattern: Pattern, patternType: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(subPattern.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
        parts.add(builder.buildSpace(1))
        parts.add(patternType.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.TypePattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    // TuplePattern: case (a, b) => ...
    static func createTuplePatternImpl(subPatterns: Array<Pattern>, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    // WildcardPattern: case _ => ...
    static func createWildcardPatternImpl(comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.WildcardToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.WildcardPattern, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createAtomicTypeImpl(kind: AtomicTypeKind, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createTupleTypeImpl(elements: Array<TypeAnnotation>, labels: Array<String>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (elements.size != labels.size && labels.size != 0) {
            throw Exception("Init TupleType: number of elements and labels mismatch")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createFuncTypeImpl(paramTypes: Array<TypeAnnotation>, labels: Array<String>, retType: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        if (paramTypes.size != labels.size) {
            throw Exception("Init FuncType: number of parameter types and labels mismatch")
        }
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createCompositeTypeImpl(name: String, prefixes: Array<String>, typeArguments: Array<TypeAnnotation>, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
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
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createVArrayTypeImpl(elementType: TypeAnnotation, size: Int64, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.VArrayToken))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LtToken))
        parts.add(elementType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
        parts.add(builder.buildSpace(1))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.DollarToken))
        parts.add(builder.buildValuedTerminal(SyntaxNodeKind.ValuedLiteral, size.toString()))
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.GtToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.VArrayType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createParenTypeImpl(subType: TypeAnnotation, comments!: Array<Comment> = []): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.LParenToken))
        parts.add(subType.nodeImpl)
        parts.add(builder.buildBasicTerminal(SyntaxNodeKind.RParenToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.ParenType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }

    static func createPrefixTypeImpl(base: TypeAnnotation, prefixOp: PrefixTypeOpKind, comments!: Array<Comment> = []): (CodePositionRange, 
        SyntaxNodeImpl, ?SyntaxTreeNode, Array<PropInfo>) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let parts = ArrayList<SyntaxNodeImpl>()
        let commentsPropInfos = addCommentToNode(parts, comments)
        match (prefixOp) {
            case PrefixTypeOpKind.Quest => parts.add(builder.buildBasicTerminal(SyntaxNodeKind.QuestToken))
            case _ => throw Exception("Init PrefixType: unknown prefixOp type")
        }
        parts.add(base.nodeImpl)
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.OptionType, parts.toArray())
        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None, commentsPropInfos.toArray())
    }
}
