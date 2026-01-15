# Classes

## class ASTPlugin

```cangjie
public abstract class ASTPlugin {
    public init()
}
```

Description: Abstract base class representing an AST plugin, defining the basic plugin interface.

Developers need to inherit this class and implement the `run` method to create custom AST plugins.

### init()

```cangjie
public init()
```

Description: Default constructor.

### prop name

```cangjie
public open prop name: String
```

Description: Override this abstract property to provide a unique identifier for the plugin.

Type: String

### func postAction()

```cangjie
public open func postAction(): Unit
```

Description: Hook method called after plugin execution, can be overridden in subclasses to perform cleanup operations.

### func preAction()

```cangjie
public open func preAction(): Unit
```

Description: Hook method called before plugin execution, can be overridden in subclasses to perform initialization operations.

### func run(Package)

```cangjie
public open func run(`package`: Package): Bool
```

Description: Override this abstract method to perform checks on the abstract syntax tree, typically called by the compiler.

Parameters:

- `package`: Package - The package node to be processed, containing the complete abstract syntax tree.

Return Value:

- Bool - Returns `true` if the plugin execution succeeds, returns `false` to immediately stop the current plugin execution and skip subsequent plugins.
