# Functions

## func addDiagnostic(DiagnosticInfo, String, Int32, Int32, Int32, Int32)

```cangjie
public func addDiagnostic(info: DiagnosticInfo, filePath: String, beginLine: Int32, beginColumn: Int32, endLine: Int32, endColumn: Int32): Unit
```

Description: Adds a diagnostic message with diagnostic type, file path, and location information.

Parameters:

- info: DiagnosticInfo - The diagnostic information content, including type (can be `Error` or `Warning`), error category and error message.
- filePath: String - The file path where the diagnostic message is located.
- beginLine: Int32 - The starting line number of the diagnostic message.
- beginColumn: Int32 - The starting column number of the diagnostic message.
- endLine: Int32 - The ending line number of the diagnostic message.
- endColumn: Int32 - The ending column number of the diagnostic message.

Example:

See [Pre-Macro Expansion AST Plugin Example](../plugin_samples/plugin_sample.md#pre-macro-expansion-ast-plugin-example) and [Post-Semantic AST Plugin Example](../plugin_samples/plugin_sample.md#post-semantic-ast-plugin-example).

## func registerASTPlugin(() -> ASTPlugin, CompileStage)

```cangjie
public func registerASTPlugin(pluginGen: () -> ASTPlugin, stage: CompileStage)
```

Description: Registers an AST plugin with a plugin generator function and compile stage.

Parameters:

- pluginGen: () -> [ASTPlugin](plugin_package_classes.md#class-astplugin) - Plugin generator function used to create the plugin instance.
- stage: [CompileStage](plugin_package_enums.md#enum-compilestage) - The compilation stage at which the plugin runs.

Example:

See [@astPlugin Macro](../macros/macros_package_api/macros_package_macros.md#astplugin-macro).
