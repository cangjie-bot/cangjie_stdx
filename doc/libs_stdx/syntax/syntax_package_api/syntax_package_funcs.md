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

- Exception - 当根据 filePath 无法正确解析出对应节点的语法树时，抛出异常，异常中包含报错提示信息。

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

- Exception - 当根据 dirPath 无法正确解析出对应节点的语法树时，抛出异常，异常中包含报错提示信息。