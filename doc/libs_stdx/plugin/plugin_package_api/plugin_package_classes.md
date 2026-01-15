# 类

## class ASTPlugin

```cangjie
public abstract class ASTPlugin {
    public open prop name: String
    public open func run(`package`: Package): Bool
    public open func preAction(): Unit
    public open func postAction(): Unit
}
```

功能：表示 AST 插件的抽象基类，定义了插件的基本接口。

开发者需要继承此类并实现 `run` 方法来创建自定义的 AST 插件。

### prop name

```cangjie
public open prop name: String
```

功能：重写这个抽象属性以给插件提供一个唯一标识符。

类型：String

### func run(Package)

```cangjie
public open func run(`package`: Package): Bool
```

功能：重写这个抽象方法以执行对抽象语法树的检查，通常由编译器调用。

参数：

- `package`: Package - 待处理的包节点，包含完整的抽象语法树。

返回值：

- Bool - 返回 `true` 表示插件执行成功，返回 `false` 表示立即结束当前插件的执行，并跳过后面的插件。

### func preAction()

```cangjie
public open func preAction(): Unit
```

功能：插件执行前的钩子方法，可在子类中重写以执行初始化操作。

### func postAction()

```cangjie
public open func postAction(): Unit
```

功能：插件执行后的钩子方法，可在子类中重写以执行清理操作。
