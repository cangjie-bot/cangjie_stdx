# stdx.plugin

## Overview

The plugin package provides a Cangjie compiler plugin development framework that supports accessing and processing the Abstract Syntax Tree (AST) at different stages of compilation. Developers can create custom code analysis, checking, or diagnostic functionality by inheriting the `ASTPlugin` class and registering the plugin.

> **Note:**
>
> The plugin package needs to be used together with the `stdx.syntax` package for accessing syntax tree nodes.

## API List

### Functions

|              Function Name          |           Description           |
| ----------------------------------- | ------------------------------- |
| [registerASTPlugin(() -> ASTPlugin, CompileStage)](./plugin_package_api/plugin_package_funcs.md#func-registerastplugin---astplugin-compilestage)  | Registers an AST plugin with a plugin generator function and compile stage. |
| [addDiagnostic(DiagnosticInfo, String, Int32, Int32, Int32, Int32)](./plugin_package_api/plugin_package_funcs.md#func-adddiagnosticdiagnosticinfo-string-int32-int32-int32-int32)  | Adds a diagnostic message with diagnostic type, file path, and location information. |

### Classes

|                 Class Name               |                Description                |
| ---------------------------------------- | ----------------------------------------- |
| [ASTPlugin](./plugin_package_api/plugin_package_classes.md#class-astplugin) | Abstract base class representing an AST plugin, defining the basic plugin interface. |

### Enums

|                 Enum Name             |                Description                |
| ------------------------------------- | ----------------------------------------- |
| [CompileStage](./plugin_package_api/plugin_package_enums.md#enum-compilestage) | Represents the compilation stage type, including `BeforeMacro` and `AfterSema`. |

