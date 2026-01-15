# Functions

## func registerASTPlugin(() -> ASTPlugin, CompileStage)

```cangjie
public func registerASTPlugin(pluginGen: () -> ASTPlugin, stage: CompileStage)
```

Description: Registers an AST plugin with a plugin generator function and compile stage.

Parameters:

- pluginGen: () -> [ASTPlugin](plugin_package_classes.md#class-astplugin) - Plugin generator function used to create the plugin instance.
- stage: [CompileStage](plugin_package_enums.md#enum-compilestage) - The compilation stage at which the plugin runs.

## func addDiagnostic(DiagnosticInfo, String, Int32, Int32, Int32, Int32)

```cangjie
public func addDiagnostic(info: DiagnosticInfo, filePath: String, beginLine: Int32, beginColumn: Int32, endLine: Int32, endColumn: Int32): Unit
```

Description: Adds a diagnostic message with diagnostic type, file path, and location information.

Parameters:

- info: DiagnosticInfo - The diagnostic information type, can be `Error` or `Warning`.
- filePath: String - The file path where the diagnostic message is located.
- beginLine: Int32 - The starting line number of the diagnostic message.
- beginColumn: Int32 - The starting column number of the diagnostic message.
- endLine: Int32 - The ending line number of the diagnostic message.
- endColumn: Int32 - The ending column number of the diagnostic message.

