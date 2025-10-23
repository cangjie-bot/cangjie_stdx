# 函数

## func parseFile(String)

```cangjie
public func parseFile(filePath: String) : ParsingResult<SourceFile>
```

功能：用于解析一个文本文件，获取一个符合仓颉语法的 [SourceFile](syntax_package_classes.md#class-sourcefile) 类型的抽象语法树。

参数：

- filePath: String - 待解析文件的路径，可以是绝对路径或相对路径。

返回值：

- ParsingResult\<SourceFile> - 一个根节点为 [SourceFile](syntax_package_classes.md#class-sourcefile) 类型的抽象语法树。

异常：

- Exception - 当输入的 `filePath` 不是正确的仓颉源码路径时，抛出异常，异常中包含报错提示信息。

## func parsePackage(String)

```cangjie
public func parsePackage(dirPath: String) : ParsingResult<Package>
```

功能：用于解析一个文件目录，获取一个符合仓颉语法的 [Package](syntax_package_classes.md#class-package) 类型的抽象语法树。

参数：

- dirPath: String - 待解析的文件目录，可以是绝对路径或相对路径。

返回值：

- ParsingResult\<Package> - 一个根节点为 [Package](syntax_package_classes.md#class-package) 类型的抽象语法树。

异常：

- Exception - 当输入的 `dirPath` 不是正确的仓颉包路径时，抛出异常，异常中包含报错提示信息。

## func parseText(String)

```cangjie
public func parseText(programText: String): ParsingResult<SyntaxTreeNode>
```

功能：用于解析一个字符串文本，获取一个符合仓颉语法的抽象语法树节点。

> **注意：**
>
> - 此函数当前仅支持从文本解析出部分声明和大部分表达式节点，具体支持的节点如下：
> - 声明节点：`VarDecl`，`TypeAlias`，`StructDecl`，`StaticInit`，`PropDecl`，`MainDecl`，`MacroDecl`，`InterfaceDecl`，`FuncDecl` （类的主构造函数不支持），`EnumDecl`，`ClassDecl`
> - 表达式节点：除 `OptionalExpr`，`MacroExpandExpr` 和 `StrInterpolationContent` 外的所有表达式节点。

参数：

- programText: String - 待解析的字符串文本。

返回值：

- ParsingResult\<SyntaxTreeNode> - 一个根节点为 [SyntaxTreeNode](syntax_package_classes.md#class-syntaxtreenode) 类型的抽象语法树节点。

异常：

- Exception - 当根据输入文本无法正确解析出单个语法树节点时，抛出异常，异常中包含报错提示消息。

## func parseTokens(Tokens)

```cangjie
public func parseTokens(tokens: Tokens): ParsingResult<SyntaxTreeNode>
```

功能：用于解析一组词法单元，获取一个符合仓颉语法的抽象语法树节点。

> **注意：**
>
> - 此函数当前仅支持从文本解析出部分声明和大部分表达式节点，具体支持的节点如下：
> - 声明节点：`VarDecl`，`TypeAlias`，`StructDecl`，`StaticInit`，`PropDecl`，`MainDecl`，`MacroDecl`，`InterfaceDecl`，`FuncDecl` （类的主构造函数不支持），`EnumDecl`，`ClassDecl`
> - 表达式节点：除 `OptionalExpr`，`MacroExpandExpr` 和 `StrInterpolationContent` 外的所有表达式节点。

参数：

- tokens: Tokens - 待解析的一组词法单元。

返回值：

- ParsingResult\<SyntaxTreeNode> - 一个根节点为 [SyntaxTreeNode](syntax_package_classes.md#class-syntaxtreenode) 类型的抽象语法树节点。

异常：

- Exception - 当根据输入词法单元无法正确解析出单个语法树节点时，抛出异常，异常中包含报错提示消息。