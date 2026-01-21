# 枚举

## enum FileHandlerType

```cangjie
public enum FileHandlerType {
    | DownLoad
    | UpLoad
}
```

功能：用于设置 [FileHandler](http_package_classes.md#class-filehandler) 是上传还是下载模式。

### DownLoad

```cangjie
DownLoad
```

功能：设置 [FileHandler](http_package_classes.md#class-filehandler) 为下载模式。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // FileHandlerType 没有实现 ToString，这里通过 match 输出稳定文本。
    let v = FileHandlerType.DownLoad
    let s = match (v) {
        case DownLoad => "DownLoad"
        case UpLoad => "UpLoad"
    }
    println("DownLoad = ${s}")
}
```

运行结果：

```text
DownLoad = DownLoad
```

### UpLoad

```cangjie
UpLoad
```

功能：设置 [FileHandler](http_package_classes.md#class-filehandler) 为上传模式。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // FileHandlerType 没有实现 ToString，这里通过 match 输出稳定文本。
    let v = FileHandlerType.UpLoad
    let s = match (v) {
        case DownLoad => "DownLoad"
        case UpLoad => "UpLoad"
    }
    println("UpLoad = ${s}")
}
```

运行结果：

```text
UpLoad = UpLoad
```

## enum Protocol

```cangjie
public enum Protocol <: Equatable<Protocol> & ToString {
    | HTTP1_0
    | HTTP1_1
    | HTTP2_0
    | UnknownProtocol(String)
}
```

功能：定义 HTTP 协议类型枚举。

父类型：

- Equatable\<[Protocol](#enum-protocol)>
- ToString

### HTTP1_0

```cangjie
HTTP1_0
```

功能：定义 1.0 版本 HTTP 协议。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：Protocol.HTTP1_0
    println("HTTP1_0 = ${Protocol.HTTP1_0}")
}
```

运行结果：

```text
HTTP1_0 = HTTP/1.0
```

### HTTP1_1

```cangjie
HTTP1_1
```

功能：定义 1.1 版本 HTTP 协议。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：Protocol.HTTP1_1
    println("HTTP1_1 = ${Protocol.HTTP1_1}")
}
```

运行结果：

```text
HTTP1_1 = HTTP/1.1
```

### HTTP2_0

```cangjie
HTTP2_0
```

功能：定义 2.0 版本 HTTP 协议。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：Protocol.HTTP2_0
    println("HTTP2_0 = ${Protocol.HTTP2_0}")
}
```

运行结果：

```text
HTTP2_0 = HTTP/2.0
```

### UnknownProtocol(String)

```cangjie
UnknownProtocol(String)
```

功能：定义未知 HTTP 协议。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：Protocol.UnknownProtocol(String)
    let unk = Protocol.UnknownProtocol("HTTP/9.9")
    println("Unknown = ${unk}")
}
```

运行结果：

```text
Unknown = HTTP/9.9
```

### func toString()

```cangjie
public override func toString(): String
```

功能：获取 Http 协议版本字符串。

返回值：

- String - Http 协议版本字符串。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点函数：Protocol.toString()
    println("HTTP1_1.toString = ${Protocol.HTTP1_1.toString()}")
}
```

运行结果：

```text
HTTP1_1.toString = HTTP/1.1
```

### operator func != (Protocol)

```cangjie
public override operator func !=(that: Protocol): Bool
```

功能：判断枚举值是否不相等。

参数：

- that: [Protocol](http_package_enums.md#enum-protocol) - 被比较的枚举值。

返回值：

- Bool - 当前实例与 `that` 不等，返回 `true`；否则返回 `false`。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点运算符：!=
    println("HTTP1_1!=HTTP2_0 = ${Protocol.HTTP1_1 != Protocol.HTTP2_0}")
}
```

运行结果：

```text
HTTP1_1!=HTTP2_0 = true
```

### operator func == (Protocol)

```cangjie
public override operator func ==(that: Protocol): Bool
```

功能：判断枚举值是否相等。

参数：

- that: [Protocol](http_package_enums.md#enum-protocol) - 被比较的枚举值。

返回值：

- Bool - 当前实例与 `that` 相等，返回 `true`；否则返回 `false`。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点运算符：==
    println("HTTP1_1==HTTP1_1 = ${Protocol.HTTP1_1 == Protocol.HTTP1_1}")
}
```

运行结果：

```text
HTTP1_1==HTTP1_1 = true
```

## enum WebSocketFrameType

```cangjie
public enum WebSocketFrameType <: Equatable<WebSocketFrameType> & ToString {
    | ContinuationWebFrame
    | TextWebFrame
    | BinaryWebFrame
    | CloseWebFrame
    | PingWebFrame
    | PongWebFrame
    | UnknownWebFrame
}
```

功能：定义 [WebSocketFrame](http_package_classes.md#class-websocketframe) 的枚举类型。

父类型：

- Equatable\<[WebSocketFrameType](#enum-websocketframetype)>
- ToString

### ContinuationWebFrame

```cangjie
ContinuationWebFrame
```

功能：定义 websocket 协议中的未结束的分片帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.ContinuationWebFrame
    println("Continuation = ${WebSocketFrameType.ContinuationWebFrame}")
}
```

运行结果：

```text
Continuation = ContinuationWebFrame
```

### TextWebFrame

```cangjie
TextWebFrame
```

功能：定义 websocket 协议中的文本帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.TextWebFrame
    println("Text = ${WebSocketFrameType.TextWebFrame}")
}
```

运行结果：

```text
Text = TextWebFrame
```

### BinaryWebFrame

```cangjie
BinaryWebFrame
```

功能：定义 websocket 协议中的数据帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.BinaryWebFrame
    println("Binary = ${WebSocketFrameType.BinaryWebFrame}")
}
```

运行结果：

```text
Binary = BinaryWebFrame
```

### CloseWebFrame

```cangjie
CloseWebFrame
```

功能：定义 websocket 协议中的关闭帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.CloseWebFrame
    println("Close = ${WebSocketFrameType.CloseWebFrame}")
}
```

运行结果：

```text
Close = CloseWebFrame
```

### PingWebFrame

```cangjie
PingWebFrame
```

功能：定义 websocket 协议中的心跳帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.PingWebFrame
    println("Ping = ${WebSocketFrameType.PingWebFrame}")
}
```

运行结果：

```text
Ping = PingWebFrame
```

### PongWebFrame

```cangjie
PongWebFrame
```

功能：定义 websocket 协议中的心跳帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.PongWebFrame
    println("Pong = ${WebSocketFrameType.PongWebFrame}")
}
```

运行结果：

```text
Pong = PongWebFrame
```

### UnknownWebFrame

```cangjie
UnknownWebFrame
```

功能：定义 websocket 协议中的未知类型帧。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 当前枚举值：WebSocketFrameType.UnknownWebFrame
    println("Unknown = ${WebSocketFrameType.UnknownWebFrame}")
}
```

运行结果：

```text
Unknown = UnknownWebFrame
```

### func toString()

```cangjie
public override func toString(): String
```

功能：获取 [WebSocket](http_package_classes.md#class-websocket) 帧类型字符串。

返回值：

- String - [WebSocket](http_package_classes.md#class-websocket) 帧类型字符串。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点函数：WebSocketFrameType.toString()
    println("Text.toString = ${WebSocketFrameType.TextWebFrame.toString()}")
}
```

运行结果：

```text
Text.toString = TextWebFrame
```

### operator func != (WebSocketFrameType)

```cangjie
public override operator func !=(that: WebSocketFrameType): Bool
```

功能：判断枚举值是否不相等。

参数：

- that: [WebSocketFrameType](http_package_enums.md#enum-websocketframetype) - 被比较的枚举值。

返回值：

- Bool - 当前实例与 `that` 不等返回 `true`，否则返回 `false`。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点运算符：!=
    println("Text!=Binary = ${WebSocketFrameType.TextWebFrame != WebSocketFrameType.BinaryWebFrame}")
}
```

运行结果：

```text
Text!=Binary = true
```

### operator func == (WebSocketFrameType)

```cangjie
public override operator func ==(that: WebSocketFrameType): Bool
```

功能：判断枚举值是否相等。

参数：

- that: [WebSocketFrameType](http_package_enums.md#enum-websocketframetype) - 被比较的枚举值。

返回值：

- Bool - 当前实例与 `that` 相等返回 `true`，否则返回 `false`。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点运算符：==
    println("Text==Text = ${WebSocketFrameType.TextWebFrame == WebSocketFrameType.TextWebFrame}")
}
```

运行结果：

```text
Text==Text = true
```
