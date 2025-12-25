# 异常类

## class TarException

```cangjie
public class TarException <: Exception {
    public init(message: String)
}
```

功能：tar 包的异常类。

父类型：

- Exception

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [TarException](tar_package_exceptions.md#class-tarexception) 实例。

参数：

- message: String - 异常提示信息。

示例：

<!-- verify -->
```cangjie
import stdx.compress.tar.*

main(): Unit {
    let exception = TarException("This is a test exception")
    println("TarException message: ${exception.message}")
}
```

运行结果：

```text
TarException message: This is a test exception
```
