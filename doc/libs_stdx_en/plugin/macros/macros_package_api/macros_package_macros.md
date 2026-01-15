# Macros

## @astPlugin Macro

```cangjie
public macro astPlugin(attrs: Tokens, pluginClass: Tokens): Tokens
```

Description: Annotates an AST plugin class and automatically generates plugin registration code.

This macro automatically generates a `registerPlugin` function on the annotated class, used to register the plugin with the compiler.

Parameters:

- attrs: Tokens - Macro attribute parameters specifying the compilation stage (`CompileStage`) at which the plugin runs.
- pluginClass: Tokens - The plugin class definition being annotated.

Return Value:

- Tokens - A token sequence containing the original class definition and the automatically generated registration function.

Example:

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
        // Plugin logic
        true
    }
}
```

The above code expands to the following form:

<!-- code_no_check -->

```cangjie
public class MyPlugin <: ASTPlugin {
    public prop name: String {
        get() { "MyPlugin" }
    }
    
    public func run(`package`: Package): Bool {
        // Plugin logic
        true
    }
}
@C public func registerPlugin() {
    registerASTPlugin({ => MyPlugin() }, BeforeMacro)
}
```

For more examples, see [Pre-Macro Expansion AST Plugin Example](../../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example) and [Post-Semantic AST Plugin Example](../../plugin_samples/plugin_sample.md#post-semantic-ast-plugin-example).
