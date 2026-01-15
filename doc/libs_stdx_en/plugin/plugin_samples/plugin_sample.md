# AST Plugin Examples

## Pre-Macro Expansion AST Plugin Example

The following example checks that the `@Derive` macro cannot be used in a package, and reports an error if found.

The Cangjie file plugin.cj contains the following code:

```cangjie
package myplugin
import stdx.plugin.*
import stdx.plugin.macros.*
import stdx.syntax.*
import std.fs.*
import std.collection.*

@astPlugin[BeforeMacro]
open class CheckDeriveUsagePlugin <: ASTPlugin {
    public prop name: String {
        get() {
            "checkDeriveUsage"
        }
    }

    func checkDecl(path: String, decl: MacroExpandDecl): Bool {
        if (let Some(r: SymbolRef) <- (decl.calleeMacro as SymbolRef)) {
            if (r.name == "Derive") {
                addDiagnostic(DiagnosticInfo.Error("derive_in_cj", "@Derive is not allowed"), path, r.nodePos.beginLine, r.nodePos.beginColumn, r.nodePos.endLine, r.nodePos.endColumn)
            }
            if (let WithoutParens(inner) <- decl.macroInputs && let Some(innerMacro: MacroExpandDecl) <- (inner as MacroExpandDecl)) {
                checkDecl(path, innerMacro)
            }
        }
        return true
    }

    func checkFile(path: String, file: SourceFile) {
        for (decl in file.topLevelDecls) {
            if (let Some(m: MacroExpandDecl) <- (decl as MacroExpandDecl)) {
                checkDecl(path, m)
            }
        }
    }

    public override func run(`package`: Package): Bool {
        for (file in `package`.srcFile) {
            checkFile(file.path, file)
        }

        let opts = getCompilerOptions()
        let checkedCjd = HashSet<String>()
        for (dir in opts.importPaths) {
            Directory.walk(dir, { info =>
                if (info.isRegular() && info.path.toString().endsWith(".cj")) {
                    let name = info.name
                    if (checkedCjd.contains(name)) {
                        return true
                    }
                    checkedCjd.add(name)
                    let parseResult = parseCjdFile(info.path.toString())
                    if (let Some(node) <- parseResult.node) {
                        checkFile(name, node)
                    }
                }
                true
            })
        }
        return true
    }
}
```

The Cangjie file main.cj contains the following code:

```cangjie
package my
import std.deriving.*

@Derive[ToString]
public enum Test {
    | A
    | B(Int)
    | ...
}

@Derive[ToString]
public class Test2 {
}
```

```bash
cjc plugin.cj --output-type=dylib -L$CANGJIE_STDX_PATH --import-path=$CANGJIE_STDX_PATH -lstdx.plugin -o libplugin.so
cjc --plugin=libplugin.so -L. -L$CANGJIE_STDX_PATH --import-path=$CANGJIE_STDX_PATH --output-type=staticlib
```

This produces the following result:

```
error: derive_in_cj: @Derive is not allowed
  ==> my.cj.d:4:2:
  | 
4 | @Derive[ToString]
  |  ^^^^^^ 
  | 

error: derive_in_cj: @Derive is not allowed
  ==> my.cj.d:11:2:
   | 
11 | @Derive[ToString]
   |  ^^^^^^ 
   | 

2 errors generated, 2 errors printed.
```

## Post-Semantic AST Plugin Example

The following code checks that all constants defined with `const` in a package must use all uppercase letters, and reports an error if not.

The Cangjie file plugin.cj contains the following code:

```cangjie
package myplugin
import std.unicode.*
import stdx.syntax.*
import stdx.plugin.*
import stdx.plugin.macros.*

@astPlugin[AfterSema]
open class CheckConstVarNamePlugin <: ASTPlugin {
    public prop name: String {
        get() {
            "checkConstVarName"
        }
    }

    public override func run(`package`: Package): Bool {
        for (file in `package`.srcFile) {
            for (decl in file.topLevelDecls) {
                if (let v: VarDecl <- decl && let Const <- v.kind) {
                    // check global const var name is all uppercase
                    if (v.name.toUpper() != v.name) {
                        addDiagnostic(Error("const_var_not_uppercase", "const var name is not all uppercase: ${v.name}, should be ${v.name.toUpper()}"), v.nodePos.filePath, v.nodePos.beginLine, v.nodePos.beginColumn, v.nodePos.endLine, v.nodePos.endColumn)
                        return false
                    }
                }
            }
        }
        println("check const var name is all uppercase success")
        return true
    }
}
```

The Cangjie file main.cj contains the following code:

```cangjie
public const all_uppercase = 1
```

Use the following compilation command:

```bash
cjc plugin.cj --output-type=dylib -L$CANGJIE_STDX_PATH --import-path=$CANGJIE_STDX_PATH -lstdx.plugin -o libplugin.so
cjc --plugin=libplugin.so -L. -L$CANGJIE_STDX_PATH --import-path=$CANGJIE_STDX_PATH --output-type=staticlib
```

This produces the following result:

```
error: const_var_not_uppercase: const var name is not all uppercase: all_uppercase, should be ALL_UPPERCASE
  ==> checkConstVarName.bad.cj:14:1:
   | 
14 | public const all_uppercase = 1
   | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
   | 

1 error generated, 1 error printed.
```

