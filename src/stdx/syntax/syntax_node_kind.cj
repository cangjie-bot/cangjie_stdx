/* t
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.syntax

import std.deriving.*

@Derive[Equatable]
enum SyntaxNodeKind <: ToString {
    /* NonTerminal */
    | File /* SourceFile */
    | Package
    | FeaturesDirective
    | FeatureId
    | PackageSpec
    | PackagePrefixes
    | CatchPattern
    | Argument
    | Annotation
    | AnnotationList /* Annotations: @C @When ... */
    | TypeArguments /* <T, V> */
    | ModifierList /* ModifierList: public static */
    | ParameterList /* ParameterList: (x,x,x) */
    | GenericConstraints /*GenericConstraints: where T1 <: I1 & I2, T2 <: I3 & I4 */
    | GenericConstraint /*GenericConstraints: T1 <: I1 & I2 */
    | MatchCase
    | MatchCaseBody
    | Pattern
    | Body
    | DisjunctionCondition
    | ConjunctionCondition
    | ParenCondition
    | LetPattern
    | AtomicCondition
    | TokenList
    | Comment
    | CommentGroup
    | CommentGroupList
    | Modifier
    | GenericParam
    | ImportSpec
    // ImportCotent
    | ImportAlias
    | ImportAll
    | ImportMulti
    | ImportSingle
    // Type_annotations
    | PrimitiveType
    | RefType
    | FuncType
    | ThisType
    | ParenType
    | QualifiedType
    | OptionType
    | OptionalType
    | VArrayType
    | TupleType
    | CompositeType /* pkg1.subpkg0.Type0<args> */
    // Decls
    | MainDecl
    | VarDecl
    | FuncDecl
    | FuncParam
    | LambdaParam
    | Block
    | TypeAlias
    | ClassDecl
    | PropGetterOrSetter
    | PropDecl
    | StaticInit
    | StructDecl
    | InterfaceDecl
    | ExtendDecl
    | EnumDecl
    | EnumConstructor
    | MacroDecl
    | MacroExpandDecl
    | MacroExpandParam
    // Exprs
    | ValuedLiteral
    | UnitLiteral
    | RuneLiteral
    | LineStringLiteral
    | MultiLineStringLiteral
    | MultiLineRawStringLiteral
    | ArrayLiteral
    | TupleLiteral
    | AssignExpr
    | VArrayExpr
    | MemberAccess
    | UnaryExpr
    | BinaryExpr
    | CallExpr
    | RefExpr
    | IsExpr
    | AsExpr
    | ParenExpr
    | ReturnExpr
    | IncOrDecExpr
    | RangeExpr
    | TypeConvExpr
    | OptionalExpr
    | BreakExpr
    | ContinueExpr
    | SubscriptExpr
    | Lambda
    | MatchExpr
    | TryCatch
    | ThrowExpr
    | SynchronizedExpr
    | SpawnExpr
    | IfExpr
    | WhileExpr
    | DoWhileExpr
    | ForInExpr
    | JumpExpr
    | LambdaExpr
    | TryExpr
    | InterpolationExpr
    | QuoteTokenExpr
    | QuoteExpr
    | QuoteInterpolationExpr
    | TrailingClosureExpr
    | UnsafeExpr
    | MacroExpandExpr
    // patterns
    | ExceptTypePattern
    | WildcardPattern
    | ConstPattern
    | VarBindingPattern
    | VarOrEnumPattern
    | TuplePattern
    | TypePattern
    | EnumPattern
    /* Terminal */
    | Token
    // token kind
    | DotToken /* . */
    | CommaToken /*,*/
    | LParenToken /* ( */
    | RParenToken /* ) */
    | LSquareToken /* [ */
    | RSquareToken /* ]*/
    | LCurlToken /* { */
    | RCurlToken /* } */
    | ExpToken /* ** */
    | MulToken /* * */
    | ModToken /* % */
    | DivToken /* / */
    | AddToken /* + */
    | SubToken /* - */
    | IncrToken /* ++ */
    | DecrToken /* -- */
    | AndToken /* && */
    | OrToken /* || */
    | CoalescingToken /* ?? */
    | PipelineToken /* |> */
    | CompositionToken /* ~> */
    | NotToken /* ! */
    | BitAndToken /* & */
    | BitOrToken /* | */
    | BitXorToken /* ^ */
    | BitNotToken /* ~ */
    | LShiftToken /* << */
    | RShiftToken /* >> */
    | ColonToken /* : */
    | SemiToken /* ; */
    | AssignToken /* = */
    | AddAssignToken /* += */
    | SubAssignToken /* -= */
    | MulAssignToken /* *= */
    | ExpAssignToken /* **= */
    | DivAssignToken /* /= */
    | ModAssignToken /* %= */
    | AndAssignToken /* &&= */
    | OrAssignToken /* ||= */
    | BitAndAssignToken /* &= */
    | BitOrAssignToken /* |= */
    | BitXorAssignToken /* ^= */
    | LShiftAssignToken /* <<= */
    | RShiftAssignToken /* >>= */
    | ArrowToken /* -> */
    | BackArrowToken /* <- */
    | DoubleArrowToken /* => */
    | RangeOpToken /* .. */
    | ClosedRangeOpToken /* ..= */
    | EllipsisToken /* ... */
    | HashToken /* # */
    | AtToken /* @ */
    | QuestToken /* ? */
    | LtToken /* < */
    | GtToken /* > */
    | LeToken /* <= */
    | GeToken /* >= */
    | IsToken /* is */
    | AsToken /* as */
    | NotEqToken /* != */
    | EqualToken /* == */
    | WildcardToken /* _ */
    // type keyword
    | Int8Token /* Int8 */
    | Int16Token /* Int16 */
    | Int32Token /* Int32 */
    | Int64Token /* Int64 */
    | IntNativeToken /* IntNative */
    | UInt8Token /* UInt8 */
    | UInt16Token /* UInt16 */
    | UInt32Token /* UInt32 */
    | UInt64Token /* UInt64 */
    | UIntNativeToken /* UIntNative */
    | Float16Token /* Float16 */
    | Float32Token /* Float32 */
    | Float64Token /* Float64 */
    | RuneToken /* Rune */
    | BooleanToken /* Bool */
    | NothingToken /* Nothing */
    | UnitToken /* Unit */
    | StructToken /* struct */
    | EnumToken /* enum */
    | VArrayToken /* VArray */
    | ThisTypeToken /* This */
    | FeaturesToken /* features */
    | PackageToken /* package */
    | ImportToken /* import */
    | ClassToken /* class */
    | InterfaceToken /* interface */
    | FuncToken /* func */
    | MacroToken /* macro */
    | QuoteToken /* quote */
    | DollarToken /* $ */
    | LetToken /* let */
    | VarToken /* var */
    | ConstToken /* const */
    | TypeToken /* type */
    | InitToken /* init */
    | ThisToken /* this */
    | SuperToken /* super */
    | IfToken /* if */
    | ElseToken /* else */
    | CaseToken /* case */
    | TryToken /* try */
    | CatchToken /* catch */
    | FinallyToken /* finally */
    | ForToken /* for */
    | DoToken /* do */
    | WhileToken /* while */
    | ThrowToken /* throw */
    | ReturnToken /* return */
    | ContinueToken /* continue */
    | BreakToken /* break */
    | InToken /* in */
    | NotInToken /* !in */
    | MatchToken /* match */
    | WhereToken /* where */
    | ExtendToken /* extend */
    | WithToken /* with */
    | PropToken /* prop */
    | GetToken /* get */
    | SetToken /* set */
    // modifier keyword
    | StaticToken /* static */
    | PublicToken /* public */
    | PrivateToken /* private */
    | InternalToken /* internal */
    | ProtectedToken /* protected */
    | OverrideToken /* override */
    | RedefToken /* redef */
    | AbstractToken /* abstract */
    | SealedToken /* sealed */
    | OpenToken /* open */
    | ForeignToken /* foreign */
    | InoutToken /* inout */
    | MutToken /* mut */
    | UnsafeToken /* unsafe */
    | OperatorToken /* operator */
    | SpawnToken /* spawn */
    | SynchronizedToken /* synchronized */
    | UpperBoundToken /* <: */
    | MainToken /* main */
    | IdentToken /* x */
    | PackageIdentifierToken /* x-y */
    | IntegerLiteralToken /* e.g. "1" */
    | CharBytePrefixToken /* b */
    | FloatLiteralToken /* e.g. "'1.0'" */
    | CommentToken /* e.g. "/*xx*/" */
    | NewlineToken /* newline */
    | EndToken /* end of file */
    | SentinelToken /* ; */
    | RunePrefixToken /* r */
    | DoubleQuoteToken /* the raw value of StringLiteral, e.g. ""xx"" */
    | SingleQuoteToken /* e.g. "'xx'" */
    | JStringLiteralToken /* J"" */
    | MultilineStringToken /* e.g. """"aaa"""" */
    | MultilineRawStringToken /* e.g. "#"aaa"#" */
    | BooleanLiteralToken /* "true" or "false" */
    | DollarIdentifierToken /* $x */
    | AnnotationToken /* @When */
    | AtExclToken /* @! */
    | CommonToken /* common */
    | PlatformToken /* platform */
    | HandleToken /* handle */
    | PerformToken /* perform */
    | ResumeToken /* resume */
    | ThrowingToken /* throwing */
    // new token kind
    | TripleSingleQuoteToken
    | TripleDoubleQuoteToken
    | SpaceToken
    | StringLiteralToken
    | Invalid
    | ...

    public func toString(): String {
        match (this) {
            case File => "File"
            case FuncDecl => "FuncDecl"
            case ParameterList => "ParameterList"
            case Block => "Block"
            case UnitLiteral => "UnitLiteral"
            case FuncToken => "func"
            case MainDecl => "main"
            case TripleSingleQuoteToken => "'''"
            case TripleDoubleQuoteToken => '"""'
            case RefType => "RefType"
            case FuncType => "FuncType"
            case TupleType => "TupleType"
            case OptionType => "OptionType"

            case DotToken => "."
            case CommaToken => ","
            case LParenToken => "("
            case RParenToken => ")"
            case LSquareToken => "["
            case RSquareToken => "]"
            case LCurlToken => "{"
            case RCurlToken => "}"
            case ExpToken => "**"
            case MulToken => "*"
            case ModToken => "%"
            case DivToken => "/"
            case AddToken => "+"
            case SubToken => "-"
            case IncrToken => "++"
            case DecrToken => "--"
            case AndToken => "&&"
            case OrToken => "||"
            case CoalescingToken => "??"
            case PipelineToken => "|>"
            case CompositionToken => "~>"
            case NotToken => "!"
            case BitAndToken => "&"
            case BitOrToken => "|"
            case BitXorToken => "^"
            case BitNotToken => "~"
            case LShiftToken => "<<"
            case RShiftToken => ">>"
            case ColonToken => ":"
            case SemiToken => ";"
            case AssignToken => "="
            case AddAssignToken => "+="
            case SubAssignToken => "-="
            case MulAssignToken => "*="
            case ExpAssignToken => "**="
            case DivAssignToken => "/="
            case ModAssignToken => "%="
            case AndAssignToken => "&&="
            case OrAssignToken => "||="
            case BitAndAssignToken => "&="
            case BitOrAssignToken => "|="
            case BitXorAssignToken => "^="
            case LShiftAssignToken => "<<="
            case RShiftAssignToken => ">>="
            case ArrowToken => "->"
            case BackArrowToken => "<-"
            case DoubleArrowToken => "=>"
            case RangeOpToken => ".."
            case ClosedRangeOpToken => "..="
            case EllipsisToken => "..."
            case HashToken => "#"
            case AtToken => "@"
            case QuestToken => "?"
            case LtToken => "<"
            case GtToken => ">"
            case LeToken => "<="
            case GeToken => ">="
            case IsToken => "is"
            case AsToken => "as"
            case NotEqToken => "!="
            case EqualToken => "=="
            case WildcardToken => "_"
            // type
            case UnitToken => "Unit"
            case Int8Token => "Int8"
            case Int16Token => "Int16"
            case Int32Token => "Int32"
            case Int64Token => "Int64"
            case IntNativeToken => "IntNative"
            case UInt8Token => "UInt8"
            case UInt16Token => "UInt16"
            case UInt32Token => "UInt32"
            case UInt64Token => "UInt64"
            case UIntNativeToken => "UIntNative"
            case Float16Token => "Float16"
            case Float32Token => "Float32"
            case Float64Token => "Float64"
            case RuneToken => "Rune"
            case BooleanToken => "Bool"
            case NothingToken => "Nothing"

            case StructToken => "struct"
            case EnumToken => "enum"
            case VArrayToken => "VArray"
            case ThisTypeToken => "This"
            case FeaturesToken => "features"
            case PackageToken => "package"
            case ImportToken => "import"
            case ClassToken => "class"
            case InterfaceToken => "interface"
            case MacroToken => "macro"
            case QuoteToken => "quote"
            case DollarToken => "$"
            case LetToken => "let"
            case VarToken => "var"
            case ConstToken => "const"
            case TypeToken => "type"
            case InitToken => "init"
            case ThisToken => "this"
            case SuperToken => "super"
            case IfToken => "if"
            case ElseToken => "else"
            case CaseToken => "case"
            case TryToken => "try"
            case CatchToken => "catch"
            case FinallyToken => "finally"
            case ForToken => "for"
            case DoToken => "do"
            case WhileToken => "while"
            case ThrowToken => "throw"
            case ReturnToken => "return"
            case ContinueToken => "continue"
            case BreakToken => "break"
            case InToken => "in"
            case NotInToken => "!in"
            case MatchToken => "match"
            case WhereToken => "where"
            case ExtendToken => "extend"
            case WithToken => "with"
            case PropToken => "prop"
            case GetToken => "get"
            case SetToken => "set"
            // modifier keyword
            case StaticToken => "static"
            case PublicToken => "public"
            case PrivateToken => "private"
            case InternalToken => "internal"
            case ProtectedToken => "protected"
            case OverrideToken => "override"
            case RedefToken => "redef"
            case AbstractToken => "abstract"
            case SealedToken => "sealed"
            case OpenToken => "open"
            case ForeignToken => "foreign"
            case InoutToken => "inout"
            case MutToken => "mut"
            case UnsafeToken => "unsafe"
            case OperatorToken => "operator"

            case SpawnToken => "spawn"
            case SynchronizedToken => "synchronized"
            case UpperBoundToken => "<:"
            case MainToken => "main"
            case IdentToken => ""
            case PackageIdentifierToken => ""
            case IntegerLiteralToken => ""
            case CharBytePrefixToken => 'b'
            case FloatLiteralToken => ""
            case CommentToken => ""
            case NewlineToken => ""
            case EndToken => ""
            case SentinelToken => ""
            case RunePrefixToken => 'r'
            case SingleQuoteToken => "'"
            case DoubleQuoteToken => '"'
            case JStringLiteralToken => ""
            case MultilineStringToken => ""
            case MultilineRawStringToken => ""
            case BooleanLiteralToken => ""
            case DollarIdentifierToken => ""
            case AnnotationToken => ""
            case AtExclToken => "@!"
            case CommonToken => "common"
            case PlatformToken => "platform"
            case HandleToken => "handle"
            case PerformToken => "perform"
            case ResumeToken => "resume"
            case ThrowingToken => "throwing"
            case StringLiteralToken => ""
            case Invalid => ""
            case _ => ""
        }
    }

    func isWhitespace(): Bool {
        match (this) {
            case NewlineToken | SpaceToken => true
            case _ => false
        }
    }

    func isPattern(): Bool {
        match (this) {
            case WildcardPattern | ConstPattern | VarBindingPattern | VarOrEnumPattern | TuplePattern | EnumPattern
                | TypePattern => true
            case _ => false
        }
    }

    func isDecl(): Bool {
        match (this) {
            case MainDecl | VarDecl | FuncDecl | FuncParam | LambdaParam | TypeAlias | ClassDecl | PropGetterOrSetter
                | PropDecl | StaticInit | StructDecl | InterfaceDecl | ExtendDecl | EnumDecl | EnumConstructor
                | MacroDecl | MacroExpandDecl | MacroExpandParam => true
            case _ => false
        }
    }

    func isExpr(): Bool {
        match (this) {
            case IntegerLiteralToken | FloatLiteralToken | BooleanLiteralToken | UnitLiteral | RuneLiteral
                | LineStringLiteral | MultiLineStringLiteral | MultiLineRawStringLiteral | ArrayLiteral | TupleLiteral
                | AssignExpr | VArrayExpr | MemberAccess | UnaryExpr | BinaryExpr | CallExpr | RefExpr | IsExpr | AsExpr
                | ParenExpr | ReturnExpr | IncOrDecExpr | RangeExpr | TypeConvExpr | OptionalExpr | BreakExpr
                | ContinueExpr | SubscriptExpr | Lambda | MatchExpr | TryCatch | ThrowExpr | SynchronizedExpr
                | SpawnExpr | IfExpr | WhileExpr | DoWhileExpr | ForInExpr | JumpExpr | LambdaExpr | TryExpr
                | InterpolationExpr | QuoteTokenExpr | QuoteExpr | QuoteInterpolationExpr | TrailingClosureExpr
                | UnsafeExpr | MacroExpandExpr | ValuedLiteral => true
            case _ => false
        }
    }

    func isTypeAnnotation(): Bool {
        match (this) {
            case RefType | FuncType | ThisType | ParenType | QualifiedType | OptionType | OptionalType | VArrayType
                | TupleType | CompositeType | Int8Token | Int16Token | Int32Token | Int64Token | IntNativeToken
                | UInt8Token | UInt16Token | UInt32Token | UInt64Token | UIntNativeToken | Float16Token | Float32Token
                | Float64Token | RuneToken | BooleanToken | NothingToken | UnitToken | ThisTypeToken | PrimitiveType => true
            case _ => false
        }
    }

    prop size: Int64 {
        get() {
            return toString().size
        }
    }
}
