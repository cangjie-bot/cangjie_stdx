# Classes

## class ASTPlugin

```cangjie
public abstract class ASTPlugin {
    public init()
}
```

Description: Abstract base class representing an AST plugin, defining the basic plugin interface.

Developers need to inherit this class and implement the `name` property to specify the plugin name and the `run` method to implement custom AST plugin logic.

Example:

See [Pre-Macro Expansion AST Plugin Example](../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example) and [Post-Semantic AST Plugin Example](../plugin_samples/plugin_sample.md#post-semantic-ast-plugin-example).

### init()

```cangjie
public init()
```

Description: Creates an ASTPlugin object.

### prop name

```cangjie
public open prop name: String
```

Description: Override this abstract property to provide a unique identifier for the plugin.

Type: String

Example:

See [Pre-Macro Expansion AST Plugin Example](../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example).

### func postAction()

```cangjie
public open func postAction(): Unit
```

Description: Callback method called after visiting an AST node, can be overridden in subclasses to perform cleanup operations.

Example:

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

Description: Callback method called before visiting an AST node, can be overridden in subclasses to perform initialization operations.

Example:

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

Description: Override this abstract method to perform checks on the abstract syntax tree.

Parameters:

- `package`: Package - The package node to be processed, containing the complete abstract syntax tree.

Return Value:

- Bool - Returns `true` if the plugin execution succeeds, returns `false` to immediately stop the current plugin execution and skip subsequent plugins.

Example:

See [Pre-Macro Expansion AST Plugin Example](../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example) and [Post-Semantic AST Plugin Example](../plugin_samples/plugin_sample.md#post-semantic-ast-plugin-example).
