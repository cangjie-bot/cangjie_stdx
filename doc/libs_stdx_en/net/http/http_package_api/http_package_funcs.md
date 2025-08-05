# Functions

## func handleError(HttpContext, UInt16)

```cangjie
public func handleError(ctx: HttpContext, code: UInt16): Unit
```

Function: A convenient HTTP request handler function for responding to error requests.

Parameters:

- ctx: [HttpContext](http_package_classes.md#class-httpcontext) - HTTP request context.
- code: UInt16 - HTTP response code.

## func notFound(HttpContext)

```cangjie
public func notFound(ctx: HttpContext): Unit
```

Function: A convenient HTTP request handler function for responding with 404 status.

Parameters:

- ctx: [HttpContext](http_package_classes.md#class-httpcontext) - HTTP request context.

## func upgrade(HttpContext)

```cangjie
public func upgrade(ctx: HttpContext): StreamingSocket
```

Function: Obtains a StreamingSocket within the handler, which can be used to support protocol upgrades and handle CONNECT requests.

> - When calling this function, it will first send a response based on ctx.responseBuilder, including only the status code and response headers.
> - When calling this function, it will empty ctx.request.body, making subsequent body.read(...) operations impossible. Any unread body data will remain in the returned StreamingSocket.

Parameters:

- ctx: [HttpContext](http_package_classes.md#class-httpcontext) - Request context.

Return Value:

- StreamingSocket - The underlying connection (a stream for HTTP/2), which can be used for subsequent read/write operations.

Exceptions:

- [HttpException](http_package_exceptions.md#class-httpexception) - Failed to obtain the underlying connection (a stream for HTTP/2).