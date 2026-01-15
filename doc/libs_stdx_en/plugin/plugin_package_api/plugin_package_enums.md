# Enums

## enum CompileStage

```cangjie
public enum CompileStage {
    | BeforeMacro
    | AfterSema
    | ...
}
```

Description: Represents the compilation stage type.

Example:

See [Pre-Macro Expansion AST Plugin Example](../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example) and [Post-Semantic AST Plugin Example](../plugin_samples/plugin_sample.md#post-semantic-ast-plugin-example).

### AfterSema

```cangjie
AfterSema
```

Description: Represents the compilation stage after semantic analysis.

Example:

See [Post-Semantic AST Plugin Example](../plugin_samples/plugin_sample.md#post-semantic-ast-plugin-example).

### BeforeMacro

```cangjie
BeforeMacro
```

Description: Represents the compilation stage before macro expansion.

Example:

See [Pre-Macro Expansion AST Plugin Example](../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example).
