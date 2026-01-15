# 函数

## func addDiagnostic(DiagnosticInfo, String, Int32, Int32, Int32, Int32)

```cangjie
public func addDiagnostic(info: DiagnosticInfo, filePath: String, beginLine: Int32, beginColumn: Int32, endLine: Int32, endColumn: Int32): Unit
```

功能：用于添加一条诊断信息，包括诊断类型、文件路径和位置信息。

参数：

- info: DiagnosticInfo - 诊断信息内容，包括类型（可以是 `Error` 或 `Warning`）、报错类别和报错信息。
- filePath: String - 诊断信息所在的文件路径。
- beginLine: Int32 - 诊断信息起始行号。
- beginColumn: Int32 - 诊断信息起始列号。
- endLine: Int32 - 诊断信息结束行号。
- endColumn: Int32 - 诊断信息结束列号。

示例：

参考[宏展开前 AST 插件示例](../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)和[语义后 AST 插件示例](../plugin_samples/plugin_sample.md#语义后-ast-插件示例)。

## func registerASTPlugin(() -> ASTPlugin, CompileStage)

```cangjie
public func registerASTPlugin(pluginGen: () -> ASTPlugin, stage: CompileStage)
```

功能：用于注册一个 AST 插件，指定插件生成函数和编译阶段。

参数：

- pluginGen: () -> [ASTPlugin](plugin_package_classes.md#class-astplugin) - 插件生成函数，用于创建插件实例。
- stage: [CompileStage](plugin_package_enums.md#enum-compilestage) - 插件运行的编译阶段。

示例：

参考[@astPlugin 宏](../macros/macros_package_api/macros_package_macros.md#astplugin-宏)。
