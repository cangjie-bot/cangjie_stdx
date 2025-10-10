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

    static func createAnnotationImpl(): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        match (opKind) {
            case AtOpKind.At => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtToken))
            case AtOpKind.AtExcl => ret.add(builder.buildBasicTerminal(SyntaxNodeKind.AtExclToken))
            case _ => throw Exception("Init Annotation: opKind error")
        }
        ret.add(builder.buildValueTerminal(SyntaxNodeKind.IdentToken, identifier))
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LSquareToken))
        for (i in 0..arguments.size) {
            ret.add(arguments[i].nodeImpl)
            if(i < arguments.size - 1) {
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.CommaToken))
                ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SpaceToken))
            }
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RSquareToken))
        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Annotation, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None)
    }

    static func createArgumentImpl(): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()
        if (let Some(name) <- identifier) {
            ret.add(builder.buildValuedTerminal(SyntaxNodeKind.IdentToken, name))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.ColonToken))
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.SpaceToken))
        }

        if (isInOut) {
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.InoutToken))
        }
        ret.add(value.nodeImpl)

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Argument, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None)
    }

    static func createBlockImpl(nodes: Array<SyntaxTreeNode>): (CodePositionRange, SyntaxNodeImpl, ?SyntaxTreeNode) {
        let startPos = CodePosition(1, 1, FileInfos("", ""))
        let builder = SyntaxNodeBuilder()
        let ret = ArrayList<SyntaxNodeImpl>()

        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.LCurlToken))
        for (i in 0..nodes.size) {
            ret.add(builder.buildSpace(4))
            ret.add(nodes[i].nodeImpl)
            ret.add(builder.buildBasicTerminal(SyntaxNodeKind.NewlineToken))
        }
        ret.add(builder.buildBasicTerminal(SyntaxNodeKind.RCurlToken))

        let nodeImpl = builder.buildNonTerminal(SyntaxNodeKind.Block, ret.toArray())

        (CodePositionRange(startPos, startPos + nodeImpl.offset), nodeImpl, None)
    }

    
 }