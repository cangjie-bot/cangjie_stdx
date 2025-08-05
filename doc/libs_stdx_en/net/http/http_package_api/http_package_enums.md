# Enums

## enum FileHandlerType

```cangjie
public enum FileHandlerType {
    | DownLoad
    | UpLoad
}
```

Function: Specifies whether the [FileHandler](http_package_classes.md#class-filehandler) operates in upload or download mode.

### DownLoad

```cangjie
DownLoad
```

Function: Sets the [FileHandler](http_package_classes.md#class-filehandler) to download mode.

### UpLoad

```cangjie
UpLoad
```

Function: Sets the [FileHandler](http_package_classes.md#class-filehandler) to upload mode.

## enum Protocol

```cangjie
public enum Protocol <: Equatable<Protocol> & ToString {
    | HTTP1_0
    | HTTP1_1
    | HTTP2_0
    | UnknownProtocol(String)
}
```

Function: Defines HTTP protocol type enumeration.

Parent types:

- Equatable\<[Protocol](#enum-protocol)>
- ToString

### HTTP1_0

```cangjie
HTTP1_0
```

Function: Defines HTTP protocol version 1.0.

### HTTP1_1

```cangjie
HTTP1_1
```

Function: Defines HTTP protocol version 1.1.

### HTTP2_0

```cangjie
HTTP2_0
```

Function: Defines HTTP protocol version 2.0.

### UnknownProtocol(String)

```cangjie
UnknownProtocol(String)
```

Function: Defines unknown HTTP protocol.

### func toString()

```cangjie
public override func toString(): String
```

Function: Gets the HTTP protocol version string.

Return value:

- String - HTTP protocol version string.

### operator func != (Protocol)

```cangjie
public override operator func !=(that: Protocol): Bool
```

Function: Determines whether enum values are unequal.

Parameters:

- that: [Protocol](http_package_enums.md#enum-protocol) - The enum value to compare.

Return value:

- Bool - Returns `true` if the current instance is not equal to `that`; otherwise returns `false`.

### operator func == (Protocol)

```cangjie
public override operator func ==(that: Protocol): Bool
```

Function: Determines whether enum values are equal.

Parameters:

- that: [Protocol](http_package_enums.md#enum-protocol) - The enum value to compare.

Return value:

- Bool - Returns `true` if the current instance is equal to `that`; otherwise returns `false`.

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

Function: Defines the enumeration type for [WebSocketFrame](http_package_classes.md#class-websocketframe).

Parent types:

- Equatable\<[WebSocketFrameType](#enum-websocketframetype)>
- ToString

### ContinuationWebFrame

```cangjie
ContinuationWebFrame
```

Function: Defines a non-final fragment frame in the WebSocket protocol.

### TextWebFrame

```cangjie
TextWebFrame
```

Function: Defines a text frame in the WebSocket protocol.

### BinaryWebFrame

```cangjie
BinaryWebFrame
```

Function: Defines a data frame in the WebSocket protocol.

### CloseWebFrame

```cangjie
CloseWebFrame
```

Function: Defines a close frame in the WebSocket protocol.

### PingWebFrame

```cangjie
PingWebFrame
```

Function: Defines a heartbeat frame in the WebSocket protocol.

### PongWebFrame

```cangjie
PongWebFrame
```

Function: Defines a heartbeat frame in the WebSocket protocol.

### UnknownWebFrame

```cangjie
UnknownWebFrame
```

Function: Defines an unknown type frame in the WebSocket protocol.

### func toString()

```cangjie
public override func toString(): String
```

Function: Gets the [WebSocket](http_package_classes.md#class-websocket) frame type string.

Return value:

- String - [WebSocket](http_package_classes.md#class-websocket) frame type string.

### operator func != (WebSocketFrameType)

```cangjie
public override operator func !=(that: WebSocketFrameType): Bool
```

Function: Determines whether enum values are unequal.

Parameters:

- that: [WebSocketFrameType](http_package_enums.md#enum-websocketframetype) - The enum value to compare.

Return value:

- Bool - Returns `true` if the current instance is not equal to `that`; otherwise returns `false`.

### operator func == (WebSocketFrameType)

```cangjie
public override operator func ==(that: WebSocketFrameType): Bool
```

Function: Determines whether enum values are equal.

Parameters:

- that: [WebSocketFrameType](http_package_enums.md#enum-websocketframetype) - The enum value to compare.

Return value:

- Bool - Returns `true` if the current instance is equal to `that`; otherwise returns `false`.