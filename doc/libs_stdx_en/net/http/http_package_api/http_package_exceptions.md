# Exception Classes

## class ConnectionException

```cangjie
public class ConnectionException <: IOException {
    public init(message: String)
}
```

Function: TCP connection exception class for HTTP.

Parent Types:

- IOException

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [ConnectionException](http_package_exceptions.md#class-connectionexception) instance.

Parameters:

- message: String - Exception message.

## class CoroutinePoolRejectException

```cangjie
public class CoroutinePoolRejectException <: Exception {
    public init(message: String)
}
```

Function: Coroutine pool rejection exception class for HTTP requests.

Parent Types:

- Exception

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [CoroutinePoolRejectException](http_package_exceptions.md#class-coroutinepoolrejectexception) instance.

Parameters:

- message: String - Exception message.

## class HttpException

```cangjie
public class HttpException <: Exception {
    public init(message: String)
}
```

Function: Generic exception class for HTTP.

Parent Types:

- Exception

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [HttpException](http_package_exceptions.md#class-httpexception) instance.

Parameters:

- message: String - Exception message.

## class HttpStatusException

```cangjie
public class HttpStatusException <: Exception {
    public init(statusCode: UInt16, message: String)
}
```

Function: HTTP response status exception class.

Parent Types:

- Exception

### init(UInt16, String)

```cangjie
public init(statusCode: UInt16, message: String)
```

Function: Creates a [HttpStatusException](http_package_exceptions.md#class-httpstatusexception) instance.

Parameters:

- statusCode: UInt16 - Status code.
- message: String - Exception message.

## class HttpTimeoutException

```cangjie
public class HttpTimeoutException <: Exception {
    public init(message: String)
}
```

Function: HTTP timeout exception class.

Parent Types:

- Exception

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [HttpTimeoutException](http_package_exceptions.md#class-httptimeoutexception) instance.

Parameters:

- message: String - Exception message.

## class WebSocketException

```cangjie
public class WebSocketException <: Exception {
    public init(message: String)
}
```

Function: Generic exception class for [WebSocket](http_package_classes.md#class-websocket).

Parent Types:

- Exception

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [WebSocketException](http_package_exceptions.md#class-websocketexception) instance.

Parameters:

- message: String - Exception message.