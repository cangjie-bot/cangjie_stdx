# 枚举

## enum CompileStage

```cangjie
public enum CompileStage {
    | BeforeMacro
    | AfterSema
    | ...
}
```

功能：表示编译阶段的类型。

示例：

参考[宏展开前 AST 插件示例](../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)和[语义后 AST 插件示例](../plugin_samples/plugin_sample.md#语义后-ast-插件示例)。

### AfterSema

```cangjie
AfterSema
```

功能：表示语义分析之后的编译阶段。

示例：

参考[语义后 AST 插件示例](../plugin_samples/plugin_sample.md#语义后-ast-插件示例)。

### BeforeMacro

```cangjie
BeforeMacro
```

功能：表示宏展开之前的编译阶段。

示例：

参考[宏展开前 AST 插件示例](../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)。
