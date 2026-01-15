# 类

## class ASTPlugin

```cangjie
public abstract class ASTPlugin {
    public init()
}
```

功能：表示 AST 插件的抽象基类，定义了插件的基本接口。

开发者需要继承此类并实现 `name` 属性以指定插件名字以及 `run` 方法来实现自定义 AST 插件的逻辑。

示例：

参考[宏展开前 AST 插件示例](../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)和[语义后 AST 插件示例](../plugin_samples/plugin_sample.md#语义后-ast-插件示例)。

### init()

```cangjie
public init()
```

功能：创建一个 ASTPlugin 对象。

### prop name

```cangjie
public open prop name: String
```

功能：重写这个抽象属性以给插件提供一个唯一标识符。

类型：String

示例：

参考[宏展开前 AST 插件示例](../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)。

### func postAction()

```cangjie
public open func postAction(): Unit
```

功能：插件遍历到一个 AST 结点后的回调方法，可在子类中重写以执行清理操作。

示例：

```cangjie
@astPlugin[AfterSema]
open class MyPlugin {
    public prop name: String { get() { "MyPlugin" } }
    
    public override func postAction(): Unit {
        println("Finished visiting a node")
    }
    
    public override func run(`package`: Package): Bool {
        true
    }
}
```

### func preAction()

```cangjie
public open func preAction(): Unit
```

功能：插件遍历到一个 AST 结点前的回调方法，可在子类中重写以执行初始化操作。

示例：

```cangjie
@astPlugin[AfterSema]
open class MyPlugin {
    public prop name: String { get() { "MyPlugin" } }
    
    public override func preAction(): Unit {
        println("About to visit a node")
    }
    
    public override func run(`package`: Package): Bool {
        true
    }
}
```

### func run(Package)

```cangjie
public open func run(`package`: Package): Bool
```

功能：重写这个抽象方法以执行对抽象语法树的检查。

参数：

- `package`: Package - 待处理的包节点，包含完整的抽象语法树。

返回值：

- Bool - 返回 `true` 表示插件执行成功，返回 `false` 表示立即结束当前插件的执行，并跳过后面的插件。

示例：

参考[宏展开前 AST 插件示例](../plugin_samples/plugin_sample.md#宏展开前-ast-插件示例)和[语义后 AST 插件示例](../plugin_samples/plugin_sample.md#语义后-ast-插件示例)。
