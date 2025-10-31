import stdx.CHIR.lib.*
import stdx.CHIR.pluginEntry.*
import stdx.CHIR.pluginMacro.*
import std.collection.*
import std.ast.*

@CHIRPluginMacro
class MyPlugin1 <: CHIRPlugin<Package> {
    // 在遍历CHIR之前运行一次，可以进行一些初始化操作
    public func preVisit(): Unit {
        println(name + " preVisit")
    }
    public func run(pkg: Package): Unit {
        println("MyPlugin1 package name: " + pkg.name)
        println("MyPlugin1 package global funcs size: " + pkg.globalFuncs.size.toString())
        let funcType = _builder.GetFuncType(ArrayList<Type>(), _builder.boolType)
        _builder.CreateGlobalFunc(funcType, "test", "test", "default")
    }
}

// main() {
//     unsafe {
//         registerPlugin()  // c++ load plugin的时候执行一次
//         CHIRPluginEntry() // c++ CHIR阶段执行插件的时候执行这个函数
//     }
//     0
// }