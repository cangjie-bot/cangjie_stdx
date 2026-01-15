/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
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
    | CHIR
    | ...
}
let astPlugins = ArrayList<ASTPluginInfo>()
public func registerASTPlugin(pluginGen: () -> ASTPlugin, stage: CompileStage) {
    astPlugins.add(ASTPluginInfo(pluginGen, stage))
}

@C foreign func SerializePackageToFb(`package`: CPointer<UInt8>): CPointer<UInt8>
@C foreign func GetPackage(buffer: CPointer<UInt8>): CPointer<UInt8>
@C foreign func GetPackageSize(buffer: CPointer<UInt8>): UInt64
@C foreign func DeleteFb(buffer: CPointer<UInt8>): Unit

@C protected func executeASTPlugins(packagePtr: CPointer<UInt8>, stage: Int32, options_: CPointer<UInt8>): Bool {
    unsafe {
        let fb = SerializePackageToFb(packagePtr)
        let pak = GetPackage(fb)
        let size = GetPackageSize(fb)
        let p = deserialisePackage(pak, UIntNative(size))
        options = deserialiseOptions(options_)
        try {
            for (plugin in astPlugins) {
                if (let BeforeMacro <- plugin.stage && stage != 0 || let AfterSema <- plugin.stage && stage != 1) {
                    continue
                }
                let pluginObj = plugin.pluginGen()
                if (!pluginObj.run(p)) {
                    DeleteFb(fb)
                    return false
                }
            }
        } catch (e: Exception) {
            e.printStackTrace()
            DeleteFb(fb)
            return false
        } catch (e: Error) {
            e.printStackTrace()
            DeleteFb(fb)
            return false
        }
        DeleteFb(fb)
        return true
    }
}