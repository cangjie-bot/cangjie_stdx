# 延迟效应处理器（Deferred Effect Handler）

本示例展示了如何通过定义一个简单的效应（Command）并**保存对应的 resumption（继续执行上下文）**，以便稍后手动恢复（resume），从而实现延迟处理的效果。

该示例还展示了：**如果尝试对同一个 resumption 恢复两次，将会发生什么**。

```cangjie
import stdx.effect.{Command, Resumption, DoubleResumeException}

// 定义两个效应类型：一个生成随机数，另一个发送字符串信息
class Random <: Command<Int64> {}
class Send <: Command<Unit> {
    Send(let msg: String) {}
}

main() {
    // 用 Box 包裹 Option 类型来保存 Resumption（可选，因为 handler 可能不会执行）
    let res: Box<Option<Resumption<Int64, Unit>>> = Box(None)

    // 第一次 perform Random 效应，预期由 handler 捕获
    try {
        let x = perform Random()
        println("Got random number ${x}")
    } handle(_: Random, next: Resumption<Int64, Unit>) {
        // 保存被挂起的 continuation
        res.value = next
    }

    println("Exited try block")

    // 手动恢复 resumption，并传入 42 作为效应的返回值
    resume res.value.getOrThrow() with 42

    // 尝试再次恢复同一个 resumption，将触发异常
    try {
        resume res.value.getOrThrow() with 43
    } catch(_: DoubleResumeException) {
        println("Attempting to resume a Resumption twice")
    }
}
```

### 执行输出：

```text
Exited try block
Got random number 42
Attempting to resume a Resumption twice
```
