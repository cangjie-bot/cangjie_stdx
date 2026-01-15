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

public abstract class ASTPlugin {
    public prop name: String
    public func run(`package`: Package): Bool
    public open func preAction(): Unit {}
    public open func postAction(): Unit {}
}

class ASTPluginInfo {
    ASTPluginInfo(let pluginGen: () -> ASTPlugin, let stage: CompileStage) {}
}

public enum CompileStage {
    | BeforeMacro
    | AfterSema
    | ...
}

let astPlugins = ArrayList<ASTPluginInfo>()

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