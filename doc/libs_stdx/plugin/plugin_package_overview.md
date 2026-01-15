# stdx.plugin

## 功能介绍

plugin 包主要提供了仓颉编译器插件开发框架，支持在编译过程的不同阶段对抽象语法树（Abstract Syntax Tree）进行访问和处理。开发者可以通过继承 `ASTPlugin` 类并注册插件，实现自定义的代码分析、检查或诊断功能。

> **注意：**
>
> plugin 包需要配合 `stdx.syntax` 包使用，用于访问和操作语法树节点。

## API 列表

### 函数

|              函数名          |           功能           |
| --------------------------- | ------------------------ |
| [registerASTPlugin(() -> ASTPlugin, CompileStage)](./plugin_package_api/plugin_package_funcs.md#func-registerastplugin---astplugin-compilestage)  | 用于注册一个 AST 插件，指定插件生成函数和编译阶段。 |
| [addDiagnostic(DiagnosticInfo, String, Int32, Int32, Int32, Int32)](./plugin_package_api/plugin_package_funcs.md#func-adddiagnosticdiagnosticinfo-string-int32-int32-int32-int32)  | 用于添加一条诊断信息，包括诊断类型、文件路径和位置信息。 |

### 类

|                 类名               |                功能                |
| --------------------------------- | ---------------------------------- |
| [ASTPlugin](./plugin_package_api/plugin_package_classes.md#class-astplugin) | 表示 AST 插件的抽象基类，定义了插件的基本 API。 |

### 枚举

|                 枚举名             |                功能                |
| --------------------------------- | ---------------------------------- |
| [CompileStage](./plugin_package_api/plugin_package_enums.md#enum-compilestage) | 表示编译阶段的类型，包括 `BeforeMacro` 和 `AfterSema`。|
