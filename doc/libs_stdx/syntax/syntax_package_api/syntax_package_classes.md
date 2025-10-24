# 类

## class Annotation

```cangjie
public class Annotation <: SyntaxTreeNode {}
```

功能：表示编译器内置的注解节点。

一个 [Annotation](#class-annotation) 节点：`@CallingConv[xxx]`, `@Attribute[xxx]`, `@When[condition]`等。

父类型：
- [SyntaxTreeNode](#class-syntaxtreenode)

### prop arguments

```cangjie
public prop arguments: Array<Argument>
```

功能：获取 [Annotation](#class-annotation) 中的参数序列，如 `@CallingConv[xxx]` 中的 `xxx`。

类型：Array\<[Argument](#class-argument)>

### prop identifier

```cangjie
public prop identifier: String
```

功能：获取 [Annotation](#class-annotation) 节点的标识符，如 `@CallingConv[xxx]` 中的 `CallingConv`。

类型：String

### prop opKind
 
```cangjie
public prop opKind: AtOpKind
```
 
功能：获取 [Annotation](#class-annotation) 节点的操作符，如 `@CallingConv[xxx]` 中的 `@`。
 
类型：[AtOpKind](syntax_package_enums.md#enum-atopkind)
 
### func getAtOpPos()
 
```cangjie
func getAtOpPos(): CodePositionRange
```
 
功能：获取 [Annotation](#class-annotation) 节点中操作符 `@` 或 `@!` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回操作符 `@` 或 `@!` 的位置


### func getCommasPos()

```cangjie
func getCommasPos(): Array<CodePositionRange>
```

功能：获取 [Annotation](#class-annotation) 节点中 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置。


### func getIdentifierPos()

```cangjie
func getIdentifierPos(): CodePositionRange
```

功能：获取 [Annotation](#class-annotation) 节点中标识符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。


### func getLSquarePos()

```cangjie
func getLSquarePos(): Option<CodePositionRange>
```

功能：获取 [Annotation](#class-annotation) 节点中 `[` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `[` 的位置。


### func getRSquarePos()

```cangjie
func getRSquarePos(): Option<CodePositionRange>
```

功能：获取 [Annotation](#class-annotation) 节点中 `]` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `]` 的位置。


## class Argument

```cangjie
public class Argument <: SyntaxTreeNode {}
```

功能：表示函数调用的实参节点。

例如 `foo(arg:value)` 中的 `arg:value`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop identifier

```cangjie
public prop identifier: Option<String>
```

功能：获取 [Argument](#class-argument) 节点中的标识符，如 `arg:value` 中的 `arg`（若不存在返回 `None`）。

类型：Option\<String>

### prop isInOut

```cangjie
public prop isInOut: Bool
```

功能：获取 [Argument](#class-argument) 节点是否有关键字 `inout`。

类型：Bool

### prop isNamed

```cangjie
public prop isNamed: Bool
```

功能：获取 [Argument](#class-argument) 节点是否为命名参数。

类型：Bool

### prop value

```cangjie
public prop value: Expr
```

功能：获取 [Argument](#class-argument) 节点中的表达式，如 `arg:value` 中的 `value`。

类型：[Expr](#class-expr)

### func getColonPos()

```cangjie
public func getColonPos(): Option<CodePositionRange>
```

功能：获取当前 [Argument](#class-argument) 中 `:` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `:` 的位置（若不存在返回 `None`）。

### func getIdentifierPos()

```cangjie
public func getIdentifierPos(): Option<CodePositionRange>
```

功能：获取当前 [Argument](#class-argument) 中标识符的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回标识符的位置（若不存在返回 `None`）。

### func getInoutKeyWordPos()

```cangjie
public func getInoutKeyWordPos(): Option<CodePositionRange>
```

功能：获取当前 [Argument](#class-argument) 中 `inout` 关键字的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `inout` 关键字的位置（若不存在返回 `None`）。

## class ArrayLiteral

```cangjie
public class ArrayLiteral <: Expr {}
```

功能：表示 Array 字面量节点。

[ArrayLiteral](#class-arrayliteral) 节点：使用格式 `[element1, element2, ... , elementN]` 表示， 每个 `element` 是一个表达式。

父类型：

- [Expr](#class-expr)

### prop elements

```cangjie
public prop elements: Array<Expr>
```

功能：获取 [ArrayLiteral](#class-arrayliteral) 中的表达式列表。

类型：Array\<[Expr](#class-expr)>

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [ArrayLiteral](#class-arrayliteral) 中所有 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `,` 的位置。

### func getLSquarePos()

```cangjie
public func getLSquarePos(): CodePositionRange
```

功能：获取当前 [ArrayLiteral](#class-arrayliteral) 中 `[` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `[` 的位置。

### func getRSquarePos()

```cangjie
public func getRSquarePos(): CodePositionRange
```

功能：获取当前 [ArrayLiteral](#class-arrayliteral) 中 `]` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `]` 的位置。

## class AsExpr

```cangjie
public class AsExpr <: Expr {}
```

功能：表示一个类型转换表达式。

一个 [AsExpr](#class-asexpr) 表达式：`e as T`，类型为 `Option<T>`。其中 `e` 可以是任何类型的表达式，`T` 可以是任何类型。

父类型：

- [Expr](#class-expr)

### prop srcVal

```cangjie
public prop srcVal: Expr
```

功能：获取 [AsExpr](#class-asexpr) 节点中的源表达式节点。

类型：[Expr](#class-expr)

### prop targetTypeAnnotation

```cangjie
public prop targetTypeAnnotation: TypeAnnotation
```

功能：获取 [AsExpr](#class-asexpr) 节点中的目标类型。

类型：[TypeAnnotation](#class-typeannotation)

### func getAsKeyWordPos()

```cangjie
public func getAsKeyWordPos(): CodePositionRange
```

功能：获取 `as` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `as` 的位置。

## class AssignExpr

```cangjie
public class AssignExpr <: Expr {}
```

功能：表示赋值表达式节点。

用于将左操作数的值修改为右操作数的值。一个 [AssignExpr](#class-assignexpr) 节点：`a = b`。

父类型：

- [Expr](#class-expr)

### prop assignOpKind

```cangjie
public prop assignOpKind: AssignOpKind
```

功能：获取 [AssignExpr](#class-assignexpr) 节点中的赋值操作符类型（如 `=` 等）。

类型：[AssignOpKind](syntax_package_enums.md#enum-assignopkind)

### prop lhs

```cangjie
public prop lhs: Expr
```

功能：获取 [AssignExpr](#class-assignexpr) 节点中的左操作数。

类型：[Expr](#class-expr)

### prop rhs

```cangjie
public prop rhs: Expr
```

功能：获取 [AssignExpr](#class-assignexpr) 节点中的右操作数。

类型：[Expr](#class-expr)

### func getAssignOpPos()

```cangjie
public func getAssignOpPos(): CodePositionRange
```

功能：获取赋值操作符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回赋值操作符的位置。

## class ASTVisitor

```cangjie
public open class ASTVisitor
```

功能：语法树的通用访问器基类。开发者可以通过遍历 [SyntaxTreeNode](#class-syntaxtreenode) 及其子类，实现对 Cangjie 源代码结构的统一访问与处理。

### func walk

```cangjie
public func walk(root: SyntaxTreeNode): Unit
```

功能：从指定节点开始深度优先遍历 AST。

参数：

- root: SyntaxTreeNode – 遍历的起始节点。

### func preAction

```cangjie
public open func preAction(node: SyntaxTreeNode): PreActionMode
```

功能：在进入节点前执行的钩子函数，用于决定是否继续、跳过或停止遍历。

参数：

- node – 当前即将访问的节点。

返回值：

- [PreActionMode](syntax_package_enums.md#preactionmode) – 访问节点前的行为策略。

### func postAction

```cangjie
public open func postAction(node: SyntaxTreeNode): PostActionMode
```

功能：在离开节点后执行的钩子函数，用于决定是否继续或停止遍历。

参数：

- `node` – 当前已访问完成的节点。

返回值：

- [PostActionMode](syntax_package_enums.md#postactionmode) – 访问节点完成后的行为策略。

## class AtomicType

```cangjie
public class AtomicType <: TypeAnnotation {}
```

功能：表示一个基本类型节点。

例如数值类型，字符类型，布尔类型等。

父类型：

- [TypeAnnotation](#class-typeannotation)

### prop kind

```cangjie
public prop kind: AtomicTypeKind
```

功能：获取 [AtomicType](#class-atomictype) 的具体类型。

类型：[AtomicTypeKind](syntax_package_enums.md#enum-atomictypekind)

## class BinaryExpr

```cangjie
public class BinaryExpr <: Expr {}
```

功能：表示一个二元操作表达式节点。

一个 [BinaryExpr](#class-binaryexpr) 节点：`1 + 2`

父类型：

- [Expr](#class-expr)

### prop lhs

```cangjie
public prop lhs: Expr
```

功能：获取 [BinaryExpr](#class-binaryexpr) 节点中操作符左侧的表达式节点。

类型：[Expr](#class-expr)

### prop opKind

```cangjie
public prop opKind: BinaryOpKind
```

功能：获取 [BinaryExpr](#class-binaryexpr) 节点中的二元操作符类型。

类型：[BinaryOpKind](syntax_package_enums.md#enum-binaryopkind)

### prop rhs

```cangjie
public prop rhs: Expr
```

功能：获取 [BinaryExpr](#class-binaryexpr) 节点中操作符右侧的表达式节点。

类型：[Expr](#class-expr)

### func getOperatorPos()

```cangjie
public func getOperatorPos(): CodePositionRange
```

功能：获取二元操作符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回二元操作符的位置。

## class Block

```cangjie
public class Block <: SyntaxTreeNode {}
```

功能：表示一个块节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop nodes

```cangjie
public prop nodes: Array<SyntaxTreeNode>
```

功能：获取 [Block](#class-block) 中的表达式或声明序列。

类型：Array\<[SyntaxTreeNode](#class-syntaxtreenode)>

### func getLCurlPos()

```cangjie
func getLCurlPos(): CodePositionRange
```

功能：获取 [Block](#class-block) 节点中 `{` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `{` 的位置。


### func getRCurlPos()

```cangjie
func getRCurlPos(): CodePositionRange
```

功能：获取 [Block](#class-block) 节点中 `}` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `}` 的位置。

## class Body

```cangjie
public class Body <: SyntaxTreeNode {}
```

功能：表示 `Class` 类型、 `Struct` 类型、 `Interface` 类型以及扩展中由 `{}` 和内部的一组声明节点组成的结构。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop memberDecls

```cangjie
public prop memberDecls: Array<Decl>
```

功能：获取 [Body](#class-body) 内的声明节点集合。

类型：Array\<[Decl](#class-decl)>

### func getLCurlPos()
 
```cangjie
public func getLCurlPos(): CodePositionRange
```
 
功能：获取 [Body](#class-body) 节点中 `{` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `{` 的位置。

### func getRCurlPos()
 
```cangjie
 public func getRCurlPos(): CodePositionRange
```
 
功能：获取 [Body](#class-body) 节点中 `}` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `}` 的位置。

## class BreakExpr

```cangjie
public class BreakExpr <: Expr {}
```

功能：表示中断表达式。

用于终止当前循环语句，并将控制权转移到外层代码。[BreakExpr](#class-breakexpr) 节点以 `break` 关键字表示，通常用于循环体内部，以提前退出循环。

父类型：

- [Expr](#class-expr)

## class CallExpr

```cangjie
public class CallExpr <: Expr {}
```

功能：表示函数调用节点。

一个 [CallExpr](#class-callexpr) 节点包括一个表达式，后面紧跟参数列表，例如 `foo(100)`。

父类型：

- [Expr](#class-expr)

### prop arguments

```cangjie
public prop arguments: Array<Argument>
```

功能：获取 [CallExpr](#class-callexpr) 节点中的函数参数。

类型：Array\<[Argument](#class-argument)>

### prop callee

```cangjie
public prop callee: Expr
```

功能：获取 [CallExpr](#class-callexpr) 节点中的函数调用节点。

类型：[Expr](#class-expr)

### func getCommasPos()

```cangjie
func getCommasPos(): Array<CodePositionRange>
```

功能：获取 [CallExpr](#class-callexpr) 节点中 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置。

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取当前 [CallExpr](#class-callexpr) 中 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取当前 [CallExpr](#class-callexpr) 中 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class CatchPattern

```cangjie
public class CatchPattern <: SyntaxTreeNode {}
```

功能：表示一个捕获模式。

用于获取 [TryCatch](#class-trycatch) 中通过模式匹配的方式匹配待捕获的异常序列。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop exceptionType

```cangjie
public prop exceptionType: Array<TypeAnnotation>
```

功能：获取当前捕获模式的异常类型列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### prop pattern

```cangjie
public prop pattern: Pattern
```

功能：获取当前捕获模式的模式。

类型：[Pattern](#class-pattern)

### func getBitOrsPos()

```cangjie
func getBitOrsPos(): Array<CodePositionRange>
```

功能：获取 [CatchPattern](#class-catchpattern) 节点中 `|` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `|` 的位置。

### func getColonPos()

```cangjie
func getColonPos(): Option<CodePositionRange>
```

功能：获取 [CatchPattern](#class-catchpattern) 节点中 `:` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `:` 的位置。

## class ClassDecl

```cangjie
public class ClassDecl <: Decl {
    public prop body: Body
    public prop genericConstraints: Option<GenericConstraints>
    public prop genericParams: Array<GenericParam>
    public prop name: String
    public prop superTyAnnotations: Array<TypeAnnotation>
}
```

功能：表示一个类声明节点。

类的声明使用 `class` 关键字，声明依次为：可缺省的修饰符、`class` 关键字、`class` 名、可选的类型参数、是否指定父类或父接口、可选的泛型约束、类体的声明。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Body
```

功能：获取当前类声明的主体部分。

类型：[Body](#class-body)

### prop genericConstraints

```cangjie
public prop genericConstraints: Option<GenericConstraints>
```

功能：获取当前类声明的泛型约束（若不存在返回 `None`）。

类型：Option\<[GenericConstraints](#class-genericconstraints)>

### prop genericParams

```cangjie
public prop genericParams: Array<GenericParam>
```

功能：获取当前类声明的泛型参数列表。

类型：Array\<[GenericParam](#class-genericparam)>

### prop name

```cangjie
public prop name: String
```

功能：获取当前类声明的名称。

类型：String

### prop superTyAnnotations

```cangjie
public prop superTyAnnotations: Array<TypeAnnotation>
```

功能：获取当前类声明的父类类型标注列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getClassKeyWordPos()
 
```cangjie
public func getClassKeyWordPos(): CodePositionRange
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中 `class` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `class` 关键字 的位置。

### func getGenericParamsCommasPos()
 
```cangjie
public func getGenericParamsCommasPos(): Array<CodePositionRange>
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中泛型参数中 `,` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `,` 的位置。

### func getGenericParamsLAnglePos()

```cangjie
public func getGenericParamsLAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中泛型参数的 `<` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `<` 的位置（若不存在返回 `None`）。

### func getGenericParamsRAnglePos()
 
```cangjie
public func getGenericParamsRAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中泛型参数的 `>` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `>` 的位置（若不存在返回 `None`）

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getSuperTyAnnotationsBitAndsPos()
 
```cangjie
public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange>
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中父类型中 `&` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回父类型中 `&` 的位置。

### func getUpperBoundPos()
 
```cangjie
public func getUpperBoundPos(): Option<CodePositionRange>
```
 
功能：获取 [ClassDecl](#class-classdecl) 节点中 `<:` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `<:` 的位置（若不存在返回 `None`）。

## class CompositeType

```cangjie
public class CompositeType <: TypeAnnotation {}
```

功能：表示一个复合类型节点。例如 `p1.p0.A<Int64>`。

父类型：

- [TypeAnnotation](#class-typeannotation)

### prop name

```cangjie
public prop name: String
```

功能：表示复合类型的名称。

类型：String

### prop prefixes

```cangjie
public prop prefixes: Array<String>
```

功能：表示复合类型的所有前缀类型。

类型：Array\<String>

### prop typeArguments

```cangjie
public prop typeArguments: Array<TypeAnnotation>
```

功能：表示复合类型的所有类型参数。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getLAnglePos()

```cangjie
public func getLAnglePos(): Option<CodePositionRange>
```

功能：获取 `<` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `<` 的位置（若不存在返回 `None`）。

### func getRAnglePos()

```cangjie
public func getRAnglePos(): Option<CodePositionRange>
```

功能：获取 `>` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `>` 的位置（若不存在返回 `None`）。

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取 `,` 的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置序列。

### func getDotsPos()

```cangjie
public func getDotsPos(): Array<CodePositionRange>
```

功能：获取 `.` 的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `.` 的位置序列。

## class ConjunctionCondition

```cangjie
public class ConjunctionCondition <: SyntaxTreeNode {}
```

功能：表示原子条件的逻辑合取。

该节点聚合了多个原子条件，只有当所有原子条件的求值结果都为 `true` 时，该合取条件才会被满足。它对其包含的原子条件之间的关系建模为逻辑 AND 运算。

父类型：

-[SyntaxTreeNode](#class-syntaxtreenode)

### prop cond

```cangjie
public prop cond: Array<AtomicCondition>
```

功能：表示该模式节点中的原子条件列表。

类型：Array\<[AtomicCondition](syntax_package_enums.md#enum-atomiccondition)>

### func getAndsPos()
 
```cangjie
public func getAndsPos(): Array<CodePositionRange>
```
 
功能：获取 [ConjunctionCondition](#class-conjunctioncondition) 节点中 `&&` 的位置序列。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `&&` 的位置序列。

## class ConstPattern

```cangjie
public class ConstPattern <: Pattern {}
```

功能：表示常量模式节点。

常量模式可以是整数字面量、浮点数字面量、字符字面量、布尔字面量、字符串字面量等字面量，如 `case 1 => 0` 中的 `1`。

父类型：

- [Pattern](#class-pattern)

### prop litConstExpr

```cangjie
public prop litConstExpr: LitConstExpr
```

功能：表示该模式节点中的常量表达式节点。

类型：[LitConstExpr](#class-litconstexpr)

## class ContinueExpr

```cangjie
public class ContinueExpr <: Expr {}
```

功能：表示继续表达式。

用于跳过当前循环迭代，直接进入下一次循环迭代。[ContinueExpr](#class-continueexpr) 节点以 `continue` 关键字表示，通常用于循环体内部，以跳过当前迭代的剩余部分。

父类型：

- [Expr](#class-expr)

## class Decl

```cangjie
sealed abstract class Decl <: SyntaxTreeNode {}
```

功能：所有声明节点的父类，继承自 [SyntaxTreeNode](#class-syntaxtreenode) 节点，提供了所有声明节点的通用接口。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop annotations

```cangjie
public prop annotations: Array<Annotation>
```

功能：获取当前声明的注解列表。

类型：Array\<[Annotation](#class-annotation)>

### prop modifiers

```cangjie
public prop modifiers: Array<Modifier>
```

功能：获取当前声明的修饰符列表。

类型：Array\<[Modifier](#class-modifier)>

## class Diagnostic

```cangjie
public class Diagnostic {
    public let codePos: CodePositionRange
    public let diagInfo: DiagnosticInfo
}
```

功能：表示仓颉语法树的一个诊断信息。

### let codePos

```cangjie
public let codePos: CodePositionRange
```

功能：获取当前代码诊断信息的位置信息。

类型：[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)

### let diagInfo

```cangjie
public let diagInfo: DiagnosticInfo
```

功能：获取当前代码诊断信息的具体诊断信息，包括 `Warning`, `Error` 类型等。

类型：[DiagnosticInfo](syntax_package_enums.md#enum-diagnosticinfo)

## class DisjunctionCondition

```cangjie
public class DisjunctionCondition <: SyntaxTreeNode {}
```

功能：表示合取条件的逻辑析取。

该节点聚合了多个合取条件，只要其中至少一个合取条件的求值结果为 `true`，该析取条件就会被满足。它对其包含的合取条件之间的关系建模为逻辑 OR 运算，形成一个析取范式的逻辑表达式。

父类型：

-[SyntaxTreeNode](#class-syntaxtreenode)

### prop cond

```cangjie
public prop cond: Array<ConjunctionCondition>
```

功能：表示该模式节点中的合取条件列表。

类型：Array\<[ConjunctionCondition](#class-conjunctioncondition)>

### func getOrsPos()
 
```cangjie
public func getOrsPos(): Array<CodePositionRange>
```
 
功能：获取 [DisjunctionCondition](#class-disjunctioncondition) 节点中 `||` 的位置序列。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `||` 的位置序列。

## class DoWhileExpr

```cangjie
public class DoWhileExpr <: Expr {}
```

功能：表示 `do-while` 表达式。

父类型：

- [Expr](#class-expr)

### prop body

```cangjie
public prop body: Block
```

功能：获取当前 `do-while` 语句的循环体代码块。

类型：[Block](#class-block)

### prop condition

```cangjie
public prop condition: Expr
```

功能：获取当前 `do-while` 语句的继续条件表达式。

类型：[Expr](#class-expr)

### func getCondLParenPos()
 
```cangjie
public func getCondLParenPos(): CodePositionRange
```
 
功能：获取 [DoWhileExpr](#class-dowhileexpr) 节点中条件的 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回条件的 `(` 的位置。

### func getCondRParenPos()
 
```cangjie
public func getCondRParenPos(): CodePositionRange
```
 
功能：获取 [DoWhileExpr](#class-dowhileexpr) 节点中条件的 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回条件的 `)` 的位置。

### func getDoKeyWordPos()
 
```cangjie
public func getDoKeyWordPos(): CodePositionRange
```
 
功能：获取 [DoWhileExpr](#class-dowhileexpr) 节点中 `do` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `do` 关键字的位置。

### func getWhileKeyWordPos()
 
```cangjie
public func getWhileKeyWordPos(): CodePositionRange
```
 
功能：获取 [DoWhileExpr](#class-dowhileexpr) 节点中 `while` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `while` 关键字的位置。

## class EnumConstructor

```cangjie
public class EnumConstructor <: Decl {}
```

功能：表示一个枚举构造器。

[EnumConstructor](#class-enumconstructor) 类用于在枚举类型中声明一个构造器，`name` 表示构造器的名称，`paramTyAnnotations` 表示构造器参数的类型标注列表。

父类型：

- [Decl](#class-decl)

### prop name

```cangjie
public prop name: String
```

功能：获取当前枚举构造器的名称。

类型：String

### prop paramTyAnnotations

```cangjie
public prop paramTyAnnotations: Array<TypeAnnotation>
```

功能：获取当前枚举构造器参数的类型标注列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [EnumConstructor](#class-enumconstructor) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getParamsCommasPos()
 
```cangjie
public func getParamsCommasPos(): Array<CodePositionRange>
```
 
功能：获取 [EnumConstructor](#class-enumconstructor) 节点中参数间的 `,` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回参数间的 `,` 的位置。

### func getParamsLParenPos()
 
```cangjie
public func getParamsLParenPos(): Option<CodePositionRange>
```
 
功能：获取 [EnumConstructor](#class-enumconstructor) 节点中参数的 `(` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回参数的 `(` 的位置（若不存在返回 `None`）。

### func getParamsRParenPos()
 
```cangjie
public func getParamsRParenPos(): Option<CodePositionRange>
```
 
功能：获取 [EnumConstructor](#class-enumconstructor) 节点中参数的 `)` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回参数的 `)` 的位置（若不存在返回 `None`）。

## class EnumDecl

```cangjie
public class EnumDecl <: Decl {}
```

功能：表示一个 `Enum` 声明节点。

Enum 的声明使用 `enum` 关键字，声明依次为：可缺省的修饰符、`enum` 关键字、`enum` 名、可选的类型参数、是否指定父接口、可选的泛型约束、`enum` 体的声明。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Body
```

功能：获取当前枚举声明的主体部分。

类型：[Body](#class-body)

### prop genericConstraints

```cangjie
public prop genericConstraints: Option<GenericConstraints>
```

功能：获取当前枚举声明的泛型约束（若不存在返回 `None`）。

类型：Option\<[GenericConstraints](#class-genericconstraints)>

### prop genericParams

```cangjie
public prop genericParams: Array<GenericParam>
```

功能：获取当前枚举声明的泛型参数列表。

类型：Array\<[GenericParam](#class-genericparam)>

### prop isNonExhaustive

```cangjie
public prop isNonExhaustive: Bool
```

功能：判断当前枚举声明是否为 `non-exhaustive enum`。

类型：Bool

### prop name

```cangjie
public prop name: String
```

功能：获取当前枚举声明的名称。

类型：String

### prop superTyAnnotations

```cangjie
public prop superTyAnnotations: Array<TypeAnnotation>
```

功能：获取当前枚举声明的父类类型标注列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getCaseSeparatorsPos()
 
```cangjie
public func getCaseSeparatorsPos(): Array<CodePositionRange>
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中 `|` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `|` 的位置。

### func getEnumKeyWordPos()
 
```cangjie
public func getEnumKeyWordPos(): CodePositionRange
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中 `enum` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `enum` 关键字的位置。

### func getGenericParamsCommasPos()
 
```cangjie
public func getGenericParamsCommasPos(): Array<CodePositionRange>
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中泛型参数中 `,` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `,` 的位置。

### func getGenericParamsLAnglePos()
 
```cangjie
public func getGenericParamsLAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中泛型参数的 `<` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `<` 的位置（若不存在返回 `None`）。

### func getGenericParamsRAnglePos()
 
```cangjie
public func getGenericParamsRAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中泛型参数的 `>` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `>` 的位置（若不存在返回 `None`）。

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getNonExhaustiveTripleDotPos()
 
```cangjie
public func getNonExhaustiveTripleDotPos(): Option<CodePositionRange>
```

功能：获取 [EnumDecl](#class-enumdecl) 节点中 `...` 的位置（若不存在返回 `None`）。

返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `...` 的位置（若不存在返回 `None`）。

### func getSuperTyAnnotationsBitAndsPos()
 
```cangjie
public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange>
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点的父类型中 `&` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回父类型中 `&` 的位置。

### func getUpperBoundPos()
 
```cangjie
public func getUpperBoundPos(): Option<CodePositionRange>
```
 
功能：获取 [EnumDecl](#class-enumdecl) 节点中 `<:` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回父类型中 `&` 的位置。

## class EnumPattern

```cangjie
public class EnumPattern <: Pattern {}
```

功能：表示 `enum` 模式节点。

用于匹配 `enum` 的 `constructor`， 如 `case Year(n) => 1` 中的 `Year(n)`。

父类型：

- [Pattern](#class-pattern)

### prop enumConstructor

```cangjie
public prop enumConstructor: SymbolRef
```

功能：表示 `enum` 构造器。

类型：[SymbolRef](#class-symbolref)

### prop enumType

```cangjie
public prop enumType: Option<CompositeType>
```

功能：表示该 `enum` 模式节点中的前缀类型，例如，`p1.p0.E<Int64>` 是模式 `p1.p0.E<Int64>.C0(x)` 的 `enumType`。

类型：Option\<[CompositeType](#class-compositetype)>

### prop subPatterns

```cangjie
public prop subPatterns: Array<Pattern>
```

功能：表示该模式节点中有参构造器内的模式节点列表。

类型：Array\<[Pattern](#class-pattern)>

### func getCommasPos()

```cangjie
func getCommasPos(): Array<CodePositionRange>
```

功能：获取 [EnumPattern](#class-enumpattern) 节点中 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置。

### func getDotPos()

```cangjie
getDotPos(): Option<CodePositionRange>
```

功能：获取 [EnumPattern](#class-enumpattern) 节点中 `.` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `.` 的位置。


### func getLParenPos()

```cangjie
func getLParenPos(): Option<CodePositionRange>
```

功能：获取 [EnumPattern](#class-enumpattern) 节点中 `(` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
func getRParenPos(): Option<CodePositionRange>
```

功能：获取 [EnumPattern](#class-enumpattern) 节点中 `)` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `)` 的位置。

## class Expr

```cangjie
sealed abstract class Expr <: SyntaxTreeNode {}
```

功能：表示一个表达式节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

## class ExtendDecl

```cangjie
public class ExtendDecl <: Decl {}
```

功能：表示一个扩展声明节点。

扩展的声明使用 `extend` 关键字，扩展声明依次为：`extend` 关键字、扩展类型、是否指定父接口、可选的泛型约束、扩展体的声明。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Body
```

功能：获取当前扩展声明的主体部分。

类型：[Body](#class-body)

### prop extendedTyAnnotation

```cangjie
public prop extendedTyAnnotation: TypeAnnotation
```

功能：获取当前扩展声明的被扩展类型标注。

类型：[TypeAnnotation](#class-typeannotation)

### prop genericConstraints

```cangjie
public prop genericConstraints: Option<GenericConstraints>
```

功能：获取当前扩展声明的泛型约束（若不存在返回 `None`）。

类型：Option\<[GenericConstraints](#class-genericconstraints)>

### prop genericParams

```cangjie
public prop genericParams: Array<GenericParam>
```

功能：获取当前扩展声明的泛型参数列表。

类型：Array\<[GenericParam](#class-genericparam)>

### prop superTyAnnotations

```cangjie
public prop superTyAnnotations: Array<TypeAnnotation>
```

功能：获取当前扩展声明的父类类型标注列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getExtendKeyWordPos()
 
```cangjie
public func getExtendKeyWordPos(): CodePositionRange
```
 
功能：获取 [ExtendDecl](#class-extenddecl) 节点中 `extend` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `extend` 关键字的位置。

### func getGenericParamsCommasPos()
 
```cangjie
public func getGenericParamsCommasPos(): Array<CodePositionRange>
```
 
功能：获取 [ExtendDecl](#class-extenddecl) 节点中泛型参数中 `,` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `,` 的位置。

### func getGenericParamsLAnglePos()
 
```cangjie
public func getGenericParamsLAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [ExtendDecl](#class-extenddecl) 节点中泛型参数的 `<` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `<` 的位置（若不存在返回 `None`）。

### func getGenericParamsRAnglePos()
 
```cangjie
public func getGenericParamsRAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [ExtendDecl](#class-extenddecl) 节点中泛型参数的 `>` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `>` 的位置（若不存在返回 `None`）。

### func getSuperTyAnnotationsBitAndsPos()
 
```cangjie
public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange>
```
 
功能：获取 [ExtendDecl](#class-extenddecl) 节点中父类型中 `&` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回父类型中 `&` 的位置。

### func getUpperBoundPos()
 
```cangjie
public func getUpperBoundPos(): Option<CodePositionRange>
```
 
功能：获取 [ExtendDecl](#class-extenddecl) 节点中 `<:` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `<:` 的位置（若不存在返回 `None`）。

## class ForInExpr

```cangjie
public class ForInExpr <: Expr {}
```

功能：表示 `for-in` 表达式。

[ForInExpr](#class-forinexpr) 类型中，关键字 `for` 之后是 [Pattern](#class-pattern), 此后是一个 `in` 关键字和表达式节点，最后是一个执行循环体 [Block](#class-block)。

父类型：

- [Expr](#class-expr)

### prop body

```cangjie
public prop body: Block
```

功能：获取当前 `for-in` 语句的循环体代码块。

类型：[Block](#class-block)

### prop expr

```cangjie
public prop expr: Expr
```

功能：获取当前 `for-in` 语句的集合表达式，即要遍历的对象。

类型：[Expr](#class-expr)

### prop pattern

```cangjie
public prop pattern: Pattern
```

功能：获取当前 `for-in` 语句的迭代变量模式。

类型：[Pattern](#class-pattern)

### prop patternGuard

```cangjie
public prop patternGuard: Option<Expr>
```

功能：获取当前 `for-in` 语句中用于迭代的条件表达式（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### func getForKeyWordPos()
 
```cangjie
public func getForKeyWordPos(): CodePositionRange
```
 
功能：获取 [ForInExpr](#class-forinexpr) 节点中 `for` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `for` 关键字的位置。

### func getInKeyWordPos()
 
```cangjie
public func getInKeyWordPos(): CodePositionRange
```
 
功能：获取 [ForInExpr](#class-forinexpr) 节点中 `in` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `in` 关键字的位置。

### func getLParenPos()
 
```cangjie
public func getLParenPos(): CodePositionRange
```
 
功能：获取 [ForInExpr](#class-forinexpr) 节点中的 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): CodePositionRange
```
 
功能：获取 [ForInExpr](#class-forinexpr) 节点中的 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

### func getWhereKeyWordPos()
 
```cangjie
public func getWhereKeyWordPos(): Option<CodePositionRange>
```
 
功能：获取 [ForInExpr](#class-forinexpr) 节点中 `where` 关键字的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `where` 关键字的位置（若不存在返回 `None`）。

## class FuncDecl

```cangjie
public class FuncDecl <: Decl {}
```

功能：表示一个函数声明节点。

由可选的函数修饰符，关键字 `func`，函数名，可选的泛型约束列表，可选的类型形参列表，函数参数，可选的函数体，可缺省的函数返回类型来声明一个函数。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Option<Block>
```

功能：获取当前函数声明的主体部分（若不存在返回 `None`）。

类型：Option\<[Block](#class-block)>

### prop genericConstraints

```cangjie
public prop genericConstraints: Option<GenericConstraints>
```

功能：获取当前函数声明的泛型约束（若不存在返回 `None`）。

类型：Option\<[GenericConstraints](#class-genericconstraints)>

### prop genericParams

```cangjie
public prop genericParams: Array<GenericParam>
```

功能：获取当前函数声明的泛型参数列表。

类型：Array\<[GenericParam](#class-genericparam)>

### prop kind

```cangjie
public prop kind: FuncKind
```

功能：获取当前函数声明的种类。

类型：[FuncKind](syntax_package_enums.md#enum-funckind)

### prop name

```cangjie
public prop name: String
```

功能：获取当前函数声明的名称。

类型：String

### prop params

```cangjie
public prop params: ParameterList
```

功能：获取当前函数声明的参数列表。

类型：[ParameterList](#class-parameterlist)

### prop retTyAnnotation

```cangjie
public prop retTyAnnotation: Option<TypeAnnotation>
```

功能：获取当前函数声明的返回类型标注（若不存在返回 `None`）。

类型：Option\<[TypeAnnotation](#class-typeannotation)>

### func getFuncKindKeyWordPos()

```cangjie
func getFuncKindKeyWordPos(): Option<CodePositionRange>
```

功能：获取 [FuncDecl](#class-funcdecl) 节点中FuncKind 关键字的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回FuncKind 关键字的位置。

> **注意：**
>
> `kind` 为 `Finalizer` 时，返回 `~` 的位置，`kind` 为 `Operator` 时，返回 `operator` 的位置，`kind` 为 `Foreign` 时，返回 `foriegn` 的位置。

### func getFuncKeyWordPos()

```cangjie
func getFuncKeyWordPos(): Option<CodePositionRange>
```

功能：获取 [FuncDecl](#class-funcdecl) 节点中 `func` 关键字的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `func` 关键字的位置。


### func getGenericParamsCommasPos()

```cangjie
func getGenericParamsCommasPos(): Array<CodePositionRange>
```

功能：获取 [FuncDecl](#class-funcdecl) 节点中泛型参数间 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数间 `,` 的位置。


### func getGenericParamsLAnglePos()

```cangjie
func getGenericParamsLAnglePos(): Option<CodePositionRange>
```

功能：获取 [FuncDecl](#class-funcdecl) 节点中泛型参数 `<` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数 `<` 的位置。

### func getGenericParamsRAnglePos()

```cangjie
func getGenericParamsRAnglePos(): Option<CodePositionRange>
```

功能：获取 [FuncDecl](#class-funcdecl) 节点中泛型参数 `>` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数 `>` 的位置。

### func getIdentifierPos()

```cangjie
func getIdentifierPos(): CodePositionRange
```

功能：获取 [FuncDecl](#class-funcdecl) 节点中标识符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

> **注意：**
>
> `kind` 为 `Finalizer` 时，返回 `init` 的位置。

### func getRetTyAnnotationColonPos()

```cangjie
func getRetTyAnnotationColonPos(): Option<CodePositionRange>
```

获取 [FuncDecl](#class-funcdecl) 节点中类型前 `:` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回类型前 `:` 的位置。


## class FuncParam

```cangjie
public class FuncParam <: Parameter {}
```

功能：表示一个函数参数。

[FuncParam](#class-funcparam) 类用于在程序中声明一个新的函数参数，`defaultValue` 表示参数的默认值，`name` 表示参数的名称，`typeAnnotation` 表示参数的类型标注。

父类型：

- [Parameter](#class-parameter)

### prop defaultValue

```cangjie
public prop defaultValue: Option<Expr>
```

功能：获取当前函数参数的默认值（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### prop kind

```cangjie
public prop kind: Option<VarKind>
```

功能：获取当前函数参数的种类（若不存在返回 `None`）。

类型：Option\<[VarKind](syntax_package_enums.md#enum-varkind)>

### prop name

```cangjie
public prop name: String
```

功能：获取当前函数参数的名称。

类型：String

### prop typeAnnotation

```cangjie
public prop typeAnnotation: TypeAnnotation
```

功能：获取当前函数参数的类型标注。

类型：[TypeAnnotation](#class-typeannotation)

### func getAssignPos()

```cangjie
func getAssignPos(): Option<CodePositionRange>
```

功能：获取 [FuncParam](#class-funcparam) 节点中 `=` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `=` 的位置。


### func getIdentifierPos()

```cangjie
func getIdentifierPos(): CodePositionRange
```

功能：获取 [FuncParam](#class-funcparam) 节点中标识符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。


### func getNotPos()

```cangjie
func getNotPos(): Option<CodePositionRange>
```

功能：获取 [FuncParam](#class-funcparam) 节点中 `!` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `!` 的位置。

### func getTypeAnnotationColonPos()

```cangjie
func getTypeAnnotationColonPos(): CodePositionRange
```

功能：获取 [FuncParam](#class-funcparam) 节点中 `:` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `:` 的位置。

### func getVarKindKeyWordPos()

```cangjie
func getVarKindKeyWordPos(): Option<CodePositionRange>
```

功能：获取 [FuncParam](#class-funcparam) 节点中关键字 `let` 或 `var` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回关键字 `let` 或 `var` 的位置。

## class FuncType

```cangjie
public class FuncType <: TypeAnnotation {}
```

功能：表示函数类型节点。

由函数的参数类型和返回类型组成，参数类型与返回类型之间用 `->` 分隔，如：`(Int32) -> Unit`。

父类型：

- [TypeAnnotation](#class-typeannotation)

### prop labels

```cangjie
public prop labels: Array<String>
```

功能：获取 [FuncType](#class-functype) 节点中的类型参数名，例如 `(name: String, age: Int64) -> Unit` 中的 `name` 和 `age `。

类型：Array\<String>

### prop paramTypes

```cangjie
public prop paramTypes: Array<TypeAnnotation>
```

功能：获取 [FuncType](#class-functype) 节点中函数的参数类型列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### prop retType

```cangjie
public prop retType: TypeAnnotation
```

功能：获取 [FuncType](#class-functype) 的返回类型节点。

类型：[TypeAnnotation](#class-typeannotation)

### func getArrowPos()

```cangjie
public func getArrowPos(): CodePositionRange
```

功能：获取 `->` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `->` 的位置。

### func getColonsPos()

```cangjie
public func getColonsPos(): Array<CodePositionRange>
```

功能：获取 `:` 的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `:` 的位置序列。

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取 `,` 的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置序列。

### func getLabelsPos()

```cangjie
public func getLabelsPos(): Array<CodePositionRange>
```

功能：获取标签的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回标签的位置序列。

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class GenericConstraint

```cangjie
public class GenericConstraint <: SyntaxTreeNode {}
```

功能：表示一个泛型约束节点。

一个 [GenericConstraint](#class-genericconstraint) 节点：`interface Enumerable<T> where T <: Interface & Class {}` 中的 `where T <: Interface & Class`。

> **说明：**
>
> 通过 `where` 之后的 `<:` 符号来声明，其中 `<:` 左边称为类型变元，`<:` 右边称为约束上界，约束上界可以为类型或接口。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop typeArgument

```cangjie
public prop typeArgument: TypeAnnotation
```

功能：获取 [GenericConstraint](#class-genericconstraint) 节点中的类型变元。

类型：[TypeAnnotation](#class-typeannotation)

### prop upperBounds

```cangjie
public prop upperBounds: Array<TypeAnnotation>
```

功能：获取 [GenericConstraint](#class-genericconstraint) 节点约束上界的 [TypeAnnotation](#class-typeannotation) 类型节点的集合。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getBitAndsPos()

```cangjie
func getBitAndsPos(): Array<CodePositionRange>
```

功能：获取 [GenericConstraint](#class-genericconstraint) 节点中 `&` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `&` 的位置。


### func getUpperBoundPos()

```cangjie
func getUpperBoundPos(): CodePositionRange
```

功能：获取 [GenericConstraint](#class-genericconstraint) 节点中 `<:` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `<:` 的位置。

## class GenericConstraints

```cangjie
public class GenericConstraints <: SyntaxTreeNode {}
```

功能：表示一组泛型约束。

一个 [GenericConstraints](#class-genericconstraints) 节点：`interface Enumerable<T1, T2> where T1 <: I1 & I2, T2 <: I3 & I4` 中的 `where T1 <: I1 & I2, T2 <: I3 & I4`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop constraints

```cangjie
public prop constraints: Array<GenericConstraint>
```

功能：获取 [GenericConstraints](#class-genericconstraints) 节点中的所有约束。

类型：Array\<[GenericConstraint](#class-genericconstraint)>

### func getCommasPos()

```cangjie
func getCommasPos(): Array<CodePositionRange>
```

功能：获取 [GenericConstraints](#class-genericconstraints) 节点中 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置。

### func getWhereKeyWordPos()

```cangjie
func getWhereKeyWordPos(): CodePositionRange
```

功能：获取 [GenericConstraints](#class-genericconstraints) 节点中 `where` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `where` 关键字的位置。

## class GenericParam

```cangjie
public class GenericParam <: Decl {}
```

功能：表示一个泛型参数节点。

一个 [GenericParam](#class-genericparam) 节点：`<T1, T2, T3>` 中的 `T1`。

父类型：

- [Decl](#class-decl)

### prop name

```cangjie
public prop name: String
```

功能：获取当前型参的名称。

类型：String

## class IfExpr

```cangjie
public class IfExpr <: Expr {}
```

功能：表示条件表达式。

可以根据判定条件是否成立来决定执行哪条代码分支。一个 [IfExpr](#class-ifexpr) 节点中 `if` 是关键字，`if` 之后是一个小括号，小括号内可以是一个表达式或者一个 `let` 声明的解构匹配，接着是一个 [Block](#class-block)，[Block](#class-block) 之后是可选的 `else` 分支。 `else` 分支以 `else` 关键字开始，后接新的 `if` 表达式或一个 [Block](#class-block)。

父类型：

- [Expr](#class-expr)

### prop condition

```cangjie
public prop condition: DisjunctionCondition
```

功能：获取当前 `if` 语句的条件表达式。

类型：[DisjunctionCondition](#class-disjunctioncondition)

### prop elseBlock

```cangjie
public prop elseBlock: Option<Block>
```

功能：获取当前 `if` 语句的 `else` 分支代码块（若不存在返回 `None`）。

类型：Option\<[Block](#class-block)>

### prop elseIf

```cangjie
public prop elseIf: Option<IfExpr>
```

功能：获取当前 `if` 语句的 `else if` 分支（若不存在返回 `None`）。


类型：Option\<[IfExpr](#class-ifexpr)>

### prop ifBlock

```cangjie
public prop ifBlock: Block
```

功能：获取当前 `if` 语句的 `if` 分支代码块。


类型：[Block](#class-block)

### func getCondLParenPos()
 
```cangjie
public func getCondLParenPos(): CodePositionRange
```
 
功能：获取 [IfExpr](#class-ifexpr) 节点中条件的 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回条件的 `(` 的位置。

### func getCondRParenPos()
 
```cangjie
public func getCondRParenPos(): CodePositionRange
```
 
功能：获取 [IfExpr](#class-ifexpr) 节点中条件的 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回条件的 `)` 的位置。

### func getElseKeyWordPos()
 
```cangjie
public func getElseKeyWordPos(): Option<CodePositionRange>
```
 
功能：获取 [IfExpr](#class-ifexpr) 节点中 `else` 关键字的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `else` 关键字的位置（若不存在返回 `None`）。

### func getIfKeyWordPos()
 
```cangjie
public func getIfKeyWordPos(): CodePositionRange
```
 
功能：获取 [IfExpr](#class-ifexpr) 节点中 `if` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `if` 关键字的位置。

## class ImportAlias

```cangjie
public class ImportAlias <: ImportContent {}
```

功能：表示一个别名导入的包导入声明节点的具体项目，如 `import pkg.a.b as p` 中的 `pkg.a.b as p`。

父类型：

- [ImportContent](#class-importcontent)

### prop aliasName

```cangjie
public prop aliasName: String
```

功能：表示该包导入节点中的别名，如 `pkg.a.b as p` 中的 `p`。

类型：String

### prop identifier

```cangjie
public prop identifier: String
```

功能：表示该包导入节点中的被导入的项，它可能是包中的顶层声明或声明，也可能是子包的名字，如 `pkg.a.b as a` 中的 `b`。

类型：String

### func getAliasNamePos()
 
```cangjie
public func getAliasNamePos(): CodePositionRange
```
 
功能：获取当前 [ImportAlias](#class-importalias) 中包的别名的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回包别名的位置。

### func getAsPos()
 
```cangjie
public func getAsPos(): CodePositionRange
```
 
功能：获取当前 [ImportAlias](#class-importalias) 中 `as` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `as` 关键字的位置。

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取当前 [ImportAlias](#class-importalias) 中原始包名的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回原始包名的位置。

## class ImportAll

```cangjie
public class ImportAll <: ImportContent {}
```

功能：表示一个全导入的包导入声明节点的具体项目，如 `import pkg.*` 中的 `pkg.*`。

父类型：

- [ImportContent](#class-importcontent)

### func getMulPos()
 
```cangjie
public func getMulPos(): CodePositionRange
```
 
功能：获取当前 [ImportAll](#class-importall) 中 `*` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `*` 的位置。

## class ImportContent

```cangjie
public open class ImportContent <: SyntaxTreeNode {}
```

功能：表示一个包导入声明节点的具体声明内容，如 `import pkg.a.b` 中的 `pkg.a.b`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop prefixes

```cangjie
public prop prefixes: Array<String>
```

功能：表示该包导入节点中完整包名的前缀列表，如 `pkg.a.b` 中的 `[pkg, a]`。

类型：Array\<String>

### func getDotsPos()
 
```cangjie
public func getDotsPos(): Array<CodePositionRange>
```
 
功能：获取当前 [ImportContent](#class-importcontent) 中所有 `.` 分隔符的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `.` 分隔符的位置。

### func getPrefixesPos()
 
```cangjie
public func getPrefixesPos(): Array<CodePositionRange>
```

功能：获取当前 [ImportMulti](#class-importmulti) 中所有前缀包名的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有前缀包名的位置。

## class ImportList

```cangjie
public class ImportList <: SyntaxTreeNode {}
```

功能：表示包导入节点。

一个 [ImportList](#class-importlist) 节点：`import pkg.a.b`，`import pkg.a.b as p` 等。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop contents

```cangjie
public prop contents: ImportContent
```

功能：表示该包导入节点中的导入内容。

类型：[ImportContent](#class-importcontent)

### prop kind

```cangjie
public prop kind: ImportKind
```

功能：表示该包导入节点的类型。

类型：[ImportKind](syntax_package_enums.md#enum-importkind)

### prop modifier

```cangjie
public prop modifier: Option<Modifier>
```

功能：表示该包导入节点中的修饰符。

类型：Option\<[Modifier](#class-modifier)>

### func getImportKeyWordPos()
 
```cangjie
public func getImportKeyWordPos(): CodePositionRange
```
 
功能：获取当前 [ImportList](#class-importlist) 中 `import` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `import` 关键字的位置。

## class ImportMulti

```cangjie
public class ImportMulti <: ImportContent {}
```

功能：表示一个多导入的包导入声明节点的具体项目，如 `import pkg.{a.*, b.c, d as p}` 中的 `pkg.{a.*, b.c, d as p}`。

父类型：

- [ImportContent](#class-importcontent)

### prop contents

```cangjie
public prop contents: Array<ImportContent>
```

功能：表示该包导入节点中的多个导入项的列表，如 `pkg.{a.*, b.c, d as p}` 中的 `[a.*, b.c, d as p]`。

类型：Array\<[ImportContent](#class-importcontent)>

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [ImportMulti](#class-importmulti) 中所有 `,` 分隔符的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `,` 分隔符的位置。

### func getLCurlPos()
 
```cangjie
public func getLCurlPos(): CodePositionRange
```
 
功能：获取当前 [ImportMulti](#class-importmulti) 中 `{` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `{` 的位置。

### func getRCurlPos()
 
```cangjie
public func getRCurlPos(): CodePositionRange
```
 
功能：获取当前 [ImportMulti](#class-importmulti) 中 `}` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `}` 的位置。

## class ImportSingle

```cangjie
public class ImportSingle <: ImportContent {}
```

功能：表示一个单导入的包导入声明节点的具体项目，如 `import pkg.a` 中的 `pkg.a`。

父类型：

- [ImportContent](#class-importcontent)

### prop identifier

```cangjie
public prop identifier: String
```

功能：表示该包导入节点中的被导入的项，它可能是包中的顶层声明或声明，也可能是子包的名字，如 `pkg.a` 中的 `a`。

类型：String

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取当前 [ImportSingle](#class-importsingle) 中具体包名的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回具体包名的位置。

## class IncOrDecExpr

```cangjie
public class IncOrDecExpr <: Expr {}
```

功能：表示包含自增操作符（`++`）或自减操作符（`--`）的表达式。

父类型：

- [Expr](#class-expr)

### prop kind

```cangjie
public prop kind: IncOrDecOpKind
```

功能：获取当前自增自减表达式的操作符类型。

类型：[IncOrDecOpKind](syntax_package_enums.md#enum-incordecopkind)

### prop operand

```cangjie
public prop operand: Expr
```

功能：获取 [IncOrDecExpr](#class-incordecexpr) 中的表达式。

类型：[Expr](#class-expr)

### func getOperatorPos()

```cangjie
public func getOperatorPos(): CodePositionRange
```

功能：获取操作符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回操作符的位置。

## class InterfaceDecl

```cangjie
public class InterfaceDecl <: Decl {}
```

功能：表示接口声明节点。

接口的声明使用 `interface` 关键字，接口声明依次为：可缺省的修饰符、`interface` 关键字、接口名、可选的类型参数、是否指定父接口、可选的泛型约束、接口体的声明。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Body
```

功能：获取当前接口声明的主体部分。

类型：[Body](#class-body)

### prop genericConstraints

```cangjie
public prop genericConstraints: Option<GenericConstraints>
```

功能：获取当前接口声明的泛型约束（若不存在返回 `None`）。

类型：Option\<[GenericConstraints](#class-genericconstraints)>

### prop genericParams

```cangjie
public prop genericParams: Array<GenericParam>
```

功能：获取当前接口声明的泛型参数列表。

类型：Array\<[GenericParam](#class-genericparam)>

### prop name

```cangjie
public prop name: String
```

功能：获取当前接口声明的名称。

类型：String

### prop superTyAnnotations

```cangjie
public prop superTyAnnotations: Array<TypeAnnotation>
```

功能：获取当前接口声明的父类类型标注列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getGenericParamsCommasPos()
 
```cangjie
public func getGenericParamsCommasPos(): Array<CodePositionRange>
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中泛型参数中 `,` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `,` 的位置。

### func getGenericParamsLAnglePos()
 
```cangjie
public func getGenericParamsLAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中泛型参数的 `<` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `<` 的位置（若不存在返回 `None`）。

### func getGenericParamsRAnglePos()
 
```cangjie
public func getGenericParamsRAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中泛型参数的 `>` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `>` 的位置（若不存在返回 `None`）。

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getInterfaceKeyWordPos()
 
```cangjie
public func getInterfaceKeyWordPos(): CodePositionRange
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中 `interface` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `interface` 关键字的位置。

### func getSuperTyAnnotationsBitAndsPos()
 
```cangjie
public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange>
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中父类型中 `&` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回父类型中 `&` 的位置。

### func getUpperBoundPos()
 
```cangjie
public func getUpperBoundPos(): Option<CodePositionRange>
```
 
功能：获取 [InterfaceDecl](#class-interfacedecl) 节点中 `<:` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `<:` 的位置（若不存在返回 `None`）。

## class IsExpr

```cangjie
public class IsExpr <: Expr {}
```

功能：表示一个类型检查表达式。

一个 [IsExpr](#class-isexpr) 表达式：`e is T`，类型为 `Bool` 。其中 `e` 可以是任何类型的表达式，`T` 可以是任何类型。

父类型：

- [Expr](#class-expr)

### prop srcVal

```cangjie
public prop srcVal: Expr
```

功能：获取 [IsExpr](#class-isexpr) 节点中的源表达式节点。

类型：[Expr](#class-expr)

### prop targetTypeAnnotation

```cangjie
public prop targetTypeAnnotation: TypeAnnotation
```

功能：获取 [IsExpr](#class-isexpr) 节点中的目标类型。

类型：[TypeAnnotation](#class-typeannotation)

### func getIsKeyWordPos()

```cangjie
public func getIsKeyWordPos(): CodePositionRange
```

功能：获取 `is` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `is` 的位置。

## class Lambda

```cangjie
public class Lambda <: Expr {}
```

功能：表示 `Lambda` 表达式，是一个匿名的函数。

一个 [Lambda](#class-lambda) 节点有两种形式，一种是有形参的，例如 `{a: Int64 => e1; e2 }`，另一种是无形参的，例如 `{ => e1; e2 }`。

父类型：

- [Expr](#class-expr)

### prop body

```cangjie
public prop body: Array<SyntaxTreeNode>
```

功能：获取当前 `Lambda` 表达式的主体代码块。

类型：Array\<[SyntaxTreeNode](#class-syntaxtreenode)>

### prop params

```cangjie
public prop params: ParameterList
```

功能：获取当前 `Lambda` 表达式的参数列表。

类型：[ParameterList](#class-parameterlist)

### func getDoubleArrowPos()

```cangjie
public func getDoubleArrowPos(): Option<CodePositionRange>
```

功能：获取当前 [Lambda](#class-lambda) 中 `=>` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `=>` 的位置（若不存在返回 `None`）。

### func getLCurlPos()

```cangjie
public func getLCurlPos(): CodePositionRange
```

功能：获取当前 [Lambda](#class-lambda) 中 `{` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `{` 的位置。

### func getRCurlPos()

```cangjie
public func getRCurlPos(): CodePositionRange
```

功能：获取当前 [Lambda](#class-lambda) 中 `}` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `}` 的位置。

## class LambdaParam

```cangjie
public class LambdaParam <: Parameter {}
```

功能：表示一个 `lambda` 参数。

[LambdaParam](#class-lambdaparam) 类用于在程序中声明一个新的 `lambda` 参数，`name` 表示参数的名称，`typeAnnotation` 表示参数的类型标注。

父类型：

- [Parameter](#class-parameter)

### prop name

```cangjie
public prop name: String
```

功能：获取当前 `lambda` 参数的名称。

类型：String

### prop typeAnnotation

```cangjie
public prop typeAnnotation: Option<TypeAnnotation>
```

功能：获取 [LambdaParam](#class-lambdaparam) 节点中的类型标注（若不存在返回 `None`）。

类型：Option\<[TypeAnnotation](#class-typeannotation)>

### func getIdentifierPos()

```cangjie
func getIdentifierPos(): CodePositionRange
```

功能：获取 [LambdaParam](#class-lambdaparam) 节点中标识符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getTypeAnnotationColonPos()

```cangjie
func getTypeAnnotationColonPos(): Option<CodePositionRange>
```

功能：获取 [LambdaParam](#class-lambdaparam) 节点中 `:` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `:` 的位置（若不存在返回 `None`）。


## class LetPattern

```cangjie
public class LetPattern <: SyntaxTreeNode {}
```

功能：表示一个 `let` 模式绑定表达式。

它将一个表达式绑定到一个或多个模式以进行解构。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop expr

```cangjie
public prop expr: Expr
```

功能：需要解构的表达式。

类型：[Expr](#class-expr)

### prop patterns

```cangjie
public prop patterns: Array<Pattern>
```

功能：绑定表达式的模式列表。

类型：Array\<[Pattern](#class-pattern)>

### func getBackArrowPos()
 
```cangjie
public func getBackArrowPos(): CodePositionRange
```
 
功能：获取 [LetPattern](#class-letpattern) 节点中 `<-` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `<-` 的位置。

### func getBitOrsPos()
 
```cangjie
public func getBitOrsPos(): Array<CodePositionRange>
```
 
功能：获取 [LetPattern](#class-letpattern) 节点中 `|` 的位置序列。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `|` 的位置序列。

### func getLetKeyWordPos()
 
```cangjie
public func getLetKeyWordPos(): CodePositionRange
```
 
功能：获取 [LetPattern](#class-letpattern) 节点中 `let` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `let` 关键字的位置。

## class LitConstExpr

```cangjie
public open class LitConstExpr <: Expr {}
```

功能：表示一个字面量表达式节点。

一个 [LitConstExpr](#class-litconstexpr) 表达式：`1.0`，`123` 等。

父类型：

- [Expr](#class-expr)

### prop kind

```cangjie
public prop kind: LitConstKind
```

功能：获取当前字面量表达式的类型。

类型：[LitConstKind](syntax_package_enums.md#enum-litconstkind)

### prop rawValue

```cangjie
public prop rawValue: String
```

功能：获取当前字面量表达式的原始值。

类型：String

## class LitConstRuneExpr

```cangjie
public class LitConstRuneExpr <: LitConstExpr {}
```

功能：表示一个字符类型的字面量表达式节点。

一个 [LitConstRuneExpr](#class-litconstruneexpr) 表达式：`r'a'`。

父类型：

- [LitConstExpr](#class-litconstexpr)

> **注意：**
>
> `syntax` 库不支持字符字节字面量，即形如 `b'x'` 的字面量。

### prop isSingleQuote

```cangjie
public prop isSingleQuote: Bool
```

功能：表示当前字符字面量表达式是否为单引号引用。

类型：Bool

## class LitConstStrExpr

```cangjie
public class LitConstStrExpr <: LitConstExpr {}
```

功能：表示一个字符串类型的字面量表达式节点。

一个 [LitConstStrExpr](#class-litconststrexpr) 表达式：`"me"`，`#"hi"#` 等。

父类型：

- [LitConstExpr](#class-litconstexpr)

### prop delimiterNum

```cangjie
public prop delimiterNum: Int64
```

功能：表示当前 [LitConstStrExpr](#class-litconststrexpr) 前后成对出现的 `#` 分隔符数。例如 `##'\n'##` 中 `delimiterNum = 2` 。

类型：Int64

### prop isSingleQuote

```cangjie
public prop isSingleQuote: Bool
```

功能：表示当前 [LitConstStrExpr](#class-litconststrexpr) 是否为单引号引用。

类型：Bool

### prop strKind

```cangjie
public prop strKind: LitConstStrKind
```

功能：获取当前 [LitConstStrExpr](#class-litconststrexpr) 的类型

类型：[LitConstStrKind](syntax_package_enums.md#enum-litconststrkind)

### prop strPartExprs

```cangjie
public prop strPartExprs: Array<StrLiteralPart>
```

功能：获取当前 [LitConstStrExpr](#class-litconststrexpr) 中的各个字符串部分，分为字面量表达式和插值字符串表达式两种。

类型：Array\<[StrLiteralPart](syntax_package_enums.md#enum-strliteralpart)>

### func hasInterpolation()
 
```cangjie
public func hasInterpolation(): Bool
```
 
功能：表示当前 [LitConstStrExpr](#class-litconststrexpr) 是否存在插值。
 
返回值：
 
- Bool - 返回是否存在插值。

## class MacroDecl

```cangjie
class MacroDecl <: Decl {}
```

功能：表示一个宏定义节点。

一个 [MacroDecl](#class-macrodecl) 节点：`public macro M(input: Tokens): Tokens {...}`。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Block
```

功能：获取 [MacroDecl](#class-macrodecl) 节点的函数体。

类型：[Block](#class-block)

### prop name

```cangjie
public prop name: String
```

功能：获取 [MacroDecl](#class-macrodecl) 节点的名称。

类型：String

### prop params

```cangjie
public prop params: ParameterList
```

功能：获取 [MacroDecl](#class-macrodecl) 节点的的参数列表。

类型：[ParameterList](#class-parameterlist)

### prop retTyAnnotation

```cangjie
public prop retTyAnnotation: Option<TypeAnnotation>
```

功能：获取 [MacroDecl](#class-macrodecl) 节点的函数返回类型。

类型：Option\<[TypeAnnotation](#class-typeannotation)>

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [MacroDecl](#class-macrodecl) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getMacroKeyWordPos()
 
```cangjie
public func getMacroKeyWordPos(): CodePositionRange
```
 
功能：获取 [MacroDecl](#class-macrodecl) 节点中 `macro` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `macro` 关键字的位置。

### func getRetTyAnnotationColonPos()
 
```cangjie
public func getRetTyAnnotationColonPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroDecl](#class-macrodecl) 节点中返回类型的冒号的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回返回类型的冒号的位置（若不存在返回 `None`）。

## class MacroExpandDecl

```cangjie
public class MacroExpandDecl <: Decl {}
```

功能：表示宏展开声明。

用于在编译时执行宏并将其展开为具体代码，实现元编程能力。

父类型：

- [Decl](#class-decl)

### prop calleeMacro

```cangjie
public prop calleeMacro: Expr
```

功能：获取被调用的宏表达式。

类型：[Expr](#class-expr)

### prop macroAttrs

```cangjie
public prop macroAttrs: Tokens
```

功能：获取宏的属性标记集合，用于传递编译时元数据。

类型：Tokens

### prop macroInputs

```cangjie
public prop macroInputs: MacroExpandInput
```

功能：获取宏展开的输入声明，定义宏执行所需的上下文。

类型：[MacroExpandInput](syntax_package_enums.md#enum-macroexpandinput)

### func getAtPos()
 
```cangjie
public func getAtPos(): CodePositionRange
```
 
功能：获取 [MacroExpandDecl](#class-macroexpanddecl) 节点中 `@` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `@` 的位置。

### func getLParenPos()
 
```cangjie
public func getLParenPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandDecl](#class-macroexpanddecl) 节点中 `(` 的位置。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `(` 的位置。

### func getLSquarePos()
 
```cangjie
public func getLSquarePos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandDecl](#class-macroexpanddecl) 节点中 `[` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `[` 的位置（若不存在返回 `None`）。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandDecl](#class-macroexpanddecl) 节点中 `)` 的位置。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `)` 的位置。

### func getRSquarePos()
 
```cangjie
public func getRSquarePos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandDecl](#class-macroexpanddecl) 节点中 `]` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `]` 的位置（若不存在返回 `None`）。

## class MacroExpandExpr

```cangjie
public class MacroExpandExpr <: Expr {}
```

功能：表示宏展开表达式。

用于在表达式上下文中执行编译时宏，将宏调用展开为具体的表达式代码。

父类型：

- [Expr](#class-expr)

### prop calleeMacro

```cangjie
public prop calleeMacro: Expr
```

功能：获取被调用的宏表达式。

类型：[Expr](#class-expr)

### prop macroAttrs

```cangjie
public prop macroAttrs: Tokens
```

功能：获取宏的属性标记集合，用于传递编译时元数据。

类型：Tokens

### prop macroInputs

```cangjie
public prop macroInputs: MacroExpandInput
```

功能：获取宏展开的输入声明，定义宏执行所需的上下文。

类型：[MacroExpandInput](syntax_package_enums.md#enum-macroexpandinput)

### func getAtPos()
 
```cangjie
public func getAtPos(): CodePositionRange
```
 
功能：获取 [MacroExpandExpr](#class-macroexpandexpr) 节点中 `@` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `@` 的位置。

### func getLParenPos()
 
```cangjie
public func getLParenPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandExpr](#class-macroexpandexpr) 节点中 `(` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `(` 的位置（若不存在返回 `None`）。

### func getLSquarePos()
 
```cangjie
public func getLSquarePos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandExpr](#class-macroexpandexpr) 节点中 `[` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `[` 的位置（若不存在返回 `None`）。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandExpr](#class-macroexpandexpr) 节点中 `)` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `)` 的位置（若不存在返回 `None`）。

### func getRSquarePos()
 
```cangjie
public func getRSquarePos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandExpr](#class-macroexpandexpr) 节点中 `]` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `]` 的位置（若不存在返回 `None`）。

## class MacroExpandParam

```cangjie
public class MacroExpandParam <: Parameter {}
```

功能：表示宏展开参数。

用于在函数参数定义中应用编译时宏，将宏逻辑应用于参数处理。

父类型：

- [Parameter](#class-parameter)

### prop calleeMacro

```cangjie
public prop calleeMacro: Expr
```

功能：获取被调用的宏表达式。

类型：[Expr](#class-expr)

### prop macroAttrs

```cangjie
public prop macroAttrs: Tokens
```

功能：获取宏的属性标记集合，用于传递编译时元数据。

类型：Tokens

### prop macroInputs

```cangjie
public prop macroInputs: MacroExpandInput
```

功能：获取宏展开的输入声明，定义宏执行所需的上下文。

类型：[MacroExpandInput](syntax_package_enums.md#enum-macroexpandinput)

### func getAtPos()
 
```cangjie
public func getAtPos(): CodePositionRange
```
 
功能：获取 [MacroExpandParam](#class-macroexpandparam) 节点中 `@` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `@` 的位置。

### func getLParenPos()
 
```cangjie
public func getLParenPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandParam](#class-macroexpandparam) 节点中 `(` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `(` 的位置（若不存在返回 `None`）。

### func getLSquarePos()
 
```cangjie
public func getLSquarePos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandParam](#class-macroexpandparam) 节点中 `[` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)>- 返回 `[` 的位置（若不存在返回 `None`）。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandParam](#class-macroexpandparam) 节点中 `)` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)>- 返回 `)` 的位置（若不存在返回 `None`）。

### func getRSquarePos()
 
```cangjie
public func getRSquarePos(): Option<CodePositionRange>
```
 
功能：获取 [MacroExpandParam](#class-macroexpandparam) 节点中 `]` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)>- 返回 `]` 的位置（若不存在返回 `None`）。

## class MainDecl

```cangjie
public class MainDecl <: Decl {}
```

功能：表示一个 `main` 函数声明节点。

一个 [MainDecl](#class-maindecl) 节点：`main() {}`。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Block
```

功能：获取当前主函数声明的主体部分。

类型：[Block](#class-block)

### prop params

```cangjie
public prop params: Array<Parameter>
```

功能：获取当前主函数声明的参数列表。

类型：Array\<[Parameter](#class-parameter)>

### prop retTyAnnotation

```cangjie
public prop retTyAnnotation: Option<TypeAnnotation>
```

功能：获取当前主函数声明的返回类型标注（若不存在返回 `None`）。

类型：Option\<[TypeAnnotation](#class-typeannotation)>

### func getMainKeyWordPos()

```cangjie
func getMainKeyWordPos(): CodePositionRange
```

功能：获取 [MainDecl](#class-maindecl) 节点中 `main` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `main` 关键字的位置。

### func getRetTyAnnotationColonPos()

```cangjie
func getRetTyAnnotationColonPos(): Option<CodePositionRange>
```

功能：获取 [MainDecl](#class-maindecl) 节点中类型前 `:` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回类型前 `:` 的位置。

## class MatchCase

```cangjie
public class MatchCase <: SyntaxTreeNode {}
```

功能：表示 `match` 表达式中的一个 `case` 节点。

一个 [MatchCase](#class-matchcase) 节点：`case failScore where score > 0 => 0`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop body

```cangjie
public prop body: Array<SyntaxTreeNode>
```

功能：获取当前匹配条件满足时执行的代码块。

类型：Array\<[SyntaxTreeNode](#class-syntaxtreenode)>

### prop caseCond

```cangjie
public prop caseCond: Option<Expr>
```

功能：获取当前匹配条件的表达式（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### prop patternGuardCond

```cangjie
public prop patternGuardCond: Option<Expr>
```

功能：获取当前匹配条件的模式守卫表达式（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### prop patterns

```cangjie
public prop patterns: Array<Pattern>
```

功能：获取当前匹配条件的模式列表。

类型：Array\<[Pattern](#class-pattern)>

### func getDoubleArrowPos()

```cangjie
public func getDoubleArrowPos(): CodePositionRange
```

功能：获取当前 [MatchCase](#class-matchcase) 中 `=>` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `=>` 的位置。

### func getBitOrsPos()

```cangjie
public func getBitOrsPos(): Array<CodePositionRange>
```

功能：获取当前 [MatchCase](#class-matchcase) 中所有 `|` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `|` 的位置。

### func getCasePos()

```cangjie
public func getCasePos(): CodePositionRange
```

功能：获取当前 [MatchCase](#class-matchcase) 中 `case` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `case` 关键字的位置。

### func getWherePos()

```cangjie
public func getWherePos(): Option<CodePositionRange>
```

功能：获取当前 [MatchCase](#class-matchcase) 中 `where` 关键字的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `where` 关键字的位置（若不存在返回 `None`）。

## class MatchExpr

```cangjie
public class MatchExpr <: Expr {}
```

功能：表示模式匹配表达式，用于实现模式匹配。

模式匹配表达式分为带 `selector` 的 `match` 表达式和不带 `selector` 的 `match` 表达式。

父类型：

- [Expr](#class-expr)

### prop matchCases

```cangjie
public prop matchCases: Array<MatchCase>
```

功能：获取当前 `match` 语句的所有匹配条件和对应的代码块。

类型：Array\<[MatchCase](#class-matchcase)>

### prop selector

```cangjie
public prop selector: Option<Expr>
```

功能：获取当前 `match` 语句的要匹配的表达式。

类型：Option\<[Expr](#class-expr)>

### func getMatchCasesLCurlPos()

```cangjie
public func getMatchCasesLCurlPos(): CodePositionRange
```

功能：获取当前 [MatchExpr](#class-matchexpr) 中 `{` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `{` 的位置。

### func getMatchCasesRCurlPos()

```cangjie
public func getMatchCasesRCurlPos(): CodePositionRange
```

功能：获取当前 [MatchExpr](#class-matchexpr) 中 `}` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `}` 的位置。

### func getMatchKeyWordPos()

```cangjie
public func getMatchKeyWordPos(): CodePositionRange
```

功能：获取当前 [MatchExpr](#class-matchexpr) 中 `match` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `match` 关键字的位置。

### func getSelectorLParenPos()

```cangjie
public func getSelectorLParenPos(): Option<CodePositionRange>
```

功能：获取当前 [MatchExpr](#class-matchexpr) 的选择器中的 `(` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回选择器中的 `(` 的位置（若不存在返回 `None`）。

### func getSelectorRParenPos()

```cangjie
public func getSelectorRParenPos(): Option<CodePositionRange>
```

功能：获取当前 [MatchExpr](#class-matchexpr) 的选择器中的 `)` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回选择器中的 `)` 的位置（若不存在返回 `None`）。

## class MemberAccess

```cangjie
public class MemberAccess <: Expr {}
```

功能：表示成员访问表达式。

可以用于访问 `class`、`interface`、`struct` 等类型的成员。一个 [MemberAccess](#class-memberaccess) 节点的形式为 `p.a`，`p` 为成员访问表达式的主体，`a` 表示成员的名字。

父类型：

- [Expr](#class-expr)

### prop base

```cangjie
public prop base: Expr
```

功能：获取当前成员访问表达式的基表达式，即被访问的对象或结构体。

类型：[Expr](#class-expr)

### prop field

```cangjie
public prop field: SymbolRef
```

功能：获取当前成员访问表达式中要访问的成员字段。

类型：[SymbolRef](#class-symbolref)

### func getDotPos()

```cangjie
public func getDotPos(): CodePositionRange
```

功能：获取当前 [MemberAccess](#class-memberaccess) 中 `.` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `.` 的位置。

## class Modifier

```cangjie
public class Modifier <: SyntaxTreeNode {}
```

功能：表示某个声明的修饰符，通常放在声明处的最前端。

一个 [Modifier](#class-modifier) 节点：`public func foo()` 中的 `public`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop kind

```cangjie
public prop kind: ModifierKind
```

功能：获取 [Modifier](#class-modifier) 节点的修饰符种类。

类型：[ModifierKind](syntax_package_enums.md#enum-modifierkind)

## class OptionalExpr

```cangjie
public class OptionalExpr <: Expr {}
```

功能：表示一个带有问号操作符的表达式节点。

一个 [OptionalExpr](#class-optionalexpr) 节点：`a?.b, a?(b), a?[b]` 中的 `a?`。

父类型：

- [Expr](#class-expr)

### prop base

```cangjie
public prop base: Expr
```

功能：获取 [OptionalExpr](#class-optionalexpr) 的表达式节点。

类型：[Expr](#class-expr)

### func getQuestionPos()

```cangjie
public func getQuestionPos(): CodePositionRange
```

功能：获取 `?` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `?` 的位置。

## class Package

```cangjie
public class Package <: SyntaxTreeNode {}
```

功能：表示包节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop isMacroPkg

```cangjie
public prop isMacroPkg: Bool
```

功能：表示当前包是否为宏包。

类型：Bool

### prop name

```cangjie
public prop name: String
```

功能：表示当前包的包名。

类型：String

### prop srcFile

```cangjie
public prop srcFile: Array<SourceFile>
```

功能：表示当前包的源码文件列表。

类型：Array\<[SourceFile](#class-sourcefile)>

### func toString()
 
```cangjie
public func toString(): String
```
 
功能：将包节点作为字符串打印出来，包内的文件按文件名字母序排序，对每个文件依次打印文件名和文件内容。
 
返回值：
 
- String - 返回包节点作为字符串打印的结果。

## class PackageHeader

```cangjie
public class PackageHeader <: SyntaxTreeNode {}
```

功能：表示包声明节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop accessModifier

```cangjie
public prop accessModifier: Option<Modifier>
```

功能：表示当前包声明的可见性修饰符。

类型：Option\<[Modifier](#class-modifier)>

### prop isMacroPkg

```cangjie
public prop isMacroPkg: Bool
```

功能：表示当前包是否为宏包。

类型：Bool

### prop packageNameIdentifiers

```cangjie
public prop packageNameIdentifiers: Array<String>
```

功能：获取 [PackageHeader](#class-packageheader) 节点中当前包的包名列表，包含 root 包到当前子包的各级包名。

类型：Array\<String>

### func getDotsPos()

```cangjie
func getDotsPos(): Array<CodePositionRange>
```

功能：获取 [PackageHeader](#class-packageheader) 节点中 `.` 的位置。

返回值：

- Array<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `.` 的位置。


### func getMacroKeyWordPos()

```cangjie
func getMacroKeyWordPos(): Option<CodePositionRange>
```

功能：获取 [PackageHeader](#class-packageheader) 节点中 `macro` 关键字的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `macro` 关键字的位置。


### func getPackageIdentifiersPos()

```cangjie
func getPackageIdentifiersPos(): Array<CodePositionRange>
```

功能：获取 [PackageHeader](#class-packageheader) 节点中包标识符的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回包标识符的位置。

### func getPackageKeyWordPos()

```cangjie
func getPackageKeyWordPos(): CodePositionRange
```

功能：获取 [PackageHeader](#class-packageheader) 节点中 `package` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `package` 关键字的位置。

### func getPackageName()
 
```cangjie
public func getPackageName(): String
```
 
功能：获取 [PackageHeader](#class-packageheader) 节点中的包名。
 
返回值：
 
- String - 返回包名。

### func getParentPackageName()
 
```cangjie
public func getParentPackageName(): String
```
 
功能：获取 [PackageHeader](#class-packageheader) 节点中所有父包的包名。
 
返回值：
 
- String - 返回所有父包的包名。

## class Parameter 

```cangjie
sealed abstract class Parameter <: Decl {}
```

功能：参数节点的父类，继承自 [Decl](#class-decl) 节点。

父类型：

- [Decl](#class-decl)

## class ParameterList

```cangjie
public class ParameterList <: SyntaxTreeNode {}
```

功能：参数列表节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop params
 
```cangjie
public prop params: Array<Parameter>
```
 
功能：获取全部参数。
 
类型：Array\<[Parameter](#class-parameter)>

### func getParamsCommasPos()

```cangjie
func getParamsCommasPos(): Array<CodePositionRange>
```

功能：获取参数间 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回参数间 `,` 的位置。

### func getParamsLParenPos()

```cangjie
func getParamsLParenPos(): Option<CodePositionRange>
```

功能：获取参数前 `(` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回参数前 `(` 的位置。

### func getParamsRParenPos()

```cangjie
func getParamsRParenPos(): Option<CodePositionRange>
```

功能：获取参数后 `)` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回参数后 `)` 的位置。

## class ParenCondition

```cangjie
public class ParenCondition <: SyntaxTreeNode {}
```

功能：表示一个括号条件节点，是指使用圆括号括起来的条件。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop cond

```cangjie
public prop cond: DisjunctionCondition
```

功能：获取 [ParenCondition](#class-parencondition) 节点中由圆括号括起来的条件。

类型：[DisjunctionCondition](#class-disjunctioncondition)

### func getLParenPos()
 
```cangjie
public func getLParenPos(): CodePositionRange
```
 
功能：获取 [ParenCondition](#class-parencondition) 节点中的 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): CodePositionRange
```
 
功能：获取 [ParenCondition](#class-parencondition) 节点中的 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。


## class ParenExpr

```cangjie
public class ParenExpr <: Expr {}
```

功能：表示一个括号表达式节点，是指使用圆括号括起来的表达式。

父类型：

- [Expr](#class-expr)

### prop subExpr

```cangjie
public prop subExpr: Expr
```

功能：获取 [ParenExpr](#class-parenexpr) 节点中由圆括号括起来的子表达式。

类型：[Expr](#class-expr)

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class ParenType

```cangjie
public class ParenType <: TypeAnnotation {}
```

功能：表示括号类型节点。

例如 `var a: (Int64)` 中的 `(Int64)`。

父类型：

- [TypeAnnotation](#class-typeannotation)

### prop subType

```cangjie
public prop subType: TypeAnnotation
```

功能：获取 [ParenType](#class-parentype) 节点中括起来的类型，如 `(Int64)` 中的 `Int64`。

类型：[TypeAnnotation](#class-typeannotation)

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class ParsingResult\<T> where T <: SyntaxTreeNode

```cangjie
public class ParsingResult<T> where T <: SyntaxTreeNode {
    public let diags: Array<Diagnostic>
    public let node: Option<T>
}
```

功能：表示一个符合仓颉语法的抽象语法树。

### let diags

```cangjie
public let diags: Array<Diagnostic>
```

功能：获取当前抽象语法树的全部诊断信息。

类型：Array\<[Diagnostic](#class-diagnostic)>

### let node

```cangjie
public let node: Option<T>
```

功能：获取当前抽象语法树的节点（若不存在返回 `None`）。

类型：Option\<T>，其中 `T` 为 [SyntaxTreeNode](#class-syntaxtreenode) 的子类型 `T`。

## class Pattern

```cangjie
sealed abstract class Pattern <: SyntaxTreeNode {}
```

功能：表示一个模式匹配节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

## class PrefixType

```cangjie
public class PrefixType <: TypeAnnotation {}
```

功能：表示带前缀操作符的前缀类型节点。

例如 `var a : ?A` 中的 `?A`。

父类型：

- [TypeAnnotation](#class-typeannotation)

### prop base

```cangjie
public prop base: TypeAnnotation
```

功能：获取 [PrefixType](#class-prefixtype) 节点中的类型节点，如 `var a: ?A` 中的 `A`。

类型：[TypeAnnotation](#class-typeannotation)

### prop prefixTypeOpKind

```cangjie
public prop prefixTypeOpKind: PrefixTypeOpKind
```

功能：获取 [PrefixType](#class-prefixtype) 节点中的前缀操作符类型。

类型：[PrefixTypeOpKind](syntax_package_enums.md#enum-prefixtypeopkind)

### func getOperatorPos()

```cangjie
public func getOperatorPos(): CodePositionRange
```

功能：获取前缀操作符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回前缀操作符的位置。

## class PropDecl

```cangjie
public class PropDecl <: Decl {}
```

功能：表示一个属性声明节点。

一个 [PropDecl](#class-propdecl) 节点：`prop X: Int64 { get() { 0 } }`。

父类型：

- [Decl](#class-decl)

### prop getter

```cangjie
public prop getter: Option<PropGetterOrSetter>
```

功能：获取当前属性声明的 `getter` 方法（若不存在返回 `None`）。

类型：Option\<[PropGetterOrSetter](#class-propgetterorsetter)>

### prop name

```cangjie
public prop name: String
```

功能：获取当前属性声明的名称。

类型：String

### prop setter

```cangjie
public prop setter: Option<PropGetterOrSetter>
```

功能：获取当前属性声明的 `setter` 方法（若不存在返回 `None`）。

类型：Option\<[PropGetterOrSetter](#class-propgetterorsetter)>

### prop tyAnnotation

```cangjie
public prop tyAnnotation: Option<TypeAnnotation>
```

功能：获取当前属性声明的类型标注。

类型：[TypeAnnotation](#class-typeannotation)

### prop isMut

```cangjie
public prop isMut: Bool
```

功能：判断当前属性声明是否可变。

类型：Bool

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [PropDecl](#class-propdecl) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回标识符的位置。

### func getLCurlPos()
 
```cangjie
public func getLCurlPos(): Option<CodePositionRange>
```
 
功能：获取 [PropDecl](#class-propdecl) 节点中 `{` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `{` 的位置（若不存在返回 `None`）。

### func getPropKeyWordPos()
 
```cangjie
public func getPropKeyWordPos(): CodePositionRange
```
 
功能：获取 [PropDecl](#class-propdecl) 节点中 `prop` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `prop` 关键字的位置。

### func getRCurlPos()
 
```cangjie
public func getRCurlPos(): Option<CodePositionRange>
```
 
功能：获取 [PropDecl](#class-propdecl) 节点中 `}` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `}` 的位置（若不存在返回 `None`）。

### func getTyAnnotationColonPos()
 
```cangjie
public func getTyAnnotationColonPos(): CodePositionRange
```
 
功能：获取 [PropDecl](#class-propdecl) 节点中返回类型前的 `:` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回返回类型前的 `:` 的位置。

## class PropGetterOrSetter

```cangjie
public class PropGetterOrSetter <: Decl {}
```

功能：表示一个属性的 `getter` 或 `setter` 声明。

父类型：

- [Decl](#class-decl)

### prop block

```cangjie
public prop block: Block
```

功能：获取当前属性 `getter` 或 `setter` 方法的主体部分。

类型：[Block](#class-block)

### prop identifier

```cangjie
public prop identifier: Option<String>
```

功能：若为 `setter` 方法，则获取当前方法的输入参数，否则返回None。

类型：Option\<String>

### prop isGetter

```cangjie
public prop isGetter: Bool
```

功能：判断当前属性方法是否为 `getter` 方法。

类型：Bool

### func getGetKeyWordPos()
 
```cangjie
public func getGetKeyWordPos(): Option<CodePositionRange>
```
 
功能：获取 [PropGetterOrSetter](#class-propgetterorsetter) 节点中 `get` 关键字的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `get` 关键字的位置（若不存在返回 `None`）。

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): Option<CodePositionRange>
```
 
功能：获取 [PropGetterOrSetter](#class-propgetterorsetter) 节点中标识符的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回标识符的位置（若不存在返回 `None`）。

### func getLParenPos()
 
```cangjie
public func getLParenPos(): CodePositionRange
```
 
功能：获取 [PropGetterOrSetter](#class-propgetterorsetter) 节点中 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): CodePositionRange
```
 
功能：获取 [PropGetterOrSetter](#class-propgetterorsetter) 节点中 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

### func getSetKeyWordPos()
 
```cangjie
public func getSetKeyWordPos(): Option<CodePositionRange>
```
 
功能：获取 [PropGetterOrSetter](#class-propgetterorsetter) 节点中 `set` 关键字的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `set` 关键字的位置（若不存在返回 `None`）。

## class QuoteExpr

```cangjie
public class QuoteExpr <: Expr {}
```

功能：表示 `quote` 表达式节点。

一个 [QuoteExpr](#class-quoteexpr) 节点： `quote(var ident = 0)`。

父类型：

- [Expr](#class-expr)

### prop tokensOrRefExpr

```cangjie
public prop tokensOrRefExpr: Array<QuoteExprContent>
```

功能：获取 [QuoteExpr](#class-quoteexpr) 中由 `()` 括起的内部引用表达式或 [QuoteToken](#class-quotetoken) 节点。

类型：Array\<[QuoteExprContent](syntax_package_enums.md#enum-quoteexprcontent)>

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取当前 [QuoteExpr](#class-quoteexpr) 中 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getQuoteKeyWordPos()

```cangjie
public func getQuoteKeyWordPos(): CodePositionRange
```

功能：获取当前 [QuoteExpr](#class-quoteexpr) 中 `quote` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `quote` 关键字的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取当前 [QuoteExpr](#class-quoteexpr) 中 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class QuoteInterpolationExpr

```cangjie
public class QuoteInterpolationExpr <: Expr {}
```

功能：表示 [QuoteExpr](#class-quoteexpr) 中由 `()` 括起的内部引用表达式， 例如 `$(A.a)` 或 `$a`。

父类型：

- [Expr](#class-expr)

### prop expr

```cangjie
public prop expr: Expr
```

功能：获取 [QuoteInterpolationExpr](#class-quoteinterpolationexpr) 中被引用的表达式。

类型：[Expr](#class-expr)

### func getDollarPos()

```cangjie
public func getDollarPos(): CodePositionRange
```

功能：获取当前 [QuoteInterpolationExpr](#class-quoteinterpolationexpr) 中 `$` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `$` 的位置。

### func getLParenPos()

```cangjie
public func getLParenPos(): Option<CodePositionRange>
```

功能：获取当前 [QuoteInterpolationExpr](#class-quoteinterpolationexpr) 中 `(` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `(` 的位置（若不存在返回 `None`）。

### func getRParenPos()

```cangjie
public func getRParenPos(): Option<CodePositionRange>
```

功能：获取当前 [QuoteInterpolationExpr](#class-quoteinterpolationexpr) 中 `)` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `)` 的位置（若不存在返回 `None`）。

## class QuoteToken

```cangjie
public class QuoteToken <: SyntaxTreeNode {}
```

功能：表示 `quote` 表达式节点内任意合法的 `token`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop content

```cangjie
public prop content: Tokens
```

功能：获取 [QuoteToken](#class-quotetoken) 内的 Tokens。

类型：Tokens

## class RangeExpr

```cangjie
public class RangeExpr <: Expr {}
```

功能：表示包含区间操作符的表达式。

[RangeExpr](#class-rangeexpr) 节点：存在两种 `Range` 操作符：`..` 和 `..=`，分别用于创建左闭右开和左闭右闭的 `Range` 实例。它们的使用方式分别为 `start..end:step` 和 `start..=end:step`。

父类型：

- [Expr](#class-expr)

### prop end

```cangjie
public prop end: Option<Expr>
```

功能：获取 [RangeExpr](#class-rangeexpr) 中的终止值。

类型：Option\<[Expr](#class-expr)>

### prop kind

```cangjie
public prop kind: RangeKind
```

功能：获取 [RangeExpr](#class-rangeexpr) 的类型。

类型：[RangeKind](syntax_package_enums.md#enum-rangekind)

### prop start

```cangjie
public prop start: Option<Expr>
```

功能：获取 [RangeExpr](#class-rangeexpr) 中的起始值。

类型：Option\<[Expr](#class-expr)>

### prop step

```cangjie
public prop step: Option<Expr>
```

功能：获取 [RangeExpr](#class-rangeexpr) 中的步长表达式。

类型：Option\<[Expr](#class-expr)>

### func getRangeOpPos()

```cangjie
public func getRangeOpPos(): CodePositionRange
```

功能：获取 `..` 或 `..=` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `..` 或 `..=` 的位置。

### func getColonPos()

```cangjie
public func getColonPos(): Option<CodePositionRange>
```

功能：获取 `:` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `:` 的位置（若不存在返回 `None`）。

## class ReturnExpr

```cangjie
public class ReturnExpr <: Expr {}
```

功能：表示 `return` 表达式节点。

一个 [ReturnExpr](#class-returnexpr) 节点：`return 1`。

父类型：

- [Expr](#class-expr)

### prop retVal

```cangjie
public prop retVal: Option<Expr>
```

功能：获取当前 `return` 语句的返回值表达式（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### func getReturnKeyWordPos()

```cangjie
public func getReturnKeyWordPos(): CodePositionRange
```

功能：获取 `return` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `return` 关键字的位置。

## class SourceFile

```cangjie
public class SourceFile <: SyntaxTreeNode {}
```

功能：表示单个仓颉源码文件的语法树节点。

一个仓颉源码文件节点主要包括包声明节点，包导入节点和 TopLevel 作用域内的所有声明节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop importLists

```cangjie
public prop importLists: Array<ImportList>
```

功能：获取仓颉源码文件中包导入节点 [ImportList](#class-importlist) 的列表。

类型：Array\<[ImportList](#class-importlist)>

### prop name

```cangjie
public prop name: String
```

功能：获取仓颉源码文件的名称。

类型：String

### prop path

```cangjie
public prop path: String
```

功能：获取仓颉源码文件的绝对路径。

类型：String

### prop pkgHeader

```cangjie
public prop pkgHeader: Option<PackageHeader>
```

功能：获取仓颉源码文件中包的声明节点 [PackageHeader](#class-packageheader)。

类型：Option\<[PackageHeader](#class-packageheader)>

### prop topLevelDecls

```cangjie
public prop topLevelDecls: Array<Decl>
```

功能：获取仓颉源码文件中 `TopLevel` 作用域内声明的声明节点列表。

类型：Array\<[Decl](#class-decl)>

## class SpawnExpr

```cangjie
public class SpawnExpr <: Expr {}
```

功能：表示 `Spawn` 表达式。

一个 [SpawnExpr](#class-spawnexpr) 节点由 `spawn` 关键字和一个不包含形参的闭包组成，例如：`spawn { add(1, 2) }`。

父类型：

- [Expr](#class-expr)

### prop threadContext

```cangjie
public prop threadContext: Option<Expr>
```

功能：获取当前 `Spawn` 语句的线程执行上下文（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### prop trailingLambdaExpr

```cangjie
public prop trailingLambdaExpr: Lambda
```

功能：获取当前 `Spawn` 语句的线程执行代码块。

类型：[Lambda](#class-lambda)

### func getSpawnKeyWordPos()
 
```cangjie
public func getSpawnKeyWordPos(): CodePositionRange
```
 
功能：获取 [SpawnExpr](#class-spawnexpr) 节点中 `spawn` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `spawn` 关键字的位置。

### func getThreadContextLParenPos()
 
```cangjie
public func getThreadContextLParenPos(): Option<CodePositionRange>
```
 
功能：获取 [SpawnExpr](#class-spawnexpr) 节点中线程上下文的 `(` 的位置。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `return` 关键字的位置。

### func getThreadContextRParenPos()
 
```cangjie
public func getThreadContextRParenPos(): Option<CodePositionRange>
```
 
功能：获取 [SpawnExpr](#class-spawnexpr) 节点中线程上下文的 `)` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回线程上下文的 `)` 的位置（若不存在返回 `None`）。

## class StaticInit

```cangjie
public class StaticInit <: Decl {}
```

功能：表示一个静态初始化器。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Block
```

功能：获取当前静态初始化器的主体部分。

类型：[Block](#class-block)

### func getInitKeyWordPos()
 
```cangjie
public func getInitKeyWordPos(): CodePositionRange
```
 
功能：获取 [StaticInit](#class-staticinit) 节点中 `init` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `init` 关键字的位置。

### func getParamsLParenPos()
 
```cangjie
public func getParamsLParenPos(): CodePositionRange
```
 
功能：获取 [StaticInit](#class-staticinit) 节点中参数左括号的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回参数左括号的位置。

### func getParamsRParenPos()
 
```cangjie
public func getParamsRParenPos(): CodePositionRange
```
 
功能：获取 [StaticInit](#class-staticinit) 节点中参数右括号的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回参数右括号的位置。

### func getStaticKeyWordPos()
 
```cangjie
public func getStaticKeyWordPos(): CodePositionRange
```
 
功能：获取 [StaticInit](#class-staticinit) 节点中 `static` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `static` 关键字的位置。

## class StrInterpolationContent

```cangjie
public class StrInterpolationContent <: SyntaxTreeNode {}
```

功能：表示字符串插值内容的节点。

一个 [StrInterpolationContent](#class-strinterpolationcontent) 节点：`prop str = "hello ${str}"` 中的 `${str}`。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

### prop interpolationBlock

```cangjie
public prop interpolationBlock: Block
```

功能：获取当前字符串插值内容的插值块。

类型：[Block](#class-block)

### func getDollarPos()

```cangjie
public func getDollarPos(): CodePositionRange
```

功能：获取 [StrInterpolationContent](#class-strinterpolationcontent) 节点中 `$` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `$` 关键字的位置。

## class StructDecl

```cangjie
public class StructDecl <: Decl {}
```

功能：表示一个 `Struct` 声明节点。

Struct 的声明使用 `struct` 关键字，声明依次为：可缺省的修饰符、`struct` 关键字、`struct` 名、可选的类型参数、是否指定父接口、可选的泛型约束、`struct` 体的声明。

父类型：

- [Decl](#class-decl)

### prop body

```cangjie
public prop body: Body
```

功能：获取当前结构体声明的主体部分。

类型：[Body](#class-body)

### prop genericConstraints

```cangjie
public prop genericConstraints: Option<GenericConstraints>
```

功能：获取当前结构体声明的泛型约束（若不存在返回 `None`）。

类型：Option\<[GenericConstraints](#class-genericconstraints)>

### prop genericParams

```cangjie
public prop genericParams: Array<GenericParam>
```

功能：获取当前结构体声明的泛型参数列表。

类型：Array\<[GenericParam](#class-genericparam)>

### prop name

```cangjie
public prop name: String
```

功能：获取当前结构体声明的名称。

类型：String

### prop superTyAnnotations

```cangjie
public prop superTyAnnotations: Array<TypeAnnotation>
```

功能：获取当前结构体声明的父类类型标注列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getGenericParamsCommasPos()
 
```cangjie
public func getGenericParamsCommasPos(): Array<CodePositionRange>
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中泛型参数中 `,` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数中 `,` 的位置。

### func getGenericParamsLAnglePos()
 
```cangjie
public func getGenericParamsLAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中泛型参数的 `<` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `<` 的位置（若不存在返回 `None`）。

### func getGenericParamsRAnglePos()
 
```cangjie
public func getGenericParamsRAnglePos(): Option<CodePositionRange>
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中泛型参数的 `>` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回泛型参数的 `>` 的位置（若不存在返回 `None`）。

### func getIdentifierPos()
 
```cangjie
public func getIdentifierPos(): CodePositionRange
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中标识符的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回泛型参数的 `<` 的位置（若不存在返回 `None`）。

### func getStructKeyWordPos()
 
```cangjie
public func getStructKeyWordPos(): CodePositionRange
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中 `struct` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `struct` 关键字的位置。

### func getSuperTyAnnotationsBitAndsPos()
 
```cangjie
public func getSuperTyAnnotationsBitAndsPos(): Array<CodePositionRange>
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中父类型中 `&` 的位置。
 
返回值：
 
- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回父类型中 `&` 的位置。

### func getUpperBoundPos()
 
```cangjie
public func getUpperBoundPos(): Option<CodePositionRange>
```
 
功能：获取 [StructDecl](#class-structdecl) 节点中 `<:` 的位置（若不存在返回 `None`）。
 
返回值：
 
- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `<:` 的位置（若不存在返回 `None`）。

## class SubscriptExpr

```cangjie
public class SubscriptExpr <: Expr {}
```

功能：表示索引访问表达式。

[SubscriptExpr](#class-subscriptexpr) 节点：用于那些支持索引访问的类型（包括 `Array` 类型和 `Tuple` 类型）通过下标来访问其具体位置的元素，如 `arr[0]`。

父类型：

- [Expr](#class-expr)

### prop base

```cangjie
public prop base: Expr
```

功能：获取当前下标表达式的基表达式，即被访问的数据结构。

类型：[Expr](#class-expr)

### prop indexs

```cangjie
public prop indexs: Array<Expr>
```

功能：获取当前下标表达式的索引表达式数组。

类型：Array\<[Expr](#class-expr)>

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [SubscriptExpr](#class-subscriptexpr) 的下标中所有 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回下标中所有 `,` 的位置。

### func getLSquarePos()

```cangjie
public func getLSquarePos(): CodePositionRange
```

功能：获取当前 [SubscriptExpr](#class-subscriptexpr) 中 `[` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `[` 的位置。

### func getRSquarePos()

```cangjie
public func getRSquarePos(): CodePositionRange
```

功能：获取当前 [ArrayLiteral](#class-arrayliteral) 中 `]` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `]` 的位置。

## class SymbolRef

```cangjie
public class SymbolRef <: Expr {}
```

功能：表示代码中通过标识符对某个声明、包的引用的表达式节点。

父类型：

- [Expr](#class-expr)

### prop name

```cangjie
public prop name: String
```

功能：获取 [SymbolRef](#class-symbolref) 节点的标识符。

类型：String

### prop typeArguments

```cangjie
public prop typeArguments: Array<TypeAnnotation>
```

功能：获取 [SymbolRef](#class-symbolref) 节点中的实例化类型。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [SymbolRef](#class-symbolref) 的类型参数中所有 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回类型参数中所有 `,` 的位置。

### func getIdentifierPos()

```cangjie
public func getIdentifierPos(): CodePositionRange
```

功能：获取当前 [SymbolRef](#class-symbolref) 中变量名的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回变量名的位置。

### func getLAnglePos()

```cangjie
public func getLAnglePos(): Option<CodePositionRange>
```

功能：获取当前 [SymbolRef](#class-symbolref) 的类型参数中 `<` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回类型参数中 `<` 的位置（若不存在返回 `None`）。

### func getRAnglePos()

```cangjie
public func getRAnglePos(): Option<CodePositionRange>
```

功能：获取当前 [SymbolRef](#class-symbolref) 的类型参数中 `>` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回类型参数中 `>` 的位置（若不存在返回 `None`）。

## class SynchronizedExpr

```cangjie
public class SynchronizedExpr <: Expr {}

```

功能：表示 `synchronized` 表达式。

一个 [SynchronizedExpr](#class-synchronizedexpr) 节点由 `synchronized` 关键字和 `StructuredMutex` 对以及后面的代码块组成，例如 `synchronized(m) { foo() }`。

### prop block

```cangjie
public prop block: Block
```

功能：获取当前 `synchronized` 语句的代码块，即需要同步执行的代码。

类型：[Block](#class-block)

### prop structuredMutex

```cangjie
public prop structuredMutex: Expr
```

功能：获取当前 `synchronized` 语句的锁对象表达式。

类型：[Expr](#class-expr)

### func getLParenPos()
 
```cangjie
public func getLParenPos(): CodePositionRange
```
 
功能：获取 [SynchronizedExpr](#class-synchronizedexpr) 节点中 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()
 
```cangjie
public func getRParenPos(): CodePositionRange
```
 
功能：获取 [SynchronizedExpr](#class-synchronizedexpr) 节点中 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

### func getSynchronizedKeyWordPos()
 
```cangjie
public func getSynchronizedKeyWordPos(): CodePositionRange
```
 
功能：获取 [SynchronizedExpr](#class-synchronizedexpr) 节点中 `synchronized` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `synchronized` 关键字的位置。

## class SyntaxTreeNode

```cangjie
sealed abstract class SyntaxTreeNode <: ToString & Hashable & Equatable<SyntaxTreeNode> {
    public let nodePos: CodePositionRange
    public let parentNode: Option<SyntaxTreeNode>
}
```

功能：所有仓颉语法树节点的父类。

该类提供了所有数据类型通用的操作接口。

父类型：

- ToString
- Hashable
- Equatable\<[SyntaxTreeNode](#class-syntaxtreenode)>

### let nodePos

```cangjie
public let nodePos: CodePositionRange
```

功能：获取当前语法树节点的位置信息，包含起点和终点位置。

> **注意：**
>
> [Package](#class-package) 节点的起始和结束行列号均为0，文件信息为空。

类型：[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)

### let parentNode

```cangjie
public let parentNode: Option<SyntaxTreeNode>
```

功能：获取当前语法树节点的父节点信息（若不存在返回 `None`）。

类型：Option\<[SyntaxTreeNode](#class-syntaxtreenode)>

### func toString()
 
```cangjie
public open func toString(): String
```
 
功能：将语法树节点作为字符串打印出来，保留原本的相对位置信息。

> **注意：**
>
> 当前语法树节点的打印不支持行尾空格、分号以及各类注释的打印。
 
返回值：
 
- String - 返回语法树节点打印为字符串的结果。

### operator func ==(SyntaxTreeNode)

```cangjie
public operator func ==(that: SyntaxTreeNode): Bool
```

功能：判断当前 [SyntaxTreeNode](#class-syntaxtreenode) 与传入的 [SyntaxTreeNode](#class-syntaxtreenode) 是否相等。

参数：

- that: [SyntaxTreeNode](#class-syntaxtreenode) - 被比较的另一个 [SyntaxTreeNode](#class-syntaxtreenode) 对象。

返回值：

- Bool - 两个 [SyntaxTreeNode](#class-syntaxtreenode) 相等则为 `true` ，不等则为 `false`。

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取 [SyntaxTreeNode](#class-syntaxtreenode) 对象的哈希值。

返回值：

- Int64 - 当前 [SyntaxTreeNode](#class-syntaxtreenode) 对象的哈希值。

## class ThrowExpr

```cangjie
public class ThrowExpr <: Expr {}

```

功能：表示一个 `throw` 表达式。

[ThrowExpr](#class-throwexpr) 类用于在程序中抛出异常，`throwVal` 表示被抛出的异常对象。

父类型：

- [Expr](#class-expr)

### prop throwVal

```cangjie
public prop throwVal: Expr
```

功能：获取当前 `throw` 语句的异常值表达式。

类型：[Expr](#class-expr)

### func getThrowKeyWordPos()

```cangjie
public func getThrowKeyWordPos(): CodePositionRange
```

功能：获取当前 [ThrowExpr](#class-throwexpr) 中 `throw` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `throw` 关键字的位置。

## class TrailingClosureExpr

```cangjie
public class TrailingClosureExpr <: Expr {}
```

功能：表示尾随闭包表达式。尾随闭包是一种语法糖，允许将闭包作为函数的最后一个参数时，可以放在函数调用括号之后。

父类型：

- [Expr](#class-expr)

### prop arguments

```cangjie
public prop arguments: Array<Argument>
```

功能：获取 [TrailingClosureExpr](#class-trailingclosureexpr) 节点中的函数参数。

类型：Array\<[Argument](#class-argument)>

### prop callee

```cangjie
public prop callee: Expr
```

功能：获取调用表达式，即包含尾随闭包的函数调用。

类型：[Expr](#class-expr)

### prop trailingLambdaExpr

```cangjie
public prop trailingLambdaExpr: Lambda
```

功能：获取尾随闭包对应的 `Lambda` 表达式。

类型：[Lambda](#class-lambda)

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [TrailingClosureExpr](#class-trailingclosureexpr) 节点中所有 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `,` 的位置。

### func getLParenPos()

```cangjie
func getLParenPos(): Option<CodePositionRange>
```

功能：获取 [TrailingClosureExpr](#class-trailingclosureexpr) 节点中 `(` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
func getRParenPos(): Option<CodePositionRange>
```

功能：获取 [TrailingClosureExpr](#class-trailingclosureexpr) 节点中 `)` 的位置。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `)` 的位置。

## class TryCatch

```cangjie
public class TryCatch <: Expr {}
```

功能：表示 `try-catch` 表达式节点。

`try-catch` 表达式包括三个部分：`try` 块，`catch` 块和 `finally` 块。

父类型：

- [Expr](#class-expr)

### prop catchBlocks

```cangjie
public prop catchBlocks: Array<Block>
```

功能：获取异常处理代码块的数组，每个代码块对应一种异常处理方式。

类型：Array\<[Block](#class-block)>

### prop catchPatterns

```cangjie
public prop catchPatterns: Array<CatchPattern>
```

功能：获取异常匹配模式的数组，每个模式对应一个异常类型。

类型：Array\<[CatchPattern](#class-catchpattern)>

### prop finallyBlock

```cangjie
public prop finallyBlock: Option<Block>
```

功能：获取最终执行的代码块，无论异常是否被捕获和处理，该代码块总是会被执行（若不存在返回 `None`）。

类型：Option\<[Block](#class-block)>

### prop resourceSpec

```cangjie
public prop resourceSpec: Array<VarDecl>
```

功能：获取需要在完成后释放的资源声明。

类型：Array\<[VarDecl](#class-vardecl)>

### prop tryBlock

```cangjie
public prop tryBlock: Block
```

功能：获取需要监控的异常的代码块。

类型：[Block](#class-block)

### func getCatchKeyWordsPos()

```cangjie
public func getCatchKeyWordsPos(): Array<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 中所有 `catch` 关键字的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `catch` 关键字的位置。

### func getCatchLParensPos()

```cangjie
public func getCatchLParensPos(): Array<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 的所有 `catch` 语句中 `(` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `catch` 语句中 `(` 的位置。

### func getCatchRParensPos()

```cangjie
public func getCatchRParensPos(): Array<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 的所有 `catch` 语句中 `)` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `catch` 语句中 `)` 的位置。

### func getFinallyKeyWordPos()

```cangjie
public func getFinallyKeyWordPos(): Option<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 中 `finally` 关键字的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `finally` 关键字的位置（若不存在返回 `None`）。

### func getResourceSpecCommasPos()

```cangjie
public func getResourceSpecCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 的 `resource` 语句中所有 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `resource` 语句中所有 `,`的位置。

### func getResourceSpecLParenPos()

```cangjie
public func getResourceSpecLParenPos(): Option<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 的 `resource` 语句中 `(` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `resource` 语句中 `(` 的位置（若不存在返回 `None`）。

### func getResourceSpecRParenPos()

```cangjie
public func getResourceSpecRParenPos(): Option<CodePositionRange>
```

功能：获取当前 [TryCatch](#class-trycatch) 的 `resource` 语句中 `)` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `resource` 语句中 `)` 的位置（若不存在返回 `None`）。

### func getTryKeyWordPos()

```cangjie
public func getTryKeyWordPos(): CodePositionRange
```

功能：获取当前 [TryCatch](#class-trycatch) 中 `try` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `try` 关键字的位置。

## class TupleLiteral

```cangjie
public class TupleLiteral <: Expr {}
```

功能：表示 `Tuple` 字面量节点。

[TupleLiteral](#class-tupleliteral) 节点：使用格式 `(element1, element2, ... , elementN)` 表示， 每个 `element` 是一个表达式。

父类型：

- [Expr](#class-expr)

### prop elements

```cangjie
public prop elements: Array<Expr>
```

功能：获取 [TupleLiteral](#class-tupleliteral) 中的表达式列表。

类型：Array\<[Expr](#class-expr)>

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取当前 [TupleLiteral](#class-tupleliteral) 中所有 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回所有 `,` 的位置。

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取当前 [TupleLiteral](#class-tupleliteral) 中 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取当前 [TupleLiteral](#class-tupleliteral) 中 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class TuplePattern

```cangjie
public class TuplePattern <: Pattern {}
```

功能：表示 `Tuple` 模式节点。

用于 `tuple` 值的匹配，如 `case ("Bob", age) => 1` 中的 `("Bob", age)`。

父类型：

- [Pattern](#class-pattern)

### prop subPatterns

```cangjie
public prop subPatterns: Array<Pattern>
```

功能：表示该模式节点中元组内的一组模式节点。


类型：Array\<[Pattern](#class-pattern)>

### func getCommasPos()

```cangjie
func getCommasPos(): Array<CodePositionRange>
```

功能：获取 [TuplePattern](#class-tuplepattern) 节点中 `,` 的位置。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置。


### func getLParenPos()

```cangjie
func getLParenPos(): CodePositionRange
```

功能：获取 [TuplePattern](#class-tuplepattern) 节点中 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。


### func getRParenPos()

```cangjie
func getRParenPos(): CodePositionRange
```

功能：获取 [TuplePattern](#class-tuplepattern) 节点中 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class TupleType

```cangjie
public class TupleType <: TypeAnnotation {}
```

功能：表示元组类型节点。

例如 `var a : (Int64, Int32)` 中的 `(Int64, Int32)`。

父类型：

- [TypeAnnotation](#class-typeannotation)


### prop elements

```cangjie
public prop elements: Array<TypeAnnotation>
```

功能：获取 [TupleType](#class-tupletype) 节点中的类型节点列表。

类型：Array\<[TypeAnnotation](#class-typeannotation)>

### prop labels

```cangjie
public prop labels: Array<String>
```

功能：获取 [TupleType](#class-tupletype) 节点中的类型参数名，例如 `(name: String, age: Int64)` 中的 `name` 和 `age `。

类型：Array\<String>

### func getColonsPos()

```cangjie
public func getColonsPos(): Array<CodePositionRange>
```

功能：获取 `:` 的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `:` 的位置序列。

### func getCommasPos()

```cangjie
public func getCommasPos(): Array<CodePositionRange>
```

功能：获取 `,` 的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `,` 的位置序列。

### func getLabelsPos()

```cangjie
public func getLabelsPos(): Array<CodePositionRange>
```

功能：获取标签的位置序列。

返回值：

- Array\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回标签的位置序列。

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class TypeAlias

```cangjie
public class TypeAlias <: Decl {}
```

功能：表示类型别名节点。

一个 [TypeAlias](#class-typealias) 节点： `type Point2D = Float64`。

父类型：

- [Decl](#class-decl)

### prop aliasName

```cangjie
public prop aliasName: String
```

功能：获取当前类型别名的名称。

类型：String

### prop originalTyAnnotation

```cangjie
public prop originalTyAnnotation: TypeAnnotation
```

功能：获取当前类型别名的原始类型的注解。

类型：Option\<[TypeAnnotation](#class-typeannotation)>

### prop typeParameters

```cangjie
public prop typeParameters: Array<GenericParam>
```

功能：获取当前类型别名的类型参数。

类型：Array\<[GenericParam](#class-genericparam)>

### func getAssignPos()

```cangjie
public func getAssignPos(): CodePositionRange
```

功能：获取当前 [TypeAlias](#class-typealias) 中 `=` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `=` 的位置。

### func getIdentifierPos()

```cangjie
public func getIdentifierPos(): CodePositionRange
```

功能：获取当前 [TypeAlias](#class-typealias) 中类型别名的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回类型别名的位置。

### func getTypeAliasKeyWordPos()

```cangjie
public func getTypeAliasKeyWordPos(): CodePositionRange
```

功能：获取当前 [TypeAlias](#class-typealias) 中 `type` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `type` 关键字的位置。

## class TypeAnnotation

```cangjie
sealed abstract class TypeAnnotation <: SyntaxTreeNode {}
```

功能：表示一个类型标注节点。

父类型：

- [SyntaxTreeNode](#class-syntaxtreenode)

## class TypeConvExpr

```cangjie
public class TypeConvExpr <: Expr {}
```

功能：表示一个类型转换表达式。

用于实现若干数值类型间的转换。一个 [TypeConvExpr](#class-typeconvexpr) 节点：`Int8(32)`。

父类型：

- [Expr](#class-expr)

### prop srcVal

```cangjie
public prop srcVal: Expr
```

功能：获取 [TypeConvExpr](#class-typeconvexpr) 中的源表达式节点。

类型：[Expr](#class-expr)

### prop targetTypeAnnotation

```cangjie
public prop targetTypeAnnotation: AtomicType
```

功能：获取 [TypeConvExpr](#class-typeconvexpr) 中将要转换到的目标类型。

类型：[AtomicType](#class-atomictype)

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class TypePattern

```cangjie
public class TypePattern <: Pattern {}
```

功能：表示类型模式节点。

用于判断一个值的运行时类型是否是某个类型的子类型，如 `case b: Base => 0` 中的 `b: Base`。

父类型：

- [Pattern](#class-pattern)

### prop patternType

```cangjie
public prop patternType: TypeAnnotation
```

功能：表示该模式节点中的待匹配的类型节点。

类型：[TypeAnnotation](#class-typeannotation)

### prop subPattern

```cangjie
public prop subPattern: Pattern
```

功能：表示该模式节点中的被判断值的模式节点。

类型：[Pattern](#class-pattern)

### func getColonPos()

```cangjie
func getColonPos(): CodePositionRange
```

功能：获取 [TypePattern](#class-typepattern) 节点中 `:` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `:` 的位置。

## class UnaryExpr

```cangjie
public class UnaryExpr <: Expr {}
```

功能：表示一个一元操作表达式节点。

一个 [UnaryExpr](#class-unaryexpr) 节点：`-1`

父类型：

- [Expr](#class-expr)

### prop opKind

```cangjie
public prop opKind: UnaryOpKind
```

功能：获取 [UnaryExpr](#class-unaryexpr) 节点中的一元操作符。

类型：[UnaryOpKind](syntax_package_enums.md#enum-unaryopkind)

### prop operand

```cangjie
public prop operand: Expr
```

功能：获取 [UnaryExpr](#class-unaryexpr) 节点中的操作数。

类型：[Expr](#class-expr)

### func getOperatorPos()

```cangjie
public func getOperatorPos(): CodePositionRange
```

功能：获取一元操作符的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回一元操作符的位置。

## class UnsafeExpr

```cangjie
public class UnsafeExpr <: Expr {}
```

功能：表示一个不安全代码块。

用于标记包含不安全操作（如指针操作、内存管理等）的代码区域，编译器会对该区域放松安全检查。

父类型：

- [Expr](#class-expr)

### prop block

```cangjie
public prop block: Block
```

功能：获取不安全代码块的内容。

类型：[Block](#class-block)

### func getUnsafePos()

```cangjie
public func getUnsafePos(): CodePositionRange
```

功能：获取当前 [UnsafeExpr](#class-unsafeexpr) 中 `unsafe` 关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `unsafe` 关键字的位置。

## class VarDecl

```cangjie
public class VarDecl <: Decl {}
```

功能：表示变量声明节点。

一个 [VarDecl](#class-vardecl) 节点: `var a: String`，`var b: Int64 = 1` 等。

父类型：

- [Decl](#class-decl)

### prop initializer

```cangjie
public prop initializer: Option<Expr>
```

功能：获取当前变量声明的初始化表达式（若不存在返回 `None`）。

类型：Option\<[Expr](#class-expr)>

### prop kind

```cangjie
public prop kind: VarKind
```

功能：获取当前变量声明的种类。

类型：[VarKind](syntax_package_enums.md#enum-varkind)

### prop pattern

```cangjie
public prop pattern: Pattern
```

功能：获取当前变量声明的模式。

类型：[Pattern](#class-pattern)

### prop tyAnnotation

```cangjie
public prop tyAnnotation: Option<TypeAnnotation>
```

功能：获取当前变量声明的类型标注（若不存在返回 `None`）。

类型：Option\<[TypeAnnotation](#class-typeannotation)>

### prop name

```cangjie
public prop name: String
```

功能：当前变量声明的模式为 `VarPattern` 时，获取其名称，其他模式返回空字符串。

类型：String

### func getAssignPos()

```cangjie
public func getAssignPos(): Option<CodePositionRange>
```

功能：获取当前 [VarDecl](#class-vardecl) 中 `=` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回 `=` 的位置（若不存在返回 `None`）。

### func getIdentifierPos()

```cangjie
public func getIdentifierPos(): Option<CodePositionRange>
```

功能：获取当前 [VarDecl](#class-vardecl) 中变量标识符的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回变量标识符的位置（若不存在返回 `None`）。

### func getTyAnnotationColonPos()

```cangjie
public func getTyAnnotationColonPos(): Option<CodePositionRange>
```

功能：获取当前 [VarDecl](#class-vardecl) 中类型名之前的 `:` 的位置（若不存在返回 `None`）。

返回值：

- Option\<[CodePositionRange](syntax_package_structs.md#struct-codepositionrange)> - 返回类型名之前的 `:` 的位置（若不存在返回 `None`）。

### func getVarKindKeyWordPos()

```cangjie
public func getVarKindKeyWordPos(): CodePositionRange
```

功能：获取当前 [VarDecl](#class-vardecl) 中变量声明类型关键字的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回变量声明类型关键字的位置。

## class VarOrEnumPattern

```cangjie
public class VarOrEnumPattern <: Pattern {}
```

功能：表示当模式的标识符为 `Enum` 构造器时的节点。

例如 `case RED` 中的 `RED` 为 `Enum` 构造器。

父类型：

- [Pattern](#class-pattern)

### prop identifier

```cangjie
public prop identifier: String
```

功能：表示该模式节点中的标识符。

类型：String

## class VarPattern

```cangjie
public class VarPattern <: Pattern {}
```

功能：表示绑定模式节点。

使用一个合法的标识符表示，如 `for (i in 1..10)` 中的 `i`。

父类型：

- [Pattern](#class-pattern)

### prop name

```cangjie
public prop name: String
```

功能：表示该模式节点中的标识符。

类型：String

## class VArrayExpr

```cangjie
public class VArrayExpr <: Expr {}
```

功能：表示 `VArray` 表达式的实例节点。

一个 [VArrayExpr](#class-varrayexpr) 节点：`prop arr: VArray<Int64, $5> = VArray<Int64, $5>({ i => i })` 中的 `VArray<Int64, $5>({ i => i })`。

父类型：

- [Expr](#class-expr)

### prop argument

```cangjie
public prop argument: Argument
```

功能：获取 [VArrayExpr](#class-varrayexpr) 中的初始化参数。

类型：[Argument](#class-argument)

### prop vArrayType

```cangjie
public prop vArrayType: VArrayType
```

功能：获取 [VArrayExpr](#class-varrayexpr) 中的 `VArray` 类型节点。

类型：[VArrayType](#class-varraytype)

### func getLParenPos()

```cangjie
public func getLParenPos(): CodePositionRange
```

功能：获取当前 [VArrayExpr](#class-varrayexpr) 中 `(` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `(` 的位置。

### func getRParenPos()

```cangjie
public func getRParenPos(): CodePositionRange
```

功能：获取当前 [VArrayExpr](#class-varrayexpr) 中 `)` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `)` 的位置。

## class VArrayType

```cangjie
public class VArrayType <: TypeAnnotation {}
```

功能：表示 `VArray` 类型节点。

使用泛型 `VArray<T, $N>` 表示 `VArray` 类型，其中 `T` 表示该值类型数组的元素类型，`$N` 是一个固定的语法，通过 `$` 加上一个 `Int64` 类型的数值字面量表示这个值类型数组的长度。

父类型：

- [TypeAnnotation](#class-typeannotation)

### prop elementType

```cangjie
public prop elementType: TypeAnnotation
```

功能：获取 [VArrayType](#class-varraytype) 节点中的类型变元节点，如 `VArray<Int16, $0>` 中的 `Int16`。

类型：[TypeAnnotation](#class-typeannotation)

### prop size

```cangjie
public prop size: Int64
```

功能：获取 [VArrayType](#class-varraytype) 节点的大小。

类型：Int64

### func getCommaPos()

```cangjie
public func getCommaPos(): CodePositionRange
```

功能：获取 `,` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `,` 的位置。

### func getDollarPos()

```cangjie
public func getDollarPos(): CodePositionRange
```

功能：获取 `$` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `$` 的位置。

### func getLAnglePos()

```cangjie
public func getLAnglePos(): CodePositionRange
```

功能：获取 `<` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `<` 的位置。

### func getRAnglePos()

```cangjie
public func getRAnglePos(): CodePositionRange
```

功能：获取 `>` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `>` 的位置。

### func getVArrayPos()

```cangjie
public func getVArrayPos(): CodePositionRange
```

功能：获取 `VArray` 的位置。

返回值：

- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `VArray` 的位置。

## class WhileExpr

```cangjie
public class WhileExpr <: Expr {}
```

功能：表示 `while` 表达式。

`while` 是关键字，`while` 之后是一个小括号，小括号内可以是一个表达式或者一个 `let` 声明的解构匹配，接着是一个 [Block](#class-block) 节点。

父类型：

- [Expr](#class-expr)

### prop body

```cangjie
public prop body: Block
```

功能：表示 `while` 循环的循环体。

类型：[Block](#class-block)

### prop condition

```cangjie
public prop condition: DisjunctionCondition
```

功能：表示 `while` 循环的条件。

类型：[DisjunctionCondition](#class-disjunctioncondition)

### func getCondLParenPos()
 
```cangjie
public func getCondLParenPos(): CodePositionRange
```
 
功能：获取 [WhileExpr](#class-whileexpr) 节点中条件的 `(` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回条件的 `(` 的位置。

### func getCondRParenPos()
 
```cangjie
public func getCondRParenPos(): CodePositionRange
```
 
功能：获取 [WhileExpr](#class-whileexpr) 节点中条件的 `)` 的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回条件的 `)` 的位置。

### func getWhileKeyWordPos()
 
```cangjie
public func getWhileKeyWordPos(): CodePositionRange
```
 
功能：获取 [WhileExpr](#class-whileexpr) 节点中 `while` 关键字的位置。
 
返回值：
 
- [CodePositionRange](syntax_package_structs.md#struct-codepositionrange) - 返回 `while` 关键字的位置。

## class WildcardPattern

```cangjie
public class WildcardPattern <: Pattern {}
```

功能：表示通配符模式节点。

父类型：

- [Pattern](#class-pattern)