# 接口

## interface CookieJar

```cangjie
public interface CookieJar {
    prop isHttp: Bool
    prop rejectPublicSuffixes: ArrayList<String>
    static func createDefaultCookieJar(rejectPublicSuffixes: ArrayList<String>, isHttp: Bool): CookieJar
    static func parseSetCookieHeader(response: HttpResponse): ArrayList<Cookie>
    static func toCookieString(cookies: ArrayList<Cookie>): String
    func clear(): Unit
    func getCookies(url: URL): ArrayList<Cookie>
    func removeCookies(domain: String): Unit
    func storeCookies(url: URL, cookies: ArrayList<Cookie>): Unit
}
```

功能：[CookieJar](http_package_interfaces.md#interface-cookiejar) 是 [Client](http_package_classes.md#class-client) 用来管理 [Cookie](http_package_classes.md#class-cookie) 的工具。

其有两个静态函数：

- [toCookieString](#static-func-tocookiestringarraylistcookie) 用于将 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 转成字符串以便设置请求的 [Cookie](http_package_classes.md#class-cookie) header。
- [parseSetCookieHeader](#static-func-parsesetcookieheaderhttpresponse) 用于解析收到 response 中的 `Set-Cookie` header。

如果 [Client](http_package_classes.md#class-client) 配置了 [CookieJar](http_package_interfaces.md#interface-cookiejar)，那么 [Cookie](http_package_classes.md#class-cookie) 的解析收发都是自动的。

> **说明**
>
> - 用户可以实现自己的 [CookieJar](http_package_interfaces.md#interface-cookiejar)，实现自己的管理逻辑。
> - [CookieJar](http_package_interfaces.md#interface-cookiejar) 的管理要求见 [RFC 6265](https://httpwg.org/specs/rfc6265.html)。

### prop isHttp

```cangjie
prop isHttp: Bool
```

功能：该 [CookieJar](http_package_interfaces.md#interface-cookiejar) 是否用于 HTTP 协议。

- 若 isHttp 为 true， 则只会存储来自于 HTTP 协议的 [Cookie](http_package_classes.md#class-cookie)。
- 若 isHttp 为 false， 则只会存储来自非 HTTP 协议的 [Cookie](http_package_classes.md#class-cookie)，且不会存储发送设置了 httpOnly 的 [Cookie](http_package_classes.md#class-cookie)。

类型：Bool

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*

main() {
    let jarHttp = CookieJar.createDefaultCookieJar(ArrayList<String>(), true)
    let jarNonHttp = CookieJar.createDefaultCookieJar(ArrayList<String>(), false)

    println("jarHttp.isHttp = ${jarHttp.isHttp}")
    println("jarNonHttp.isHttp = ${jarNonHttp.isHttp}")

    // 用 storeCookies 的行为验证 isHttp 的作用
    let uHttp = URL.parse("http://example.com/")
    let uWs = URL.parse("ws://example.com/")
    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("sid", "1"))

    jarHttp.storeCookies(uHttp, cookies)
    jarHttp.storeCookies(uWs, cookies) // 非 http scheme，应忽略
    jarNonHttp.storeCookies(uWs, cookies)
    jarNonHttp.storeCookies(uHttp, cookies) // http scheme，应忽略

    println("jarHttp@http = ${CookieJar.toCookieString(jarHttp.getCookies(uHttp))}")
    println("jarHttp@ws = ${CookieJar.toCookieString(jarHttp.getCookies(uWs))}")
    println("jarNonHttp@ws = ${CookieJar.toCookieString(jarNonHttp.getCookies(uWs))}")
    println("jarNonHttp@http = ${CookieJar.toCookieString(jarNonHttp.getCookies(uHttp))}")
}
```

运行结果：

```text
jarHttp.isHttp = true
jarNonHttp.isHttp = false
jarHttp@http = sid=1
jarHttp@ws = 
jarNonHttp@ws = sid=1
jarNonHttp@http = 
```

### prop rejectPublicSuffixes

```cangjie
prop rejectPublicSuffixes: ArrayList<String>
```

功能：获取 [public suffixes](https://publicsuffix.org/) 配置，该配置是一个 domain 黑名单，会拒绝 domain 值为 public suffixes 的 [Cookie](http_package_classes.md#class-cookie)。

> **说明：**
>
> 如果该 [Cookie](http_package_classes.md#class-cookie) 来自于与 domain 相同的 host，黑名单就不会生效。

类型：ArrayList\<String>

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*

main() {
    let rejects = ArrayList<String>()
    rejects.add("com")
    let jar = CookieJar.createDefaultCookieJar(rejects, true)

    // 当前属性：rejectPublicSuffixes
    println("rejects.size = ${jar.rejectPublicSuffixes.size}")

    // domain = "com" 属于 public suffix 黑名单，将被拒绝
    let url = URL.parse("http://sub.example.com/")
    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("ps", "1", domain: "com", path: "/"))
    jar.storeCookies(url, cookies)

    let got = jar.getCookies(url)
    println("stored.count = ${got.size}")
    println("stored.cookie = ${CookieJar.toCookieString(got)}")
}
```

运行结果：

```text
rejects.size = 1
stored.count = 0
stored.cookie = 
```

### static func createDefaultCookieJar(ArrayList\<String>, Bool)

```cangjie
static func createDefaultCookieJar(rejectPublicSuffixes: ArrayList<String>, isHttp: Bool): CookieJar
```

功能：构建默认的管理 [Cookie](http_package_classes.md#class-cookie) 的 [CookieJar](http_package_interfaces.md#interface-cookiejar) 实例。

默认的 [CookieJar](http_package_interfaces.md#interface-cookiejar) 的管理要求参考 [RFC 6265 5.3.](https://httpwg.org/specs/rfc6265.html#storage-model)。

参数：

- rejectPublicSuffixes: ArrayList\<String> - 用户配置的 public suffixes，[Cookie](http_package_classes.md#class-cookie) 管理为了安全会拒绝 domain 值为 public suffixes 的 cookie（除非该 [Cookie](http_package_classes.md#class-cookie) 来自于与 domain 相同的 host），public suffixes 见 [PUBLIC SUFFIX LIST](https://publicsuffix.org/)。
- isHttp: Bool - 该 [CookieJar](http_package_interfaces.md#interface-cookiejar) 是否用于 HTTP 协议，isHttp 为 true 则只会存储来自于 HTTP 协议的 [Cookie](http_package_classes.md#class-cookie)。

返回值：

- [CookieJar](http_package_interfaces.md#interface-cookiejar) - 默认的 [CookieJar](http_package_interfaces.md#interface-cookiejar) 实例。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import std.collection.*

main() {
    // 重点函数：CookieJar.createDefaultCookieJar
    let rejects = ArrayList<String>()
    rejects.add("invalid")
    let jar = CookieJar.createDefaultCookieJar(rejects, true)

    println("isHttp = ${jar.isHttp}")
    println("rejects.size = ${jar.rejectPublicSuffixes.size}")
    println("rejects[0] = ${jar.rejectPublicSuffixes[0]}")
}
```

运行结果：

```text
isHttp = true
rejects.size = 1
rejects[0] = invalid
```

### static func parseSetCookieHeader(HttpResponse)

```cangjie
static func parseSetCookieHeader(response: HttpResponse): ArrayList<Cookie>
```

功能：解析 response 中的 `Set-Cookie` header。

该函数解析 response 中的 `Set-Cookie` header，并返回解析出的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)>，解析 `Set-Cookie` header 的具体规则见 [RFC 6265 5.2.](https://httpwg.org/specs/rfc6265.html#set-cookie)。

参数：

- response: [HttpResponse](http_package_classes.md#class-httpresponse) - 所需要解析的 response。

返回值：

- ArrayList\<[Cookie](http_package_classes.md#class-cookie)> - 从 response 中解析出的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 数组。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    // 重点函数：CookieJar.parseSetCookieHeader
    let req = HttpRequestBuilder().url("http://example.com/").build()
    let resp = HttpResponseBuilder()
        .status(200)
        .request(req)
        .header("Set-Cookie", "a=1")
        .header("Set-Cookie", "b=2; Path=/")
        .build()

    let cookies = CookieJar.parseSetCookieHeader(resp)
    println("count = ${cookies.size}")
    println("cookie = ${CookieJar.toCookieString(cookies)}")
}
```

运行结果：

```text
count = 2
cookie = a=1; b=2
```

### static func toCookieString(ArrayList\<Cookie>)

```cangjie
static func toCookieString(cookies: ArrayList<Cookie>): String
```

功能：将 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 转成字符串，用于 [Cookie](http_package_classes.md#class-cookie) header。

该函数会将传入的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 数组转成协议规定的 [Cookie](http_package_classes.md#class-cookie) header 的字符串形式，见 [RFC 6265 5.4.4.](https://httpwg.org/specs/rfc6265.html#cookie)。

参数：

- cookies: ArrayList\<[Cookie](http_package_classes.md#class-cookie)> - 所需转成 [Cookie](http_package_classes.md#class-cookie) header 字符串的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)>。

返回值：

- String - 用于 [Cookie](http_package_classes.md#class-cookie) header 的字符串。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import std.collection.*

main() {
    // 重点函数：CookieJar.toCookieString
    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("a", "1"))
    cookies.add(Cookie("b", "2"))
    println("cookie = ${CookieJar.toCookieString(cookies)}")
}
```

运行结果：

```text
cookie = a=1; b=2
```

### func clear()

```cangjie
func clear(): Unit
```

功能：清除全部 [Cookie](http_package_classes.md#class-cookie)。

默认实现 CookieJarImpl 会清除 [CookieJar](http_package_interfaces.md#interface-cookiejar) 中的所有 [Cookie](http_package_classes.md#class-cookie)。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*

main() {
    let jar = CookieJar.createDefaultCookieJar(ArrayList<String>(), true)
    let url = URL.parse("http://example.com/")

    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("x", "1"))
    jar.storeCookies(url, cookies)

    println("before = ${CookieJar.toCookieString(jar.getCookies(url))}")
    // 重点函数：clear
    jar.clear()
    println("after = ${CookieJar.toCookieString(jar.getCookies(url))}")
}
```

运行结果：

```text
before = x=1
after = 
```

### func getCookies(URL)

```cangjie
func getCookies(url: URL): ArrayList<Cookie>
```

功能：从 [CookieJar](http_package_interfaces.md#interface-cookiejar) 中取出 ArrayList\<[Cookie](http_package_classes.md#class-cookie)>。

> 默认实现 cookieJarImpl 的取 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 函数的具体要求见 [RFC 6265 5.4.](https://httpwg.org/specs/rfc6265.html#cookie)，对取出的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 调用 toCookieString 可以将取出的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 转成 [Cookie](http_package_classes.md#class-cookie) header 的 value 字符串。

参数：

- url: [URL](../../../encoding/url/url_package_api/url_package_classes.md#class-url) - 所要取出 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 的 url。

返回值：

- ArrayList\<[Cookie](http_package_classes.md#class-cookie)> - [CookieJar](http_package_interfaces.md#interface-cookiejar) 中存储的对应此 url 的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)>。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*

main() {
    let jar = CookieJar.createDefaultCookieJar(ArrayList<String>(), true)
    let url = URL.parse("http://example.com/")

    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("k", "v"))
    jar.storeCookies(url, cookies)

    // 重点函数：getCookies
    let got = jar.getCookies(url)
    println("count = ${got.size}")
    println("cookie = ${CookieJar.toCookieString(got)}")
}
```

运行结果：

```text
count = 1
cookie = k=v
```

### func removeCookies(String)

```cangjie
func removeCookies(domain: String): Unit
```

功能：从 [CookieJar](http_package_interfaces.md#interface-cookiejar) 中移除某个 domain 的 [Cookie](http_package_classes.md#class-cookie)。

> **说明：**
>
> 默认实现 CookieJarImpl 的移除某个 domain 的 [Cookie](http_package_classes.md#class-cookie) 只会移除特定 domain 的 [Cookie](http_package_classes.md#class-cookie)，domain 的 subdomain 的 [Cookie](http_package_classes.md#class-cookie) 并不会移除。

参数：

- domain: String - 所要移除 [Cookie](http_package_classes.md#class-cookie) 的域名。

异常：

- IllegalArgumentException - 如果传入的 domain 为空字符串或者非法，则抛出该异常，合法的 domain 规则见 [Cookie](http_package_classes.md#class-cookie) 的参数文档。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*

main() {
    let jar = CookieJar.createDefaultCookieJar(ArrayList<String>(), true)
    let url = URL.parse("http://example.com/")

    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("x", "1"))
    jar.storeCookies(url, cookies)

    println("before = ${CookieJar.toCookieString(jar.getCookies(url))}")
    // 重点函数：removeCookies
    jar.removeCookies("example.com")
    println("after = ${CookieJar.toCookieString(jar.getCookies(url))}")
}
```

运行结果：

```text
before = x=1
after = 
```

### func storeCookies(URL, ArrayList\<Cookie>)

```cangjie
func storeCookies(url: URL, cookies: ArrayList<Cookie>): Unit
```

功能：将 ArrayList\<[Cookie](http_package_classes.md#class-cookie)> 存进 [CookieJar](http_package_interfaces.md#interface-cookiejar)。

如果往 [CookieJar](http_package_interfaces.md#interface-cookiejar) 中存 [Cookie](http_package_classes.md#class-cookie) 时超过了上限（3000 条），那么至少清除 [CookieJar](http_package_interfaces.md#interface-cookiejar) 中 1000 条 [Cookie](http_package_classes.md#class-cookie) 再往里存储。清除 [CookieJar](http_package_interfaces.md#interface-cookiejar) 中 [Cookie](http_package_classes.md#class-cookie) 的优先级见 [RFC 6265 5.3.12.](https://httpwg.org/specs/rfc6265.html#storage-model)。

[Cookie](http_package_classes.md#class-cookie)按如下顺序清除：

- 过期的 [Cookie](http_package_classes.md#class-cookie)；
- 相同 domain 中超过 50 条以上的部分；
- 所有 [Cookie](http_package_classes.md#class-cookie)具有相同优先级的 [Cookie](http_package_classes.md#class-cookie) 则优先删除 `last-access` 属性更早的。

参数：

- url: [URL](../../../encoding/url/url_package_api/url_package_classes.md#class-url) - 产生该 [Cookie](http_package_classes.md#class-cookie) 的 url。
- cookies: ArrayList\<[Cookie](http_package_classes.md#class-cookie)> - 需要存储的 ArrayList\<[Cookie](http_package_classes.md#class-cookie)>。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.encoding.url.*
import std.collection.*

main() {
    let jar = CookieJar.createDefaultCookieJar(ArrayList<String>(), true)
    let url = URL.parse("http://example.com/")

    // 重点函数：storeCookies
    let cookies = ArrayList<Cookie>()
    cookies.add(Cookie("sid", "abc"))
    jar.storeCookies(url, cookies)

    println("stored = ${CookieJar.toCookieString(jar.getCookies(url))}")
}
```

运行结果：

```text
stored = sid=abc
```

## interface HttpRequestDistributor

```cangjie
public interface HttpRequestDistributor {
    func register(path: String, handler: HttpRequestHandler): Unit
    func register(path: String, handler: (HttpContext) -> Unit): Unit
    func distribute(path: String): HttpRequestHandler
}
```

功能：Http request 分发器接口，将一个 request 按照 url 中的 path 分发给对应的 [HttpRequestHandler](http_package_interfaces.md#interface-httprequesthandler) 处理。

> **说明：**
>
> 本实现提供一个默认的 [HttpRequestDistributor](http_package_interfaces.md#interface-httprequestdistributor)，该 distributor 非线程安全。
> 且只能在启动 server 前 register，启动后再次 register，结果未定义。
> 如果用户希望在启动 server 后还能够 register，需要自己提供一个线程安全的 [HttpRequestDistributor](http_package_interfaces.md#interface-httprequestdistributor) 实现。

### func distribute(String)

```cangjie
func distribute(path: String): HttpRequestHandler
```

功能：分发请求处理器，未找到对应请求处理器时，将返回 [NotFoundHandler](http_package_classes.md#class-notfoundhandler) 以返回 404 状态码。

参数：

- path: String - 请求路径。

返回值：

- [HttpRequestHandler](http_package_interfaces.md#interface-httprequesthandler) - 返回请求处理器。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    let d: HttpRequestDistributor = ServerBuilder().addr("127.0.0.1").port(0).build().distributor

    // 先注册一个 handler，再用 distribute 按 path 取回。
    d.register("/a", FuncHandler({ _ => }))

    let h1 = d.distribute("/a")
    let isFunc = (h1 as FuncHandler).isSome()

    let h2 = d.distribute("/missing")
    let isNotFound = (h2 as NotFoundHandler).isSome()

    println("isFuncHandler = ${isFunc}")
    println("isNotFoundHandler = ${isNotFound}")
}
```

运行结果：

```text
isFuncHandler = true
isNotFoundHandler = true
```

### func register(String, (HttpContext) -> Unit)

```cangjie
func register(path: String, handler: (HttpContext) -> Unit): Unit
```

功能：注册请求处理器。

参数：

- path: String - 请求路径。
- handler: ([HttpContext](http_package_classes.md#class-httpcontext)) ->Unit - 请求处理函数。

异常：

- [HttpException](http_package_exceptions.md#class-httpexception) - 请求路径已注册请求处理器。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

main() {
    let d: HttpRequestDistributor = ServerBuilder().addr("127.0.0.1").port(0).build().distributor

    // 重点函数：register(path, (HttpContext) -> Unit)
    d.register("/b", { _ => })

    let h = d.distribute("/b")
    println("isFuncHandler = ${(h as FuncHandler).isSome()}")
}
```

运行结果：

```text
isFuncHandler = true
```

### func register(String, HttpRequestHandler)

```cangjie
func register(path: String, handler: HttpRequestHandler): Unit
```

功能：注册请求处理器。

参数：

- path: String - 请求路径。
- handler: [HttpRequestHandler](http_package_interfaces.md#interface-httprequesthandler) - 请求处理器。

异常：

- [HttpException](http_package_exceptions.md#class-httpexception) - 请求路径已注册请求处理器。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*

class MyHandler <: HttpRequestHandler {
    public func handle(ctx: HttpContext): Unit {
        // 示例中不实际处理 ctx
    }
}

main() {
    let d: HttpRequestDistributor = ServerBuilder().addr("127.0.0.1").port(0).build().distributor

    // 重点函数：register(path, HttpRequestHandler)
    d.register("/c", MyHandler())

    let h = d.distribute("/c")
    println("isMyHandler = ${(h as MyHandler).isSome()}")
}
```

运行结果：

```text
isMyHandler = true
```

## interface HttpRequestHandler

```cangjie
public interface HttpRequestHandler {
    func handle(ctx: HttpContext): Unit
}
```

功能：Http request 处理器。

http server 端通过 handler 处理来自客户端的 http request；在 handler 中用户可以获取 http request 的详细信息，包括 header、body；在 handler 中，用户可以构造 http response，包括 header、body，并且可以直接发送 response 给客户端，也可交由 server 发送。

用户在构建 http server 时，需手动通过 server 的 [HttpRequestDistributor](http_package_interfaces.md#interface-httprequestdistributor) 注册一个或多个 handler，当一个客户端 http request 被接收，distributor 按照 request 中 url 的 path 分发给对应的 handler 处理。

> **注意：**
>
> 应用程序应注意 DNS 重绑定攻击，即在 handler 的处理逻辑中对 request 中的 Host 请求头的值进行合法性校验，校验该值是否为此应用程序所认可的权威主机名。

### func handle(HttpContext)

```cangjie
func handle(ctx: HttpContext): Unit
```

功能：处理 Http 请求。

参数：

- ctx: [HttpContext](http_package_classes.md#class-httpcontext) - Http 请求上下文。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.net.tcp.*
import stdx.log.*
import std.concurrent.*

class HelloHandler <: HttpRequestHandler {
    public func handle(ctx: HttpContext): Unit {
        println("handle: method=${ctx.request.method}, path=${ctx.request.url.path}")
        ctx.responseBuilder.status(200).body("OK")
    }
}

main() {
    let addr = "127.0.0.1"
    let port: UInt16 = 18142

    let ready = SyncCounter(1)

    let d = DirectDistributor()
    d.register("/hello", HelloHandler())

    let server = ServerBuilder()
        .addr(addr)
        .port(port)
        .logger(NoopLogger())
        .distributor(d)
        .afterBind({ _, _ => ready.countDown() })
        .build()

    spawn {
        server.serve()
    }

    ready.wait()

    let client = HttpClientBuilder().build()
    let resp = client.get("http://${addr}:${port}/hello")

    println("status = ${resp.status}")

    server.close()
}
```

运行结果：

```text
handle: method=GET, path=/hello
status = 200
```

## interface ProtocolServiceFactory

```cangjie
public interface ProtocolServiceFactory {
    func create(protocol: Protocol, socket: StreamingSocket): ProtocolService
}
```

功能：Http 服务实例工厂，用于生成 `ProtocolService` 实例。

[ServerBuilder](http_package_classes.md#class-serverbuilder) 提供默认的实现。默认实现可用于生成 HTTP/1.1、HTTP/2 的 `ProtocolService` 实例。

### func create(Protocol, StreamingSocket)

```cangjie
func create(protocol: Protocol, socket: StreamingSocket): ProtocolService
```

功能：根据协议创建协议服务实例。

参数：

- protocol: [Protocol](http_package_enums.md#enum-protocol) - 协议版本，如  [HTTP1_0](./http_package_enums.md#enum-protocol)、 [HTTP1_1](./http_package_enums.md#enum-protocol)、 [HTTP2_0](./http_package_enums.md#enum-protocol)。
- socket: StreamingSocket - 来自客户端的套接字。

返回值：

- ProtocolService - 协议服务实例。

示例：

<!-- run -->
```cangjie
import stdx.net.http.*
import stdx.net.tcp.*
import std.net.*

class MyService <: ProtocolService {
    protected func serve(): Unit {}
}

class MyFactory <: ProtocolServiceFactory {
    public func create(protocol: Protocol, socket: StreamingSocket): ProtocolService {
        // 示例：当前参数 protocol/socket 均可用
        println("protocol = ${protocol}")
        socket.close()
        return MyService()
    }
}

main() {
    let addr = "127.0.0.1"
    let port: UInt16 = 18143

    let server = TcpServerSocket.bind(IPSocketAddress(addr, port))

    spawn {
        let client = TcpSocket.connect(IPSocketAddress(addr, port))
        client.close()
    }

    let socket = server.accept()

    let f: ProtocolServiceFactory = MyFactory()
    let svc = f.create(HTTP1_1, socket)

    println("service.isMyService = ${(svc as MyService).isSome()}")

    server.close()
}
```

运行结果：

```text
protocol = HTTP/1.1
service.isMyService = true
```
