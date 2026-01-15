# 宏

## @astPlugin 宏

```cangjie
public macro astPlugin(attrs: Tokens, pluginClass: Tokens): Tokens
```

功能：用于标注 AST 插件类，自动生成插件注册代码。

此宏会在被标注的类上自动生成一个 `registerPlugin` 函数，用于将插件注册到编译器。

参数：

- attrs: Tokens - 宏属性参数，指定插件运行的编译阶段（`CompileStage`）。
- pluginClass: Tokens - 被标注的插件类定义。

返回值：

- Tokens - 包含原始类定义和自动生成的注册函数的词法单元序列。

示例：

<!-- compile -->
<!-- cfg="--compile-macro" -->

```cangjie
import stdx.plugin.*
import stdx.plugin.macros.*

@astPlugin[BeforeMacro]
public class MyPlugin {
    public prop name: String {
        get() { "MyPlugin" }
    }
    
    public func run(`package`: Package): Bool {
        // 插件逻辑
        true
    }
}
```

上述代码会展开成如下形式：

<!-- code_no_check -->

```cangjie
public class MyPlugin <: ASTPlugin {
    public prop name: String {
        get() { "MyPlugin" }
    }
    
    public func run(`package`: Package): Bool {
        // 插件逻辑
        true
    }
}
@C public func registerPlugin() {
    registerASTPlugin({ => MyPlugin() }, BeforeMacro)
}
```

更多示例参考[宏展开前 AST 插件示例](../../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)和[语义后 AST 插件示例](../../plugin_samples/plugin_sample.md#语义后-ast-插件示例)。
