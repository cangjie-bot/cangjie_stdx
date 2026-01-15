/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.plugin

import std.collection.ArrayList
import stdx.syntax.*

/**
 * Abstract base class representing an AST plugin, defining the basic plugin interface.
 *
 * Developers need to inherit this class and implement the `run` method to create custom AST plugins.
 */
public abstract class ASTPlugin {
    /**
     * Override this abstract property to provide a unique identifier for the plugin.
     */
    public prop name: String

    /**
     * Override this abstract method to perform checks on the abstract syntax tree, typically called by the compiler.
     *
     * @param package The package node to be processed, containing the complete abstract syntax tree.
     * @return Returns `true` if the plugin execution succeeds, returns `false` to immediately stop
     *         the current plugin execution and skip subsequent plugins.
     */
    public func run(`package`: Package): Bool

    /**
     * Callback method called before visiting an AST node, can be overridden in subclasses to perform initialization operations.
     */
    public open func preAction(): Unit {}

    /**
     * Callback method called after visiting an AST node, can be overridden in subclasses to perform cleanup operations.
     */
    public open func postAction(): Unit {}
}

class ASTPluginInfo {
    ASTPluginInfo(let pluginGen: () -> ASTPlugin, let stage: CompileStage) {}
}

/**
 * Represents the compilation stage type at which an AST plugin runs.
 */
public enum CompileStage {
    /**
     * Represents the compilation stage before macro expansion.
     */
    | BeforeMacro
    /**
     * Represents the compilation stage after semantic analysis.
     */
    | AfterSema
    | ...
}

let astPlugins = ArrayList<ASTPluginInfo>()

/**
 * Registers an AST plugin with a plugin generator function and compile stage.
 *
 * @param pluginGen Plugin generator function used to create the plugin instance.
 * @param stage The compilation stage at which the plugin runs.
 */
public func registerASTPlugin(pluginGen: () -> ASTPlugin, stage: CompileStage) {
    astPlugins.add(ASTPluginInfo(pluginGen, stage))
}

@C struct FbPackage {
    // fb is used to manage c++ memory
    // package is the serialized package
    // size is the size of the serialized package
    FbPackage(let fb: CPointer<UInt8>, let `package`: CPointer<UInt8>, let size: UInt64) {}
}
@C foreign func SerializeCppPackageToFb(`package`: CPointer<UInt8>): FbPackage
@C foreign func DeleteCppFbPackage(buffer: CPointer<UInt8>): Unit

// \param packagePtr is pointer to the C++ package
@C protected func executeASTPlugins(packagePtr: CPointer<UInt8>, stage: Int32): Bool {
    unsafe {
        let fb: FbPackage = SerializeCppPackageToFb(packagePtr) // serialised as flatbuffers package
        let p = deserialisePackage(fb.`package`, UIntNative(fb.size)) // deserialised as Cangjie package
        try {
            for (plugin in astPlugins) {
                if (let BeforeMacro <- plugin.stage && stage != 0 || let AfterSema <- plugin.stage && stage != 1) {
                    continue
                }
                let pluginObj = plugin.pluginGen()
                if (!pluginObj.run(p)) {
                    return false
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            return false
        } catch (e: Error) {
            e.printStackTrace()
            return false
        } finally {
            DeleteCppFbPackage(fb.fb)
        }
        return true
    }
}