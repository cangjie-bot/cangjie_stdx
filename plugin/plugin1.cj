import stdx.CHIR.lib.*
import stdx.plugin.*
import stdx.plugin.execute.*
import stdx.plugin.register.*
import std.collection.*
import std.ast.*

@RegisterPlugin[Package]
class MyPlugin1 {
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
